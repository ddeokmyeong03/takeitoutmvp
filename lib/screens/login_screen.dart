import 'package:firstapp_food_project_001/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart'; // 세션 관리
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  bool isLoading = false;

  void login() async {
    setState(() {
      isLoading = true;
    });

    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        isLoading = false;
      });
      showMessage("이메일과 비밀번호를 입력하세요.");
      return;
    }

    final result = await _authService.login(email, password);

    setState(() {
      isLoading = false;
    });

    // 로그인 성공 후 AuthProvider 업데이트
    if (result['status'] == 'success') {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('user_id', result['user_id']);
      await prefs.setString('username', result['username']);

      Provider.of<AuthProvider>(context, listen: false)
          .login(result['user_id'], result['username']);

      showMessage("환영합니다, ${result['username']}님!");
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      showMessage(result['message']);
    }
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('로그인')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: '이메일'),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: '비밀번호'),
              obscureText: true,
            ),
            SizedBox(height: 32),
            isLoading
                ? Center(child: CircularProgressIndicator())
                : ElevatedButton(
                    onPressed: login,
                    child: Text('로그인'),
                  ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              child: Text('회원가입'),
            ),
          ],
        ),
      ),
    );
  }
}
