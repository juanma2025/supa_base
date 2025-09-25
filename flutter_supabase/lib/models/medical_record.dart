class MedicalRecord {
  final String id;
  final String userId;
  final String symptom;
  final String medication;
  final DateTime date;

  MedicalRecord({
    required this.id,
    required this.userId,
    required this.symptom,
    required this.medication,
    required this.date,
  });

  factory MedicalRecord.fromMap(Map<String, dynamic> map) {
    return MedicalRecord(
      id: map['id'] as String,
      userId: map['user_id'] as String,
      symptom: map['symptom'] as String,
      medication: map['medication'] as String,
      date: DateTime.parse(map['date'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'symptom': symptom,
      'medication': medication,
      'date': date.toIso8601String(),
    };
  }
}
