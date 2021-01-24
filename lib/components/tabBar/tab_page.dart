import 'package:flutter/material.dart';
import 'tab_navigation_item.dart';

class TabsPage extends StatefulWidget {
  final startIndex;

  TabsPage({this.startIndex = 0});

  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  int _currentIndex = 0;
  int _counter = 0;

  int getCurrentIndex(int x) {
    if (x == 1 && _counter == 0) {
      _counter++;
      return _currentIndex = 1;
    } else if (x == 1 && _counter != 0) {
      return _currentIndex;
    } else {
      return _currentIndex;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: getCurrentIndex(widget.startIndex),
        children: [
          for (final item in TabNavigationItem.items) item.screen,
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white38,
        backgroundColor: Color(0xFF3A6ED4),
        currentIndex: getCurrentIndex(widget.startIndex),
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
