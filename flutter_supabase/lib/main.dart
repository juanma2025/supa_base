import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/supabase_config.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'pages/home_page.dart';
import 'pages/add_record_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializar Supabase antes de arrancar la app
  await SupabaseConfig.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Verificar si el usuario ya tiene sesión iniciada
    final session = SupabaseConfig.client.auth.currentSession;

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Médica',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      home: session != null ? HomePage() : const LoginPage(),
      getPages: [
        GetPage(name: '/login', page: () => const LoginPage()),
        GetPage(name: '/register', page: () => const RegisterPage()),
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(
          name: '/add',
          page: () {
            final session = SupabaseConfig.client.auth.currentSession;
            final userId = session?.user.id ?? '';
            return AddRecordPage(userId: userId);
          },
        ),
      ],
    );
  }
}