import 'package:flutter/material.dart';

class RestrictedKeywordsScreen extends StatelessWidget {
  const RestrictedKeywordsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الكلمات الممنوعة')),
      body: const Center(
        child: Text('yaha restricted words ki list hongi।'),
      ),
    );
  }
}
