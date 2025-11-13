import 'package:flutter/material.dart';
import '../../database/database_helper.dart';
import '../../services/inference_engine.dart';
import 'result_screen.dart';

class QuestionnaireScreen extends StatefulWidget {
  final int userId;

  const QuestionnaireScreen({Key? key, required this.userId}) : super(key: key);

  @override
  State<QuestionnaireScreen> createState() => _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreen> {
  List<Map<String, dynamic>> symptoms = [];
  Map<int, double> userAnswers = {}; // symptom_id => cf_user (0.0 - 1.0)
  int currentIndex = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadSymptoms();
  }

  Future<void> loadSymptoms() async {
    final db = await DatabaseHelper().database;
    final data = await db.query('symptoms');
    setState(() {
      symptoms = data;
      isLoading = false;
    });
  }

  void nextQuestion() {
    if (currentIndex < symptoms.length - 1) {
      setState(() {
        currentIndex++;
      });
    } else {
      // Semua pertanyaan selesai, proses hasil
      processResults();
    }
  }

  void previousQuestion() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
      });
    }
  }

  Future<void> processResults() async {
    // Tampilkan loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    // Proses inference engine
    final result = await InferenceEngine.processConsultation(userAnswers);

    // Simpan hasil ke database
    final db = await DatabaseHelper().database;
    int consultationId = await db.insert('consultations', {
      'user_id': widget.userId,
      'consultation_date': DateTime.now().toIso8601String(),
      'final_diagnosis_id': result['diagnosis_id'],
      'final_cf': result['final_cf'],
      'recommendation': result['recommendation'],
    });

    // Simpan jawaban user
    for (var entry in userAnswers.entries) {
      await db.insert('user_answers', {
        'consultation_id': consultationId,
        'symptom_id': entry.key,
        'cf_user': entry.value,
      });
    }

    // Tutup loading
    Navigator.pop(context);

    // Navigasi ke hasil
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ResultScreen(result: result)),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (symptoms.isEmpty) {
      return const Scaffold(body: Center(child: Text('Tidak ada data gejala')));
    }

    final symptom = symptoms[currentIndex];
    final symptomId = symptom['id'] as int;
    final currentCF = userAnswers[symptomId] ?? 0.5;

    return Scaffold(
      appBar: AppBar(
        title: Text('Pertanyaan ${currentIndex + 1}/${symptoms.length}'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress Bar
            LinearProgressIndicator(
              value: (currentIndex + 1) / symptoms.length,
              backgroundColor: Colors.grey[300],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            const SizedBox(height: 30),

            // Pertanyaan
            Text(
              symptom['symptom_name'],
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              symptom['description'] ?? '',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 40),

            // Pertanyaan konfirmasi
            const Text(
              'Seberapa yakin Anda mengalami gejala ini?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 30),

            // Slider
            Column(
              children: [
                Slider(
                  value: currentCF,
                  min: 0.0,
                  max: 1.0,
                  divisions: 10,
                  label: _getCFLabel(currentCF),
                  onChanged: (value) {
                    setState(() {
                      userAnswers[symptomId] = value;
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tidak Yakin',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      Text(
                        _getCFLabel(currentCF),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Sangat Yakin',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Visual indicator
            Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: _getCFColor(currentCF).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: _getCFColor(currentCF), width: 2),
                ),
                child: Column(
                  children: [
                    Icon(
                      _getCFIcon(currentCF),
                      size: 50,
                      color: _getCFColor(currentCF),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '${(currentCF * 100).toInt()}%',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: _getCFColor(currentCF),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const Spacer(),

            // Buttons
            Row(
              children: [
                if (currentIndex > 0)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: previousQuestion,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: const Text('Sebelumnya'),
                    ),
                  ),
                if (currentIndex > 0) const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: nextQuestion,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: Text(
                      currentIndex < symptoms.length - 1
                          ? 'Selanjutnya'
                          : 'Selesai',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getCFLabel(double cf) {
    if (cf <= 0.2) return 'Sangat Tidak Yakin';
    if (cf <= 0.4) return 'Tidak Yakin';
    if (cf <= 0.6) return 'Cukup Yakin';
    if (cf <= 0.8) return 'Yakin';
    return 'Sangat Yakin';
  }

  Color _getCFColor(double cf) {
    if (cf <= 0.3) return Colors.green;
    if (cf <= 0.6) return Colors.orange;
    return Colors.red;
  }

  IconData _getCFIcon(double cf) {
    if (cf <= 0.3) return Icons.sentiment_satisfied;
    if (cf <= 0.6) return Icons.sentiment_neutral;
    return Icons.sentiment_dissatisfied;
  }
}
