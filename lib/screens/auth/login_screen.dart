import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app_for_ues/providers/auth_provider.dart';
import 'package:flutter_app_for_ues/screens/auth/register_screen.dart';
import 'package:flutter_app_for_ues/screens/home/home_screen.dart';

// Controllers tetap di luar class untuk akses mudah, meskipun lebih baik di dalam State
final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
  }); // Tambahkan key dan ubah menjadi StatefulWidget

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // 🔑 Variabel State untuk mengontrol status tampil/sembunyi kata sandi
  bool _isPasswordVisible = false;

  // Fungsi Pembantu untuk Dekorasi Input Field (Diperbarui untuk mendukung ikon mata)
  InputDecoration _inputDecoration(
    String hint,
    IconData icon, {
    bool isPassword = false,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey[400]),
      prefixIcon: Icon(icon, color: Colors.grey),

      // 👁️ Tambahkan Suffix Icon HANYA untuk Password Field
      suffixIcon: isPassword
          ? IconButton(
              icon: Icon(
                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey,
              ),
              onPressed: () {
                // Perbarui state saat ikon mata ditekan
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible; // Balik status
                });
              },
            )
          : null, // Jangan tampilkan ikon jika bukan field password

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: Color(0xFF2196F3), width: 2.0),
      ),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 10.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Selamat Datang Kembali 👋',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2196F3),
              ),
            ),
            const Text(
              'Silakan masuk untuk melanjutkan pengecekan mental Anda.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 40),

            // Field Email
            const Text('Email', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextFormField(
              controller: _emailController, // ⬅️ Dihubungkan ke Controller
              keyboardType: TextInputType.emailAddress,
              decoration: _inputDecoration('Masukkan email', Icons.email),
            ),
            const SizedBox(height: 24),

            // Field Kata Sandi
            const Text(
              'Kata Sandi',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _passwordController, // ⬅️ Dihubungkan ke Controller
              // Kontrol apakah teks disembunyikan menggunakan state _isPasswordVisible
              obscureText: !_isPasswordVisible,
              // Panggil dekorasi dengan isPassword: true untuk menampilkan ikon mata
              decoration: _inputDecoration(
                'Masukkan Kata Sandi',
                Icons.lock,
                isPassword: true,
              ),
            ),
            const SizedBox(height: 16),

            // Lupa Kata Sandi
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // Aksi Lupa Kata Sandi
                },
                child: const Text(
                  'Lupa Kata Sandi?',
                  style: TextStyle(color: Color(0xFF2196F3)),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Tombol Login
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final auth = Provider.of<AuthProvider>(
                    context,
                    listen: false,
                  );
                  bool success = await auth.login(
                    _emailController.text,
                    _passwordController.text,
                  );

                  if (success) {
                    // Berhasil Login: Ganti layar ke Home
                    // Pastikan currentUserId tidak null sebelum digunakan
                    if (auth.currentUserId != null) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              HomeScreen(userId: auth.currentUserId!),
                        ),
                      );
                    }
                  } else {
                    // Gagal Login: Tampilkan pesan error
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Email atau kata sandi salah!'),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2196F3), // Biru Primer
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Sudut membulat
                  ),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),

            // Link ke Register
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Belum punya akun? '),
                GestureDetector(
                  onTap: () {
                    // Navigasi ke Halaman Register
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'Daftar Sekarang',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2196F3), // Biru Primer
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
