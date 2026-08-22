class Medication {
  final String id;
  String name;
  String dosage; // e.g. "500 mg"
  String form; // e.g. "Tablet", "Capsule"
  String time; // e.g. "08:00 AM" — we'll store as simple string for now
  String note; // e.g. "Take with water", "After breakfast"
  bool isTaken;
  bool isMissed;

  Medication({
    required this.id,
    required this.name,
    required this.dosage,
    required this.form,
    required this.time,
    this.note = '',
    this.isTaken = false,
    this.isMissed = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'dosage': dosage,
      'form': form,
      'time': time,
      'note': note,
      'isTaken': isTaken,
      'isMissed': isMissed,
    };
  }

  factory Medication.fromJson(Map<String, dynamic> json) {
    return Medication(
      id: json['id'],
      name: json['name'],
      dosage: json['dosage'],
      form: json['form'],
      time: json['time'],
      note: json['note'] ?? '',
      isTaken: json['isTaken'] ?? false,
      isMissed: json['isMissed'] ?? false,
    );
  }
}