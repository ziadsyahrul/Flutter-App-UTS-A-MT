import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/language_provider.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final currentLanguage = languageProvider.locale.languageCode;

    return Scaffold(
      appBar: AppBar(
        title: Text(currentLanguage == 'id' ? 'Bahasa' : 'Language'),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildLanguageCard(
            context: context,
            languageCode: 'id',
            languageName: 'Bahasa Indonesia',
            flag: '🇮🇩',
            isSelected: currentLanguage == 'id',
            onTap: () {
              languageProvider.setLocale(const Locale('id'));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Bahasa diubah ke Bahasa Indonesia'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
          const SizedBox(height: 15),
          _buildLanguageCard(
            context: context,
            languageCode: 'en',
            languageName: 'English',
            flag: '🇺🇸',
            isSelected: currentLanguage == 'en',
            onTap: () {
              languageProvider.setLocale(const Locale('en'));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Language changed to English'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageCard({
    required BuildContext context,
    required String languageCode,
    required String languageName,
    required String flag,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: isSelected ? 4 : 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(
          color: isSelected ? Colors.deepPurple : Colors.transparent,
          width: 2,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(15),
        leading: Text(flag, style: const TextStyle(fontSize: 40)),
        title: Text(
          languageName,
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 18,
          ),
        ),
        trailing: isSelected
            ? const Icon(Icons.check_circle, color: Colors.deepPurple, size: 30)
            : const Icon(Icons.circle_outlined, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }
}
