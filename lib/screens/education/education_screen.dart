import 'package:flutter/material.dart';

class EducationScreen extends StatelessWidget {
  const EducationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edukasi Kesehatan Mental'),
        backgroundColor: Colors.green,
      ),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          _buildCategoryCard(
            context,
            title: 'Tentang Depresi',
            icon: Icons.info_outline,
            color: Colors.blue,
            articles: _depressionArticles,
          ),
          const SizedBox(height: 15),
          _buildCategoryCard(
            context,
            title: 'Pencegahan Bunuh Diri',
            icon: Icons.security,
            color: Colors.red,
            articles: _suicidePreventionArticles,
          ),
          const SizedBox(height: 15),
          _buildCategoryCard(
            context,
            title: 'Tips Kesehatan Mental',
            icon: Icons.lightbulb_outline,
            color: Colors.orange,
            articles: _mentalHealthTips,
          ),
          const SizedBox(height: 15),
          _buildEmergencyCard(),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required List<Map<String, String>> articles,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(15),
              ),
            ),
            child: Row(
              children: [
                Icon(icon, color: color, size: 30),
                const SizedBox(width: 15),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
          ...articles.map(
            (article) => ListTile(
              title: Text(article['title']!),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ArticleDetailScreen(
                      title: article['title']!,
                      content: article['content']!,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmergencyCard() {
    return Card(
      elevation: 2,
      color: Colors.red[50],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: const BorderSide(color: Colors.red, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(Icons.phone_in_talk, color: Colors.red, size: 40),
            const SizedBox(height: 15),
            const Text(
              'Kontak Darurat',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            _buildContactItem('Hotline Kesehatan Jiwa', '119 ext. 8'),
            _buildContactItem('Into The Light', '021-500-454'),
            _buildContactItem('LSM Jangan Bunuh Diri', '0813-8550-0854'),
          ],
        ),
      ),
    );
  }

  Widget _buildContactItem(String name, String number) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          const Icon(Icons.phone, size: 20, color: Colors.red),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.w500)),
                Text(
                  number,
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Data artikel
  static final List<Map<String, String>> _depressionArticles = [
    {
      'title': 'Apa itu Depresi?',
      'content': '''
Depresi adalah gangguan suasana hati yang menyebabkan perasaan sedih berkepanjangan dan kehilangan minat pada aktivitas.

Gejala Umum:
- Perasaan sedih, hampa, atau putus asa
- Kehilangan minat atau kesenangan
- Perubahan nafsu makan dan berat badan
- Gangguan tidur
- Kelelahan dan kehilangan energi
- Perasaan tidak berharga atau bersalah berlebihan
- Kesulitan berkonsentrasi
- Pikiran tentang kematian atau bunuh diri

Penyebab:
Depresi dapat disebabkan oleh kombinasi faktor genetik, biologis, lingkungan, dan psikologis.

Pengobatan:
- Terapi psikologis (konseling)
- Obat-obatan (antidepresan)
- Perubahan gaya hidup
- Dukungan sosial

Jika Anda mengalami gejala depresi, segera konsultasikan dengan profesional kesehatan mental.
      ''',
    },
    {
      'title': 'Perbedaan Depresi dan Sedih Biasa',
      'content': '''
Banyak orang mengalami kesedihan, tetapi depresi berbeda dari kesedihan biasa.

Kesedihan Biasa:
- Berlangsung singkat (beberapa hari)
- Terkait dengan peristiwa spesifik
- Masih bisa menikmati hal-hal lain
- Tidak mengganggu fungsi sehari-hari secara signifikan

Depresi:
- Berlangsung lama (minimal 2 minggu)
- Tidak selalu ada pemicu jelas
- Kehilangan minat pada semua hal
- Mengganggu pekerjaan, sekolah, dan hubungan
- Disertai gejala fisik (gangguan tidur, nafsu makan)

Jika kesedihan berlangsung lama dan mengganggu kehidupan sehari-hari, segera cari bantuan profesional.
      ''',
    },
  ];

  static final List<Map<String, String>> _suicidePreventionArticles = [
    {
      'title': 'Tanda-tanda Peringatan Bunuh Diri',
      'content': '''
Mengenali tanda-tanda peringatan dapat menyelamatkan nyawa.

Tanda-tanda Bahaya:
- Berbicara tentang ingin mati atau bunuh diri
- Mencari cara untuk bunuh diri (mencari online, membeli alat)
- Berbicara tentang tidak ada harapan atau alasan hidup
- Merasa terjebak atau kesakitan yang tak tertahankan
- Berbicara tentang menjadi beban bagi orang lain
- Meningkatkan penggunaan alkohol atau obat-obatan
- Bertindak cemas atau gelisah
- Tidur terlalu banyak atau terlalu sedikit
- Menarik diri atau merasa terisolasi
- Menunjukkan kemarahan atau berbicara tentang balas dendam
- Perubahan suasana hati yang ekstrem

Apa yang Harus Dilakukan:
1. JANGAN tinggalkan orang tersebut sendirian
2. Ajak bicara dengan empati dan tanpa menghakimi
3. Dengarkan dengan serius
4. Hubungi hotline crisis atau profesional
5. Singkirkan akses ke alat yang berbahaya

INGAT: Bunuh diri dapat dicegah. Bantuan tersedia.

Hotline: 119 ext. 8 (24 jam)
      ''',
    },
    {
      'title': 'Cara Membantu Orang yang Berfikir Bunuh Diri',
      'content': '''
Jika seseorang yang Anda kenal menunjukkan tanda-tanda bunuh diri:

1. MULAI PERCAKAPAN
- "Saya khawatir tentang kamu. Bisakah kita bicara?"
- "Apakah kamu memikirkan untuk bunuh diri?"
- Jangan takut bertanya langsung

2. DENGARKAN TANPA MENGHAKIMI
- Beri waktu untuk berbicara
- Jangan meminimalisir perasaan mereka
- Tunjukkan empati dan perhatian

3. TAWARKAN DUKUNGAN
- "Kamu tidak sendirian"
- "Mari kita cari bantuan bersama"
- Bantu hubungi profesional

4. JAGA KEAMANAN
- Jangan tinggalkan mereka sendirian
- Singkirkan alat berbahaya
- Dampingi sampai bantuan datang

5. IKUTI PERKEMBANGAN
- Tetap terhubung
- Tanyakan kabar mereka
- Ingatkan mereka ada yang peduli

Yang TIDAK Boleh Dilakukan:
❌ "Jangan seperti itu"
❌ "Masih banyak yang lebih susah dari kamu"
❌ "Kamu harus lebih kuat"
❌ Menjanjikan kerahasiaan mutlak
      ''',
    },
  ];

  static final List<Map<String, String>> _mentalHealthTips = [
    {
      'title': '10 Cara Menjaga Kesehatan Mental',
      'content': '''
Tips praktis untuk kesehatan mental sehari-hari:

1. TIDUR CUKUP (7-9 jam/malam)
Tidur yang baik membantu otak memproses emosi

2. OLAHRAGA TERATUR
Minimal 30 menit/hari, 3-5x seminggu
Olahraga melepaskan endorfin (hormon bahagia)

3. MAKAN SEHAT
Nutrisi yang baik = otak yang sehat
Kurangi gula, kafein berlebih, dan makanan olahan

4. BERSOSIALISASI
Terhubung dengan orang lain mencegah isolasi
Luangkan waktu dengan teman dan keluarga

5. KELOLA STRES
- Teknik relaksasi (meditasi, yoga)
- Pernapasan dalam
- Journaling

6. BATASI MEDIA SOSIAL
Terlalu banyak screen time dapat meningkatkan kecemasan

7. LAKUKAN HOBI
Kegiatan yang Anda nikmati meningkatkan mood

8. JANGAN RAGU MINTA BANTUAN
Konsultasi dengan psikolog bukan tanda kelemahan

9. PRAKTIKKAN GRATITUDE
Catat 3 hal yang Anda syukuri setiap hari

10. TETAPKAN TUJUAN KECIL
Pencapaian kecil memberikan rasa kepuasan

Ingat: Kesehatan mental sama pentingnya dengan kesehatan fisik!
      ''',
    },
    {
      'title': 'Teknik Relaksasi Sederhana',
      'content': '''
Teknik yang bisa dilakukan kapan saja untuk meredakan stres:

1. PERNAPASAN DALAM (4-7-8)
- Tarik napas melalui hidung selama 4 detik
- Tahan napas selama 7 detik
- Hembuskan melalui mulut selama 8 detik
- Ulangi 3-4 kali

2. GROUNDING 5-4-3-2-1
Sebutkan:
- 5 hal yang Anda LIHAT
- 4 hal yang Anda SENTUH
- 3 hal yang Anda DENGAR
- 2 hal yang Anda CIUM
- 1 hal yang Anda RASAKAN

3. RELAKSASI OTOT PROGRESIF
- Kencangkan otot selama 5 detik
- Lepaskan dan rasakan relaksasi
- Mulai dari kaki ke kepala

4. VISUALISASI
- Bayangkan tempat yang menenangkan
- Fokus pada detail (warna, suara, bau)
- Rasakan kedamaian tempat tersebut

5. MINDFULNESS
- Fokus pada saat ini
- Perhatikan napas Anda
- Terima pikiran tanpa menghakimi

Praktikkan secara teratur untuk hasil terbaik!
      ''',
    },
  ];
}

// Screen Detail Artikel
class ArticleDetailScreen extends StatelessWidget {
  final String title;
  final String content;

  const ArticleDetailScreen({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), backgroundColor: Colors.green),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(content, style: const TextStyle(fontSize: 16, height: 1.6)),
          ],
        ),
      ),
    );
  }
}
