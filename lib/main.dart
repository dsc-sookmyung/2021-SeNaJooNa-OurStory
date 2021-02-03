import 'package:flutter/material.dart';
import 'package:together/screens/diary_screen.dart';
import 'package:together/screens/group_screen.dart';
import 'package:together/screens/view_diary_screen.dart';
import 'package:together/screens/welcome_screen.dart';
import 'package:together/screens/login_screen.dart';

import 'package:provider/provider.dart';
import 'models/User.dart';
import 'models/Group.dart';
import 'models/Diary.dart';

// void main() => runApp(MyApp());
void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => User()),
      ChangeNotifierProvider(create: (_) => Group()),
      ChangeNotifierProvider(create: (_) => Diary()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        GroupScreen.id: (context) => GroupScreen(),
        ViewDiaryScreen.id: (context) => ViewDiaryScreen(),
        DiaryScreen.id: (context) => DiaryScreen(),
      },
    );
  }
}
