import 'dart:convert';
import 'package:http/http.dart' as http;


class QuranService {
  final String apiUrl = "https://api.alquran.cloud/v1/quran/en.asad";

  Future<List<dynamic>> getQuranData() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data['data']['surahs'];
    } else {
      throw Exception("Failed to load Quran data");
    }
  }
}
