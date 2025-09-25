import 'package:get/get.dart';
import '../services/auth_service.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();
  var isLoggedIn = false.obs;

  String? get currentUserId => _authService.currentUserId;

  Future<void> login(String email, String password) async {
    await _authService.signIn(email, password);
    isLoggedIn.value = _authService.currentUserId != null;
  }

  Future<void> register(String email, String password) async {
    await _authService.signUp(email, password);
  }

  Future<void> logout() async {
    await _authService.signOut();
    isLoggedIn.value = false;
  }
}
