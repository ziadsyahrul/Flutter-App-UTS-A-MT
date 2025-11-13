import 'package:flutter/material.dart';
import '../home/home_screen.dart';

class ResultScreen extends StatelessWidget {
  final Map<String, dynamic> result;

  const ResultScreen({Key? key, required this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double finalCF = result['final_cf'];
    final String diagnosisName = result['diagnosis_name'];
    final String description = result['description'] ?? '';
    final String recommendation = result['recommendation'] ?? '';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hasil Diagnosis'),
        backgroundColor: _getDiagnosisColor(finalCF),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Icon & CF
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: _getDiagnosisColor(finalCF).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _getDiagnosisIcon(finalCF),
                size: 100,
                color: _getDiagnosisColor(finalCF),
              ),
            ),
            const SizedBox(height: 20),

            // CF Percentage
            Text(
              '${(finalCF * 100).toStringAsFixed(1)}%',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: _getDiagnosisColor(finalCF),
              ),
            ),
            const SizedBox(height: 10),

            // Certainty Factor Label
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Certainty Factor',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
            ),
            const SizedBox(height: 30),

            // Diagnosis Name
            Text(
              diagnosisName,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Description Card
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.info_outline, color: Colors.blue),
                        SizedBox(width: 10),
                        Text(
                          'Penjelasan',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      description,
                      style: const TextStyle(fontSize: 16, height: 1.5),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Recommendation Card
            Card(
              elevation: 2,
              color: _getDiagnosisColor(finalCF).withOpacity(0.1),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.recommend,
                          color: _getDiagnosisColor(finalCF),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'Rekomendasi',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      recommendation,
                      style: const TextStyle(fontSize: 16, height: 1.5),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Emergency Button (jika depresi berat)
            if (finalCF >= 0.8)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // TODO: Implement call hotline
                    _showEmergencyDialog(context);
                  },
                  icon: const Icon(Icons.phone),
                  label: const Text('Hubungi Hotline Darurat'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
              ),
            const SizedBox(height: 10),

            // Back to Home Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const HomeScreen(userId: 1), // TODO: dynamic userId
                    ),
                    (route) => false,
                  );
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text('Kembali ke Beranda'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getDiagnosisColor(double cf) {
    if (cf < 0.4) return Colors.green;
    if (cf < 0.6) return Colors.blue;
    if (cf < 0.8) return Colors.orange;
    return Colors.red;
  }

  IconData _getDiagnosisIcon(double cf) {
    if (cf < 0.4) return Icons.check_circle;
    if (cf < 0.6) return Icons.warning_amber;
    if (cf < 0.8) return Icons.error_outline;
    return Icons.emergency;
  }

  void _showEmergencyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hotline Darurat'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('📞 Hotline Kesehatan Jiwa:'),
            SizedBox(height: 10),
            Text('• 119 ext. 8\n• 021-500-454\n• 0813-8550-0854'),
            SizedBox(height: 20),
            Text(
              'Jangan ragu untuk meminta bantuan profesional.',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }
}
