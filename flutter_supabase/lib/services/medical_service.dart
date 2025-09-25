import '../core/supabase_config.dart';
import '../models/medical_record.dart';

class MedicalService {
  final _client = SupabaseConfig.client;

  Future<void> addRecord(MedicalRecord record) async {
    await _client.from('medical_records').insert(record.toMap());
  }

  Stream<List<MedicalRecord>> subscribeToRecords(String userId) {
    return _client
        .from('medical_records')
        .stream(primaryKey: ['id'])
        .eq('user_id', userId)
        .map((data) => data.map((e) => MedicalRecord.fromMap(e)).toList());
  }
}
