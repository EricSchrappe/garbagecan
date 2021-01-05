import 'package:flutter/material.dart';
import 'package:garbagecan/screens/calendar_screen.dart';
import 'package:garbagecan/screens/welcome_screen.dart';

void main() {
  runApp(GarbageCANApp());
}

class GarbageCANApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        fontFamily: 'SourceSansPro',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomeScreen(),
        '/calendar': (context) => CalendarScreen(),
      },
    );
  }
}
