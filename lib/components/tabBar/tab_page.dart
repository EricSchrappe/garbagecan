import 'package:flutter/material.dart';
import 'tab_navigation_item.dart';

class TabsPage extends StatefulWidget {
  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          for (final item in TabNavigationItem.items) item.screen,
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white38,
        backgroundColor: Color(0xFF3A6ED4),
        currentIndex: _currentIndex,
        items: [
          for (final item in TabNavigationItem.items)
            BottomNavigationBarItem(
              icon: item.icon,
              label: item.title,
            ),
        ],
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
