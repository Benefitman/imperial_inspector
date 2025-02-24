import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class InaraApiService {
  final String apiUrl = 'https://inara.cz/inapi/v1/';
  final String apiKey = dotenv.env['INARA_API_KEY'] ?? '';

  Future<Map<String, dynamic>?> fetchFactionData() async {
    if (apiKey.isEmpty) {
      print("❌ Fehler: API-Key nicht geladen!");
      return null;
    }

    final headers = {
      'Content-Type': 'application/json',
      'User-Agent': 'FlutterApp/1.0', // <-- WICHTIG! Manchmal blockiert Inara Anfragen ohne User-Agent.
    };

    final body = jsonEncode({
      'header': {
        'appName': 'TorvalsAgent',
        'appVersion': '1.0',
        'APIkey': apiKey,
      },
      'events': [
        {
          'eventName': 'getFactionDetails',
          'eventTimestamp': DateTime.now().toIso8601String(),
          'eventData': {
            'searchName': 'Zemina Torval',
          },
        },
      ],
    });

    try {
      final response = await http.post(Uri.parse(apiUrl), headers: headers, body: body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("✅ API-Antwort: $data");
        return data;
      } else {
        print("❌ API-Fehler: ${response.statusCode} - ${response.body}");
        return null;
      }
    } catch (e) {
      print("❌ Netzwerkfehler: $e");
      return null;
    }
  }
}
