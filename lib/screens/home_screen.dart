import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/bottom_navbar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = '냉장'; // 기본 카테고리
  int _selectedIndex = 0; // 현재 선택된 하단바 탭 인덱스

  void _onBottomNavTap(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) {
      // 레시피 페이지로 이동
      Navigator.pushNamed(context, '/recipes');
    } else if (index == 2) {
      // 내 페이지로 이동
      Navigator.pushNamed(context, '/user');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('나의 냉장고'),
        centerTitle: true,
      ),
      body: Consumer<AuthProvider>(
        builder: (context, auth, child) {
          if (!auth.isLoggedIn) {
            // 로그인 상태가 아니면 "로그인 필요" 메시지 표시
            return Center(
              child: Text(
                '로그인 후 이용 가능합니다.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }

          // 로그인 상태이면 정상 UI 표시
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: ['냉장', '냉동', '실온'].map((category) {
                    return ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedCategory = category;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedCategory == category
                            ? Colors.teal
                            : Colors.grey,
                      ),
                      child: Text(category),
                    );
                  }).toList(),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    '이곳에 나의 냉장고 데이터가 표시됩니다.',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: Consumer<AuthProvider>(
        builder: (context, auth, child) {
          if (!auth.isLoggedIn) {
            return FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              child: Icon(Icons.login),
            );
          }
          return FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/add_ingredient',
                arguments: {'userId': auth.userId}, // `userId` 전달
              );
            },
            child: Icon(Icons.add),
          );
        },
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onTap: _onBottomNavTap,
      ),
    );
  }
}
