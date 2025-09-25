import 'package:flutter/material.dart';
import '../models/medical_record.dart';
import '../services/medical_service.dart';
import 'package:uuid/uuid.dart';

class AddRecordPage extends StatefulWidget {
  final String userId;

  const AddRecordPage({super.key, required this.userId});

  @override
  State<AddRecordPage> createState() => _AddRecordPageState();
}

class _AddRecordPageState extends State<AddRecordPage> {
  final symptomController = TextEditingController();
  final medicationController = TextEditingController();
  final service = MedicalService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Agregar Registro Médico")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: symptomController, decoration: const InputDecoration(labelText: "Síntoma")),
            TextField(controller: medicationController, decoration: const InputDecoration(labelText: "Medicación")),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final record = MedicalRecord(
                  id: const Uuid().v4(),
                  userId: widget.userId,
                  symptom: symptomController.text,
                  medication: medicationController.text,
                  date: DateTime.now(),
                );
                await service.addRecord(record);
                Navigator.pop(context);
              },
              child: const Text("Guardar"),
            ),
          ],
        ),
      ),
    );
  }
}
