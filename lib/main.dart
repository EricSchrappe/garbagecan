import 'package:flutter/material.dart';
import 'package:garbagecan/model/date_slots_data.dart';
import 'package:garbagecan/screens/calendar_screen.dart';
import 'package:garbagecan/screens/welcome_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => DateSlotsData(),
      child: GarbageCANApp(),
    ),
  );
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
