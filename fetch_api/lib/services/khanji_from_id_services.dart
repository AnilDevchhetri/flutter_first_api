import 'dart:convert';
import 'package:fetch_api/models/khanji.dart';
import 'package:http/http.dart' as http;

class KhanjiIdService {
  final String baseUrl =
      "https://anilchhetri98.com.np/khanji_backend/api/khanji/id/";

  Future<Khanji> fetchKhanjiById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl$id'));

    if (response.statusCode == 200) {
      return Khanji.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Khanji');
    }
  }
}
