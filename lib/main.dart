import 'package:flutter/material.dart';
import 'package:garbagecan/model/date_slots_data.dart';
import 'package:garbagecan/model/item_data.dart';
import 'package:garbagecan/screens/user/thank_you_screen.dart';
import 'model/pickup_data.dart';
import 'package:garbagecan/screens/admin/time_slots_weekday_screen.dart';
import 'package:garbagecan/screens/user/calendar_screen.dart';
import 'package:garbagecan/components/tabBar/user_tabs.dart';
import 'package:garbagecan/screens/welcome_screen.dart';
import 'screens/user/contact_details_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DateSlotsData(),
        ),
        ChangeNotifierProvider(
          create: (context) => ItemData(),
        ),
        ChangeNotifierProvider(
          create: (context) => PickupData(),
        ),
      ],
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
        '/userTabs': (context) => UserTabsPage(),
        '/calendar': (context) => CalendarScreen(),
        '/contact': (context) => ContactDetails(),
        '/admin': (context) => TimeSlotsWeekday(),
        '/thanks': (context) => ThankYouScreen(),
      },
    );
  }
}
