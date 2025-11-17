import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'mentalcheck.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    // Tabel Users
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT UNIQUE NOT NULL,
        password TEXT NOT NULL,
        age INTEGER,
        gender TEXT,
        created_at TEXT
      )
    ''');

    // Tabel Symptoms (Gejala)
    await db.execute('''
      CREATE TABLE symptoms (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        code TEXT NOT NULL,
        symptom_name TEXT NOT NULL,
        description TEXT
      )
    ''');

    // Tabel Diagnosis
    await db.execute('''
      CREATE TABLE diagnosis (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        code TEXT NOT NULL,
        diagnosis_name TEXT NOT NULL,
        cf_min REAL,
        cf_max REAL,
        description TEXT,
        recommendation TEXT
      )
    ''');

    // Tabel Rules
    await db.execute('''
      CREATE TABLE rules (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        rule_code TEXT NOT NULL,
        diagnosis_id INTEGER,
        cf_expert REAL,
        FOREIGN KEY (diagnosis_id) REFERENCES diagnosis(id)
      )
    ''');

    // Tabel Rule_Symptoms (Junction Table)
    await db.execute('''
      CREATE TABLE rule_symptoms (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        rule_id INTEGER,
        symptom_id INTEGER,
        FOREIGN KEY (rule_id) REFERENCES rules(id),
        FOREIGN KEY (symptom_id) REFERENCES symptoms(id)
      )
    ''');

    // Tabel Consultations (Riwayat Tes)
    await db.execute('''
      CREATE TABLE consultations (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER,
        consultation_date TEXT,
        final_diagnosis_id INTEGER,
        final_cf REAL,
        recommendation TEXT,
        FOREIGN KEY (user_id) REFERENCES users(id),
        FOREIGN KEY (final_diagnosis_id) REFERENCES diagnosis(id)
      )
    ''');

    // Tabel User_Answers
    await db.execute('''
      CREATE TABLE user_answers (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        consultation_id INTEGER,
        symptom_id INTEGER,
        cf_user REAL,
        FOREIGN KEY (consultation_id) REFERENCES consultations(id),
        FOREIGN KEY (symptom_id) REFERENCES symptoms(id)
      )
    ''');

    // Insert data awal (basis pengetahuan)
    await _insertInitialData(db);
  }

  Future<void> _insertInitialData(Database db) async {
    // Insert Symptoms (21 gejala)
    List<Map<String, dynamic>> symptoms = [
      {
        'code': 'G01',
        'symptom_name': 'Perasaan sedih berkepanjangan',
        'description': 'Merasa sedih hampir setiap hari',
      },
      {
        'code': 'G02',
        'symptom_name': 'Pesimis tentang masa depan',
        'description': 'Tidak ada harapan untuk masa depan',
      },
      {
        'code': 'G03',
        'symptom_name': 'Merasa gagal dalam hidup',
        'description': 'Merasa telah gagal sebagai pribadi',
      },
      {
        'code': 'G04',
        'symptom_name': 'Kehilangan kesenangan/minat',
        'description': 'Tidak menikmati hal yang dulu disukai',
      },
      {
        'code': 'G05',
        'symptom_name': 'Perasaan bersalah berlebihan',
        'description': 'Merasa bersalah terus menerus',
      },
      {
        'code': 'G06',
        'symptom_name': 'Merasa dihukum',
        'description': 'Merasa sedang mendapat hukuman',
      },
      {
        'code': 'G07',
        'symptom_name': 'Tidak suka pada diri sendiri',
        'description': 'Kecewa dengan diri sendiri',
      },
      {
        'code': 'G08',
        'symptom_name': 'Menyalahkan diri sendiri',
        'description': 'Menyalahkan diri untuk segala hal buruk',
      },
      {
        'code': 'G09',
        'symptom_name': 'Pikiran untuk bunuh diri',
        'description': 'Sering memikirkan bunuh diri',
      },
      {
        'code': 'G10',
        'symptom_name': 'Menangis lebih sering',
        'description': 'Menangis hampir setiap saat',
      },
      {
        'code': 'G11',
        'symptom_name': 'Mudah tersinggung/marah',
        'description': 'Lebih mudah marah dari biasanya',
      },
      {
        'code': 'G12',
        'symptom_name': 'Kehilangan minat pada orang lain',
        'description': 'Tidak peduli dengan orang lain',
      },
      {
        'code': 'G13',
        'symptom_name': 'Sulit mengambil keputusan',
        'description': 'Kesulitan membuat keputusan sederhana',
      },
      {
        'code': 'G14',
        'symptom_name': 'Merasa penampilan memburuk',
        'description': 'Merasa terlihat tua atau tidak menarik',
      },
      {
        'code': 'G15',
        'symptom_name': 'Sulit bekerja/beraktivitas',
        'description': 'Tidak bisa bekerja seperti biasa',
      },
      {
        'code': 'G16',
        'symptom_name': 'Gangguan tidur',
        'description': 'Sulit tidur atau tidur berlebihan',
      },
      {
        'code': 'G17',
        'symptom_name': 'Mudah lelah',
        'description': 'Cepat lelah untuk aktivitas ringan',
      },
      {
        'code': 'G18',
        'symptom_name': 'Kehilangan nafsu makan',
        'description': 'Tidak ada selera makan',
      },
      {
        'code': 'G19',
        'symptom_name': 'Penurunan berat badan',
        'description': 'Berat badan turun signifikan',
      },
      {
        'code': 'G20',
        'symptom_name': 'Khawatir berlebihan pada kesehatan',
        'description': 'Terlalu fokus pada kesehatan fisik',
      },
      {
        'code': 'G21',
        'symptom_name': 'Kehilangan minat seksual',
        'description': 'Tidak tertarik pada aktivitas seksual',
      },
    ];

    for (var symptom in symptoms) {
      await db.insert('symptoms', symptom);
    }

    // Insert Diagnosis Types
    await db.insert('diagnosis', {
      'code': 'D01',
      'diagnosis_name': 'Tidak Terindikasi Depresi',
      'cf_min': 0.0,
      'cf_max': 0.39,
      'description': 'Anda tidak menunjukkan gejala depresi yang signifikan',
      'recommendation':
          'Pertahankan gaya hidup sehat dan tetap jaga kesehatan mental',
    });

    await db.insert('diagnosis', {
      'code': 'D02',
      'diagnosis_name': 'Depresi Ringan',
      'cf_min': 0.4,
      'cf_max': 0.59,
      'description': 'Anda menunjukkan gejala depresi ringan',
      'recommendation':
          'Lakukan aktivitas yang menyenangkan, olahraga teratur, dan berbicara dengan orang terdekat',
    });

    await db.insert('diagnosis', {
      'code': 'D03',
      'diagnosis_name': 'Depresi Sedang',
      'cf_min': 0.6,
      'cf_max': 0.79,
      'description': 'Anda menunjukkan gejala depresi sedang',
      'recommendation':
          'Disarankan untuk konsultasi dengan psikolog atau konselor',
    });

    await db.insert('diagnosis', {
      'code': 'D04',
      'diagnosis_name': 'Depresi Berat',
      'cf_min': 0.8,
      'cf_max': 1.0,
      'description': 'Anda menunjukkan gejala depresi berat',
      'recommendation':
          'SEGERA konsultasi dengan psikiater atau hubungi hotline crisis',
    });

    // Insert Rules (contoh beberapa rules)
    // Rule 1: Depresi Ringan
    int rule1 = await db.insert('rules', {
      'rule_code': 'R01',
      'diagnosis_id': 2, // Depresi Ringan
      'cf_expert': 0.6,
    });
    await db.insert('rule_symptoms', {
      'rule_id': rule1,
      'symptom_id': 1,
    }); // G01
    await db.insert('rule_symptoms', {
      'rule_id': rule1,
      'symptom_id': 2,
    }); // G02
    await db.insert('rule_symptoms', {
      'rule_id': rule1,
      'symptom_id': 4,
    }); // G04

    // Rule 2: Depresi Sedang
    int rule2 = await db.insert('rules', {
      'rule_code': 'R02',
      'diagnosis_id': 3, // Depresi Sedang
      'cf_expert': 0.7,
    });
    await db.insert('rule_symptoms', {
      'rule_id': rule2,
      'symptom_id': 1,
    }); // G01
    await db.insert('rule_symptoms', {
      'rule_id': rule2,
      'symptom_id': 4,
    }); // G04
    await db.insert('rule_symptoms', {
      'rule_id': rule2,
      'symptom_id': 5,
    }); // G05
    await db.insert('rule_symptoms', {
      'rule_id': rule2,
      'symptom_id': 15,
    }); // G15

    // Rule 3: Depresi Berat
    int rule3 = await db.insert('rules', {
      'rule_code': 'R03',
      'diagnosis_id': 4, // Depresi Berat
      'cf_expert': 0.85,
    });
    await db.insert('rule_symptoms', {
      'rule_id': rule3,
      'symptom_id': 1,
    }); // G01
    await db.insert('rule_symptoms', {
      'rule_id': rule3,
      'symptom_id': 4,
    }); // G04
    await db.insert('rule_symptoms', {
      'rule_id': rule3,
      'symptom_id': 9,
    }); // G09
    await db.insert('rule_symptoms', {
      'rule_id': rule3,
      'symptom_id': 15,
    }); // G15
    await db.insert('rule_symptoms', {
      'rule_id': rule3,
      'symptom_id': 17,
    }); // G17

    // Rule 4: Risiko Bunuh Diri
    int rule4 = await db.insert('rules', {
      'rule_code': 'R04',
      'diagnosis_id': 4, // Depresi Berat (dengan risiko bunuh diri)
      'cf_expert': 0.9,
    });
    await db.insert('rule_symptoms', {
      'rule_id': rule4,
      'symptom_id': 9,
    }); // G09
    await db.insert('rule_symptoms', {
      'rule_id': rule4,
      'symptom_id': 1,
    }); // G01

    // Tambahkan rules lain sesuai kebutuhan...
  }

  Future<int> insertUser(String name, String email, String password) async {
    final db = await database;

    // Periksa apakah email sudah terdaftar
    final existingUser = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );

    if (existingUser.isNotEmpty) {
      // Mengembalikan -1 jika email sudah ada (atau throw error, tergantung preferensi)
      return -1;
    }

    final data = {
      'name': name,
      'email': email,
      // Penting: Dalam aplikasi nyata, password harus selalu di-hash (misalnya dengan bcrypt)
      // Sebelum disimpan. Untuk contoh sqflite sederhana ini, kita simpan plain text.
      'password': password,
      'created_at': DateTime.now().toIso8601String(),
    };

    // Mengembalikan ID pengguna baru yang berhasil dimasukkan
    return await db.insert(
      'users',
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Map<String, dynamic>?> getUser(String email, String password) async {
    final db = await database;

    // Mencari pengguna yang cocok dengan email DAN password
    // Catatan: Jika password di-hash, kita perlu mengambil pengguna berdasarkan email
    // terlebih dahulu, lalu membandingkan hash password di dalam kode Dart.
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
      limit: 1,
    );

    if (maps.isNotEmpty) {
      // Jika ditemukan, kembalikan data pengguna pertama
      return maps.first;
    }

    // Jika tidak ditemukan, kembalikan null
    return null;
  }

  // CRUD Methods akan ditambahkan nanti
}
