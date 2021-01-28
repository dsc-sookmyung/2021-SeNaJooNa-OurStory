import 'package:flutter/material.dart';
import 'package:together/screens/group_page_screen.dart';
import 'package:together/screens/group_screen.dart';
import 'package:together/screens/view_diary_screen.dart';
import 'package:together/screens/welcome_screen.dart';
import 'package:together/screens/registration_screen.dart';
import 'package:together/screens/login_screen.dart';
import 'package:together/screens/calendar_screen.dart';
import 'package:together/screens/chat_screen.dart';
import 'package:together/screens/map_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        GroupScreen.id: (context) => GroupScreen(),
        GroupPageScreen.id: (context) => GroupPageScreen(),
        CalendarScreen.id: (context) => CalendarScreen(),
        MapScreen.id: (context) => MapScreen(),
        ChatScreen.id: (context) => ChatScreen(),
        ViewDiaryScreen.id: (context) => ViewDiaryScreen(),
      },
    );
  }
}
