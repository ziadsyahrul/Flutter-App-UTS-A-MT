import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Akun'),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Color(0xFF2196F3),
        ), // Ikon back biru
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Header
            const Text(
              'Buat Akun Baru 🌟',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2196F3), // Biru Primer
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Mari kita mulai perjalanan kesehatan mental Anda.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 40),

            // Field Nama Lengkap
            const Text(
              'Nama Lengkap',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextFormField(
              keyboardType: TextInputType.name,
              decoration: _inputDecoration('Nama Anda', Icons.person),
            ),
            const SizedBox(height: 24),

            // Field Email
            const Text('Email', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: _inputDecoration('contoh@email.com', Icons.email),
            ),
            const SizedBox(height: 24),

            // Field Kata Sandi
            const Text(
              'Kata Sandi',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextFormField(
              obscureText: true,
              decoration: _inputDecoration('••••••••', Icons.lock),
            ),
            const SizedBox(height: 24),

            // Field Konfirmasi Kata Sandi
            const Text(
              'Konfirmasi Kata Sandi',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextFormField(
              obscureText: true,
              decoration: _inputDecoration(
                'Ulangi kata sandi',
                Icons.lock_reset,
              ),
            ),
            const SizedBox(height: 40),

            // Tombol Register (Biru Cerah Penuh)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Aksi Register
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2196F3), // Biru Primer
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Sudut membulat
                  ),
                ),
                child: const Text(
                  'Daftar Akun',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),

            // Teks Pindah ke Login
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Sudah punya akun? '),
                GestureDetector(
                  onTap: () {
                    // Navigasi Kembali ke Halaman Login
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Masuk',
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

  // Fungsi Pembantu untuk Dekorasi Input Field (digunakan kembali)
  InputDecoration _inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon, color: Colors.grey),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(
          color: Color(0xFFE0E0E0),
        ), // Border abu-abu muda
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(
          color: Color(0xFF2196F3),
          width: 2.0,
        ), // Fokus Biru
      ),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 10.0,
      ),
    );
  }
}
