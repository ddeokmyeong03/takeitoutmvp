import 'package:flutter/material.dart';

class LogInScreen extends StatefulWidget {
  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('로그인'),
        elevation: 0.0,
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); // 화면 탭 시 키보드 닫기
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(padding: EdgeInsets.only(top: 50)),
              Center(
                child: Icon(
                  Icons.lock_outline,
                  size: 100,
                  color: Colors.teal,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'My Fridge App',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              SizedBox(height: 20),
              Form(
                child: Theme(
                  data: ThemeData(
                    primaryColor: Colors.grey,
                    inputDecorationTheme: InputDecorationTheme(
                      labelStyle: TextStyle(color: Colors.teal, fontSize: 15.0),
                    ),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(40.0),
                    child: Builder(builder: (context) {
                      return Column(
                        children: [
                          TextField(
                            controller: emailController,
                            decoration: InputDecoration(labelText: '이메일 입력'),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(height: 16),
                          TextField(
                            controller: passwordController,
                            decoration: InputDecoration(labelText: '비밀번호 입력'),
                            keyboardType: TextInputType.text,
                            obscureText: true, // 비밀번호 가리기
                          ),
                          SizedBox(height: 40.0),
                          ElevatedButton(
                            onPressed: () {
                              handleLogin(context);
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('로그인'),
                                SizedBox(width: 8),
                                Icon(Icons.arrow_forward),
                              ],
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal,
                              textStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void handleLogin(BuildContext context) {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    // 간단한 로그인 로직
    if (email == 'test@myfridge.com' && password == '1234') {
      Navigator.pushReplacementNamed(context, '/home');
    } else if (email == 'test@myfridge.com' && password != '1234') {
      showSnackBar(context, Text('비밀번호가 잘못되었습니다.'));
    } else if (email != 'test@myfridge.com' && password == '1234') {
      showSnackBar(context, Text('이메일이 잘못되었습니다.'));
    } else {
      showSnackBar(context, Text('이메일과 비밀번호를 다시 확인해주세요.'));
    }
  }

  void showSnackBar(BuildContext context, Text message) {
    final snackBar = SnackBar(
      content: message,
      backgroundColor: Colors.redAccent,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
