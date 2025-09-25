import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  static late SupabaseClient client;

  static Future<void> init() async {
    await Supabase.initialize(
      url: 'https://myrkwsciirxmjisigbgq.supabase.co', // 👈 coma aquí
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im15cmt3c2NpaXJ4bWppc2lnYmdxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTg3NTI3MTYsImV4cCI6MjA3NDMyODcxNn0.xfb2OgMmQa4nq9N5XWiadU5TbxGaKfrB-eWQm19Jl1I',
    );
    client = Supabase.instance.client;
  }
}
