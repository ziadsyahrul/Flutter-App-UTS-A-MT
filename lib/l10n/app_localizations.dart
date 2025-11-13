import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      // General
      'app_name': 'MentalCheck',
      'app_tagline': 'Depression Detection Expert System',
      'ok': 'OK',
      'cancel': 'Cancel',
      'save': 'Save',
      'close': 'Close',
      'back': 'Back',
      'next': 'Next',
      'finish': 'Finish',
      'loading': 'Loading...',

      // Home Screen
      'home_greeting': 'Hello! 👋',
      'home_subtitle': 'How is your mental health today?',
      'start_test': 'Start Depression Test',
      'start_test_desc': 'Early screening for depression level',
      'history': 'History',
      'education': 'Education',
      'about_app': 'About App',
      'about_desc':
          'MentalCheck uses Forward Chaining and Certainty Factor methods to detect depression levels. This result is not a medical diagnosis, consultation with a professional is highly recommended.',
      'emergency_hotline': '24/7 Emergency Hotline',

      // Questionnaire
      'question': 'Question',
      'how_sure': 'How sure are you experiencing this symptom?',
      'not_sure': 'Not Sure',
      'very_sure': 'Very Sure',
      'previous': 'Previous',
      'cf_very_unsure': 'Very Unsure',
      'cf_unsure': 'Unsure',
      'cf_quite_sure': 'Quite Sure',
      'cf_sure': 'Sure',
      'cf_very_sure': 'Very Sure',

      // Results
      'result_title': 'Diagnosis Result',
      'certainty_factor': 'Certainty Factor',
      'explanation': 'Explanation',
      'recommendation': 'Recommendation',
      'call_hotline': 'CALL HOTLINE',
      'view_detail': 'VIEW DETAIL',
      'back_home': 'Back to Home',

      // Diagnosis Types
      'diagnosis_none': 'Not Indicated for Depression',
      'diagnosis_mild': 'Mild Depression',
      'diagnosis_moderate': 'Moderate Depression',
      'diagnosis_severe': 'Severe Depression',

      // History
      'history_title': 'Test History',
      'no_history': 'No test history yet',
      'start_first_test': 'Start your first test!',

      // Education
      'education_title': 'Mental Health Education',
      'about_depression': 'About Depression',
      'suicide_prevention': 'Suicide Prevention',
      'mental_health_tips': 'Mental Health Tips',
      'emergency_contacts': 'Emergency Contacts',

      // Profile
      'profile': 'Profile',
      'total_tests': 'Total Tests',
      'age': 'Age',
      'years_old': 'years old',
      'chart_progress': 'Progress Chart',
      'chart_desc': 'View your mental health trend',
      'reminder': 'Reminder',
      'reminder_desc': 'Set daily reminder',
      'edit_profile': 'Edit Profile',
      'edit_profile_desc': 'Update personal information',
      'about': 'About Application',
      'version': 'Version 1.0.0',
      'logout': 'Logout',
      'logout_desc': 'Logout from application',
      'name': 'Name',
      'logout_confirm': 'Are you sure you want to logout?',
      'logout_success': 'Logout successful',
      'profile_updated': 'Profile updated successfully',

      // Chart
      'chart_title': 'Progress Chart',
      'depression_trend': 'Depression Level Trend',
      'statistics': 'Statistics',
      'average_cf': 'Average CF',
      'highest': 'Highest',
      'lowest': 'Lowest',
      'no_data': 'No data yet',

      // Reminder
      'reminder_title': 'Reminder',
      'daily_reminder': 'Daily Reminder',
      'reminder_message': 'Enable reminder to check your mental health daily',
      'enable_reminder': 'Enable Reminder',
      'reminder_time': 'Reminder Time',
      'change': 'Change',
      'reminder_enabled': 'Reminder enabled',
      'reminder_disabled': 'Reminder disabled',
      'motivational_quote': 'Motivational Quote',
      'quote_text':
          '"Mental health is an important part of overall health. Don\'t ignore your feelings."',

      // Symptoms (21 gejala)
      'symptom_g01': 'Prolonged sadness',
      'symptom_g02': 'Pessimistic about the future',
      'symptom_g03': 'Feeling like a failure in life',
      'symptom_g04': 'Loss of pleasure/interest',
      'symptom_g05': 'Excessive guilt',
      'symptom_g06': 'Feeling punished',
      'symptom_g07': 'Dislike of oneself',
      'symptom_g08': 'Self-blame',
      'symptom_g09': 'Suicidal thoughts',
      'symptom_g10': 'Crying more often',
      'symptom_g11': 'Easily irritated/angry',
      'symptom_g12': 'Loss of interest in others',
      'symptom_g13': 'Difficulty making decisions',
      'symptom_g14': 'Feeling appearance has deteriorated',
      'symptom_g15': 'Difficulty working/activities',
      'symptom_g16': 'Sleep disorders',
      'symptom_g17': 'Easily tired',
      'symptom_g18': 'Loss of appetite',
      'symptom_g19': 'Weight loss',
      'symptom_g20': 'Excessive health concerns',
      'symptom_g21': 'Loss of sexual interest',
    },
    'id': {
      // General
      'app_name': 'MentalCheck',
      'app_tagline': 'Sistem Pakar Deteksi Depresi',
      'ok': 'OK',
      'cancel': 'Batal',
      'save': 'Simpan',
      'close': 'Tutup',
      'back': 'Kembali',
      'next': 'Selanjutnya',
      'finish': 'Selesai',
      'loading': 'Memuat...',

      // Home Screen
      'home_greeting': 'Halo! 👋',
      'home_subtitle': 'Bagaimana kabar mental Anda hari ini?',
      'start_test': 'Mulai Tes Depresi',
      'start_test_desc': 'Skrining awal tingkat depresi',
      'history': 'Riwayat',
      'education': 'Edukasi',
      'about_app': 'Tentang Aplikasi',
      'about_desc':
          'MentalCheck menggunakan metode Forward Chaining dan Certainty Factor untuk mendeteksi tingkat depresi. Hasil ini bukan diagnosis medis, konsultasi dengan profesional sangat dianjurkan.',
      'emergency_hotline': 'Hotline Darurat 24 Jam',

      // Questionnaire
      'question': 'Pertanyaan',
      'how_sure': 'Seberapa yakin Anda mengalami gejala ini?',
      'not_sure': 'Tidak Yakin',
      'very_sure': 'Sangat Yakin',
      'previous': 'Sebelumnya',
      'cf_very_unsure': 'Sangat Tidak Yakin',
      'cf_unsure': 'Tidak Yakin',
      'cf_quite_sure': 'Cukup Yakin',
      'cf_sure': 'Yakin',
      'cf_very_sure': 'Sangat Yakin',

      // Results
      'result_title': 'Hasil Diagnosis',
      'certainty_factor': 'Certainty Factor',
      'explanation': 'Penjelasan',
      'recommendation': 'Rekomendasi',
      'call_hotline': 'HUBUNGI HOTLINE',
      'view_detail': 'LIHAT DETAIL',
      'back_home': 'Kembali ke Beranda',

      // Diagnosis Types
      'diagnosis_none': 'Tidak Terindikasi Depresi',
      'diagnosis_mild': 'Depresi Ringan',
      'diagnosis_moderate': 'Depresi Sedang',
      'diagnosis_severe': 'Depresi Berat',

      // History
      'history_title': 'Riwayat Tes',
      'no_history': 'Belum ada riwayat tes',
      'start_first_test': 'Mulai tes pertama Anda!',

      // Education
      'education_title': 'Edukasi Kesehatan Mental',
      'about_depression': 'Tentang Depresi',
      'suicide_prevention': 'Pencegahan Bunuh Diri',
      'mental_health_tips': 'Tips Kesehatan Mental',
      'emergency_contacts': 'Kontak Darurat',

      // Profile
      'profile': 'Profil',
      'total_tests': 'Total Tes',
      'age': 'Usia',
      'years_old': 'tahun',
      'chart_progress': 'Grafik Perkembangan',
      'chart_desc': 'Lihat tren kesehatan mental Anda',
      'reminder': 'Pengingat',
      'reminder_desc': 'Atur pengingat harian',
      'edit_profile': 'Edit Profil',
      'edit_profile_desc': 'Ubah informasi pribadi',
      'about': 'Tentang Aplikasi',
      'version': 'Versi 1.0.0',
      'logout': 'Keluar',
      'logout_desc': 'Logout dari aplikasi',
      'name': 'Nama',
      'logout_confirm': 'Apakah Anda yakin ingin keluar?',
      'logout_success': 'Logout berhasil',
      'profile_updated': 'Profil berhasil diupdate',

      // Chart
      'chart_title': 'Grafik Perkembangan',
      'depression_trend': 'Tren Tingkat Depresi',
      'statistics': 'Statistik',
      'average_cf': 'Rata-rata CF',
      'highest': 'Tertinggi',
      'lowest': 'Terendah',
      'no_data': 'Belum ada data',

      // Reminder
      'reminder_title': 'Pengingat',
      'daily_reminder': 'Pengingat Harian',
      'reminder_message':
          'Aktifkan pengingat untuk melakukan check-in kesehatan mental Anda setiap hari',
      'enable_reminder': 'Aktifkan Pengingat',
      'reminder_time': 'Waktu Pengingat',
      'change': 'Ubah',
      'reminder_enabled': 'Pengingat diaktifkan',
      'reminder_disabled': 'Pengingat dinonaktifkan',
      'motivational_quote': 'Quote Motivasi',
      'quote_text':
          '"Kesehatan mental adalah bagian penting dari kesehatan secara keseluruhan. Jangan abaikan perasaan Anda."',

      // Symptoms (21 gejala)
      'symptom_g01': 'Perasaan sedih berkepanjangan',
      'symptom_g02': 'Pesimis tentang masa depan',
      'symptom_g03': 'Merasa gagal dalam hidup',
      'symptom_g04': 'Kehilangan kesenangan/minat',
      'symptom_g05': 'Perasaan bersalah berlebihan',
      'symptom_g06': 'Merasa dihukum',
      'symptom_g07': 'Tidak suka pada diri sendiri',
      'symptom_g08': 'Menyalahkan diri sendiri',
      'symptom_g09': 'Pikiran untuk bunuh diri',
      'symptom_g10': 'Menangis lebih sering',
      'symptom_g11': 'Mudah tersinggung/marah',
      'symptom_g12': 'Kehilangan minat pada orang lain',
      'symptom_g13': 'Sulit mengambil keputusan',
      'symptom_g14': 'Merasa penampilan memburuk',
      'symptom_g15': 'Sulit bekerja/beraktivitas',
      'symptom_g16': 'Gangguan tidur (insomnia/hipersomnia)',
      'symptom_g17': 'Mudah lelah',
      'symptom_g18': 'Kehilangan nafsu makan',
      'symptom_g19': 'Penurunan berat badan',
      'symptom_g20': 'Khawatir berlebihan pada kesehatan',
      'symptom_g21': 'Kehilangan minat seksual',
    },
  };

  String translate(String key) {
    return _localizedValues[locale.languageCode]?[key] ?? key;
  }

  // Helper getter
  String get appName => translate('app_name');
  String get appTagline => translate('app_tagline');
  String get homeGreeting => translate('home_greeting');
  String get homeSubtitle => translate('home_subtitle');
  String get startTest => translate('start_test');
  String get startTestDesc => translate('start_test_desc');
  String get history => translate('history');
  String get education => translate('education');
  String get profile => translate('profile');
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'id'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
