import 'package:flutter/material.dart';
import 'package:garbagecan/components/tabBar/tab_page.dart';

class UserTabsPage extends StatelessWidget {
  final startIndex;

  UserTabsPage({this.startIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabsPage(
        startIndex: startIndex,
      ),
    );
  }
}
