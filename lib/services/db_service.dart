import 'package:http/http.dart' as http;
import 'dart:convert';

class DatabaseService {
  static const String baseUrl = 'http://127.0.0.1:5000';

  Future<List<Map<String, dynamic>>> fetchIngredients(int userId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/ingredients?user_id=$userId'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return List<Map<String, dynamic>>.from(data['ingredients']);
      } else {
        print("Failed to fetch ingredients: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("Error fetching ingredients: $e");
      return [];
    }
  }
}
