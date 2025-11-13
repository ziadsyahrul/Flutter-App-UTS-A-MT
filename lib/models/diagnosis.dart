class Diagnosis {
  final int? id;
  final String code;
  final String diagnosisName;
  final double cfMin;
  final double cfMax;
  final String? description;
  final String? recommendation;

  Diagnosis({
    this.id,
    required this.code,
    required this.diagnosisName,
    required this.cfMin,
    required this.cfMax,
    this.description,
    this.recommendation,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'code': code,
      'diagnosis_name': diagnosisName,
      'cf_min': cfMin,
      'cf_max': cfMax,
      'description': description,
      'recommendation': recommendation,
    };
  }

  factory Diagnosis.fromMap(Map<String, dynamic> map) {
    return Diagnosis(
      id: map['id'],
      code: map['code'],
      diagnosisName: map['diagnosis_name'],
      cfMin: map['cf_min'],
      cfMax: map['cf_max'],
      description: map['description'],
      recommendation: map['recommendation'],
    );
  }
}
