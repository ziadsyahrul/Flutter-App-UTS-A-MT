class Symptom {
  final int? id;
  final String code;
  final String symptomName;
  final String? description;

  Symptom({
    this.id,
    required this.code,
    required this.symptomName,
    this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'code': code,
      'symptom_name': symptomName,
      'description': description,
    };
  }

  factory Symptom.fromMap(Map<String, dynamic> map) {
    return Symptom(
      id: map['id'],
      code: map['code'],
      symptomName: map['symptom_name'],
      description: map['description'],
    );
  }
}
