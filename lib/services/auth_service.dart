import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String baseUrl = 'http://127.0.0.1:5000'; // Flask 백엔드의 기본 URL

  // 회원가입 기능
  Future<Map<String, dynamic>> register(
      String email, String password, String username) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/user/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
          'username': username,
        }),
      );

      if (response.statusCode == 201) {
        return {'status': 'success', 'message': "회원가입 성공"};
      } else {
        final error = jsonDecode(response.body)['message'];
        return {'status': 'error', 'message': "회원가입 실패: $error"};
      }
    } catch (e) {
      print("회원가입 요청 중 오류 발생: $e");
      return {'status': 'error', 'message': "회원가입 요청 실패"};
    }
  }

  // 로그인 기능
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/user/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          'status': 'success',
          'user_id': data['user_id'],
          'username': data['username'],
          'message': "로그인 성공"
        };
      } else {
        final error = jsonDecode(response.body)['message'];
        return {'status': 'error', 'message': "로그인 실패: $error"};
      }
    } catch (e) {
      print("로그인 요청 중 오류 발생: $e");
      return {'status': 'error', 'message': "로그인 요청 실패"};
    }
  }
}
