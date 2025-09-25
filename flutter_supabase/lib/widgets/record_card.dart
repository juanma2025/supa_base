import 'package:flutter/material.dart';
import '../models/medical_record.dart';

class RecordCard extends StatelessWidget {
  final MedicalRecord record;

  const RecordCard({super.key, required this.record});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 3,
      child: ListTile(
        title: Text(record.symptom, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text("Medicación: ${record.medication}\nFecha: ${record.date.toLocal()}"),
        isThreeLine: true,
      ),
    );
  }
}
