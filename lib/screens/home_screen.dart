import 'package:flutter/material.dart';
import '../services/db_service.dart';
import '../widgets/bottom_navbar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> ingredients = [];
  String selectedCategory = '냉장'; // 기본 카테고리
  int _selectedIndex = 0; // 현재 선택된 하단바 탭 인덱스

  Future<void> fetchIngredients({String? category}) async {
    final db = DatabaseService();
    final data = await db.fetchIngredients();

    if (category != null) {
      data.removeWhere((ingredient) => ingredient['storage'] != category);
    }

    data.sort((a, b) {
      final expiryA = DateTime.parse(a['expiryDate']);
      final expiryB = DateTime.parse(b['expiryDate']);
      return expiryA.compareTo(expiryB);
    });

    setState(() {
      ingredients = data;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchIngredients();
  }

  bool isExpirySoon(String expiryDate) {
    final now = DateTime.now();
    final expiry = DateTime.parse(expiryDate);
    final difference = expiry.difference(now).inDays;
    return difference <= 3;
  }

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
    final filteredIngredients = ingredients
        .where((ingredient) => ingredient['storage'] == selectedCategory)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('나의 냉장고'),
        centerTitle: true,
      ),
      body: Column(
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
            child: filteredIngredients.isEmpty
                ? Center(
                    child: Text(
                      '해당 보관 위치에 식재료가 없습니다.',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: filteredIngredients.length,
                    itemBuilder: (context, index) {
                      final item = filteredIngredients[index];
                      final isSoon = isExpirySoon(item['expiryDate']);
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        color: isSoon ? Colors.red[50] : Colors.white,
                        elevation: 3,
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: isSoon ? Colors.red : Colors.teal,
                            child: Icon(
                              isSoon ? Icons.warning : Icons.kitchen,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(
                            item['name'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          subtitle: Text(
                              '유통기한: ${item['expiryDate']} (보관 위치: ${item['storage']})'),
                          trailing: Icon(Icons.arrow_forward_ios, size: 16),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.pushNamed(context, '/add_ingredient');
          if (result == true) {
            fetchIngredients();
          }
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onTap: _onBottomNavTap,
      ),
    );
  }
}
