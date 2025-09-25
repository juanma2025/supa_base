import 'package:flutter/material.dart';
import '../core/supabase_config.dart';
import '../models/medical_record.dart';
import '../services/medical_service.dart';
import 'add_record_page.dart';


class HomePage extends StatelessWidget {
  final MedicalService service = MedicalService();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = SupabaseConfig.client.auth.currentUser;

    if (user == null) {
      return const Scaffold(
        body: Center(
          child: Text(
            "Usuario no autenticado",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Mis Registros Médicos",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: Colors.blue.shade600,
        actions: [
          IconButton(
            tooltip: "Cerrar sesión",
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () async {
              await SupabaseConfig.client.auth.signOut();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: StreamBuilder<List<MedicalRecord>>(
        stream: service.subscribeToRecords(user.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.blue),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error: ${snapshot.error}",
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.medical_information, size: 70, color: Colors.grey),
                  SizedBox(height: 10),
                  Text(
                    "No tienes registros médicos",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          final records = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: records.length,
            itemBuilder: (context, index) {
              final record = records[index];
              final formattedDate =
                  "${record.date.day}/${record.date.month}/${record.date.year}";

              return Container(
                margin: const EdgeInsets.symmetric(vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    )
                  ],
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue.shade100,
                    child: const Icon(Icons.healing, color: Colors.blue),
                  ),
                  title: Text(
                    record.symptom,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Text(
                    "${record.medication}\n📅 $formattedDate",
                    style: const TextStyle(height: 1.5),
                  ),
                  isThreeLine: true,
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade600,
        tooltip: "Agregar nuevo registro",
        onPressed: () {
          final user = SupabaseConfig.client.auth.currentUser;
          if (user != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => AddRecordPage(userId: user.id),
              ),
            );
          }
        },
        child: const Icon(Icons.add, size: 28),
      ),
    );
  }
}
