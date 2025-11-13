import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../database/database_helper.dart';
import '../test/result_screen.dart';

class HistoryScreen extends StatefulWidget {
  final int userId;

  const HistoryScreen({Key? key, required this.userId}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<Map<String, dynamic>> consultations = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadHistory();
  }

  Future<void> loadHistory() async {
    final db = await DatabaseHelper().database;

    // Query consultations with diagnosis info
    final data = await db.rawQuery(
      '''
      SELECT 
        c.id,
        c.consultation_date,
        c.final_cf,
        d.diagnosis_name,
        d.description,
        d.recommendation
      FROM consultations c
      JOIN diagnosis d ON c.final_diagnosis_id = d.id
      WHERE c.user_id = ?
      ORDER BY c.consultation_date DESC
    ''',
      [widget.userId],
    );

    setState(() {
      consultations = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Tes'),
        backgroundColor: Colors.orange,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : consultations.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: consultations.length,
              itemBuilder: (context, index) {
                final consultation = consultations[index];
                return _buildHistoryCard(consultation);
              },
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.history, size: 100, color: Colors.grey[300]),
          const SizedBox(height: 20),
          Text(
            'Belum ada riwayat tes',
            style: TextStyle(fontSize: 18, color: Colors.grey[600]),
          ),
          const SizedBox(height: 10),
          Text(
            'Mulai tes pertama Anda!',
            style: TextStyle(color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryCard(Map<String, dynamic> consultation) {
    final DateTime date = DateTime.parse(consultation['consultation_date']);
    final double cf = consultation['final_cf'];
    final String diagnosisName = consultation['diagnosis_name'];

    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: () {
          // Show detail
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResultScreen(
                result: {
                  'final_cf': cf,
                  'diagnosis_name': diagnosisName,
                  'description': consultation['description'],
                  'recommendation': consultation['recommendation'],
                },
              ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              // CF Circle
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: _getCFColor(cf).withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '${(cf * 100).toInt()}%',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: _getCFColor(cf),
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 15),

              // Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      diagnosisName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      DateFormat('dd MMM yyyy, HH:mm').format(date),
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                  ],
                ),
              ),

              // Arrow
              Icon(Icons.chevron_right, color: Colors.grey[400]),
            ],
          ),
        ),
      ),
    );
  }

  Color _getCFColor(double cf) {
    if (cf < 0.4) return Colors.green;
    if (cf < 0.6) return Colors.blue;
    if (cf < 0.8) return Colors.orange;
    return Colors.red;
  }
}
