import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/khanji.dart';

class KhanjiServices {
  final String baseUrl =
      "https://anilchhetri98.com.np/khanji_backend/api/khanji/";

  /// Fetch the Khanji list for the given level with pagination.
  Future<Map<String, dynamic>> getKhanjiList(String level,
      {int page = 1}) async {
    try {
      // Build the URL with pagination
      var response = await http.get(Uri.parse('$baseUrl$level?page=$page'));

      if (response.statusCode == 200) {
        // Parse the response body as a Map
        var data = jsonDecode(response.body) as Map<String, dynamic>;

        // Extract the list of Khanji objects
        List<Khanji> khanjiList = [];
        if (data['data'] != null) {
          for (var item in data['data']) {
            khanjiList.add(Khanji.fromJson(item));
          }
        }

        // Return both the list of Khanji and pagination info
        return {
          'data': khanjiList,
          'current_page': data['current_page'],
          'last_page': data['last_page'],
        };
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
  }
}
