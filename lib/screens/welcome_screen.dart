import 'package:flutter/material.dart';
import 'package:together/Constansts.dart';
import 'package:together/components/rounded_button.dart';
import 'package:together/screens/group_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset('assets/welcome_image.jpg'),
            RoundedButton(
              title: 'Google 계정 로그인',
              colour: kPrimaryColor,
              onPressed: () {
                Navigator.pushNamed(context, GroupScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
