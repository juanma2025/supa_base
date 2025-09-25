import 'package:get/get.dart';
import '../models/medical_record.dart';
import '../services/medical_service.dart';

class MedicalController extends GetxController {
  final MedicalService _service = MedicalService();
  var records = <MedicalRecord>[].obs;

  void subscribeRecords(String userId) {
    _service.subscribeToRecords(userId).listen((data) {
      records.assignAll(data);
    });
  }

  Future<void> addRecord(MedicalRecord record) async {
    await _service.addRecord(record);
  }
}
