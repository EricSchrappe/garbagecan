import 'package:flutter/material.dart';
import 'package:garbagecan/screens/user/calendar_screen.dart';
import 'package:garbagecan/screens/user/my_pick_ups.dart';

class TabNavigationItem {
  Widget screen;
  String title;
  Icon icon;

  TabNavigationItem({this.screen, this.title, this.icon});

  static List<TabNavigationItem> get items => [
        TabNavigationItem(
          screen: CalendarScreen(),
          title: 'Schedule Pickup',
          icon: Icon(Icons.schedule),
        ),
        TabNavigationItem(
          screen: MyPickups(),
          title: 'My Pickups',
          icon: Icon(Icons.person),
        ),
      ];
}
