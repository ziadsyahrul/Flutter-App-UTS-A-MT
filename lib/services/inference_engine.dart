import 'package:flutter_app_for_ues/database/database_helper.dart';

class InferenceEngine {
  // Hitung CF Kombinasi (untuk multiple rules yang match)
  static double combineCF(double cf1, double cf2) {
    if (cf1 > 0 && cf2 > 0) {
      return cf1 + cf2 * (1 - cf1);
    } else if (cf1 < 0 && cf2 < 0) {
      return cf1 + cf2 * (1 + cf1);
    } else {
      return (cf1 + cf2) /
          (1 - [cf1.abs(), cf2.abs()].reduce((a, b) => a < b ? a : b));
    }
  }

  // Proses Forward Chaining
  static Future<Map<String, dynamic>> processConsultation(
    Map<int, double> userAnswers, // symptom_id => cf_user
  ) async {
    final db = await DatabaseHelper().database;

    // 1. Ambil semua rules
    final rulesData = await db.query('rules');

    Map<int, double> diagnosisCFs = {}; // diagnosis_id => combined_cf

    // 2. Loop setiap rule
    for (var rule in rulesData) {
      int ruleId = rule['id'] as int;
      int diagnosisId = rule['diagnosis_id'] as int;
      double cfExpert = rule['cf_expert'] as double;

      // 3. Ambil symptoms yang diperlukan rule ini
      final ruleSymptomsData = await db.query(
        'rule_symptoms',
        where: 'rule_id = ?',
        whereArgs: [ruleId],
      );

      // 4. Cek apakah semua symptom dalam rule ini ada di jawaban user
      bool allSymptomsMatch = true;
      double minCFUser = 1.0;

      for (var rs in ruleSymptomsData) {
        int symptomId = rs['symptom_id'] as int;

        if (!userAnswers.containsKey(symptomId)) {
          allSymptomsMatch = false;
          break;
        }

        // Ambil CF terkecil dari user untuk rule ini
        double cfUser = userAnswers[symptomId]!;
        if (cfUser < minCFUser) {
          minCFUser = cfUser;
        }
      }

      // 5. Jika rule match, hitung CF
      if (allSymptomsMatch && ruleSymptomsData.isNotEmpty) {
        double cfRule = minCFUser * cfExpert;

        // 6. Kombinasikan dengan CF diagnosis yang sudah ada
        if (diagnosisCFs.containsKey(diagnosisId)) {
          diagnosisCFs[diagnosisId] = combineCF(
            diagnosisCFs[diagnosisId]!,
            cfRule,
          );
        } else {
          diagnosisCFs[diagnosisId] = cfRule;
        }
      }
    }

    // 7. Tentukan diagnosis dengan CF tertinggi
    if (diagnosisCFs.isEmpty) {
      // Tidak ada rule yang match, return diagnosis default (tidak terindikasi)
      final defaultDiagnosis = await db.query(
        'diagnosis',
        where: 'id = ?',
        whereArgs: [1], // ID 1 = Tidak Terindikasi Depresi
      );

      return {
        'diagnosis_id': 1,
        'diagnosis_name': defaultDiagnosis[0]['diagnosis_name'],
        'final_cf': 0.0,
        'description': defaultDiagnosis[0]['description'],
        'recommendation': defaultDiagnosis[0]['recommendation'],
      };
    }

    // 8. Cari diagnosis dengan CF tertinggi
    int finalDiagnosisId = diagnosisCFs.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;
    double finalCF = diagnosisCFs[finalDiagnosisId]!;

    // 9. Ambil detail diagnosis
    // final diagnosisData = await db.query(
    //   'diagnosissssss',
    //   where: 'id = ?',
    //   whereArgs: [finalDiagnosisId],
    // );

    // 10. Atau tentukan berdasarkan range CF
    final allDiagnosis = await db.query('diagnosis', orderBy: 'cf_min ASC');
    Map<String, dynamic> selectedDiagnosis = allDiagnosis[0];

    for (var diag in allDiagnosis) {
      double cfMin = diag['cf_min'] as double;
      double cfMax = diag['cf_max'] as double;

      if (finalCF >= cfMin && finalCF <= cfMax) {
        selectedDiagnosis = diag;
        break;
      }
    }

    return {
      'diagnosis_id': selectedDiagnosis['id'],
      'diagnosis_name': selectedDiagnosis['diagnosis_name'],
      'final_cf': finalCF,
      'description': selectedDiagnosis['description'],
      'recommendation': selectedDiagnosis['recommendation'],
    };
  }
}
