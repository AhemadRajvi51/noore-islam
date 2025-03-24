// ignore_for_file: library_private_types_in_public_api

import 'package:Salam_islam/quran_service.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import '../services/quran_service.dart';

class QuranScreen extends StatefulWidget {
  const QuranScreen({super.key});

  @override
  _QuranScreenState createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> {
  late Future<List<dynamic>> surahs;

  @override
  void initState() {
    super.initState();
    surahs = QuranService().getQuranData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Holy Quran")),
      body: FutureBuilder<List<dynamic>>(
        future: surahs,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var surah = snapshot.data![index];
                return ListTile(
                  title: Text(surah['englishName'], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  subtitle: Text(surah['name']),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SurahDetail(surah)),
                    );
                  },
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text("Error loading Quran"));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}


