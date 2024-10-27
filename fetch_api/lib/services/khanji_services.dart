import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/khanji.dart';

class KhanjiServices {
  final String baseUrl =
      "https://anilchhetri98.com.np/khanji_backend/api/khanji/";

  Future<List<Khanji>> getKhanjiList(String level) async {
    List<Khanji> khanjiList = [];
    try {
      var response = await http.get(Uri.parse(baseUrl + level));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body) as List<dynamic>;

        for (var item in data) {
          khanjiList.add(Khanji.fromJson(item));
        }
      } else {
        // Log the error if the status code is not 200
        print("Error: Received status code ${response.statusCode}");
        print("Response body: ${response.body}");
        throw Exception("Failed to load Khanji data");
      }
    } catch (e) {
      // Log the exception for debugging
      print("Exception caught: $e");
      throw Exception("Failed to load Khanji data");
    }
    return khanjiList;
  }
}
