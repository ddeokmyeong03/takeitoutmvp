import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const BottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.kitchen),
          label: '냉장고',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.restaurant_menu),
          label: '레시피',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: '내 페이지',
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Colors.teal,
      unselectedItemColor: Colors.grey,
      onTap: onTap,
    );
  }
}
