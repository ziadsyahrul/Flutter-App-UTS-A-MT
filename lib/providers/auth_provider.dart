// lib/providers/auth_provider.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../database/database_helper.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  int? _currentUserId; // Menyimpan ID pengguna yang sedang login

  bool get isLoggedIn => _isLoggedIn;
  int? get currentUserId => _currentUserId;

  AuthProvider() {
    _checkLoginStatus();
  }

  // Cek status login saat aplikasi dimulai
  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    _currentUserId = prefs.getInt('currentUserId');
    notifyListeners();
  }

  // --- Fungsi Login ---
  Future<bool> login(String email, String password) async {
    final dbHelper = DatabaseHelper();
    final user = await dbHelper.getUser(email, password);

    if (user != null) {
      final prefs = await SharedPreferences.getInstance();
      _isLoggedIn = true;
      _currentUserId = user['id'] as int;

      await prefs.setBool('isLoggedIn', true);
      await prefs.setInt('currentUserId', _currentUserId!);
      notifyListeners();
      return true;
    }
    return false;
  }

  // --- Fungsi Register ---
  Future<bool> register(String name, String email, String password) async {
    final dbHelper = DatabaseHelper();
    // Diasumsikan DatabaseHelper memiliki fungsi untuk memasukkan pengguna baru
    final newId = await dbHelper.insertUser(name, email, password);

    if (newId > 0) {
      // Setelah register, langsung login
      await login(email, password);
      return true;
    }
    return false;
  }

  // --- Fungsi Logout ---
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
    await prefs.remove('currentUserId');
    _isLoggedIn = false;
    _currentUserId = null;
    notifyListeners();
  }
}
