import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'restricted_keywords_screen.dart'; // Ensure this import is correct

class SecretSettingsPage extends StatelessWidget {
  const SecretSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الإعدادات السرية'),
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('parental_controls')
            .doc('settings')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('لم يتم العثور على الإعدادات.'));
          }

          bool isEnabled = snapshot.data?.get('enabled') ?? false;

          return Column(
            children: [
              SwitchListTile(
                title: const Text('تفعيل الرقابة الأبوية'),
                value: isEnabled,
                onChanged: (value) {
                  FirebaseFirestore.instance
                      .collection('parental_controls')
                      .doc('settings')
                      .update({'enabled': value});
                },
              ),
              ListTile(
                title: const Text('الكلمات الممنوعة'),
                subtitle: const Text('أضف/احذف الكلمات المحظورة'),
                onTap: () => Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => const RestrictedKeywordsScreen(),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
