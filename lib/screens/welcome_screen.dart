import 'package:flutter/material.dart';
import 'package:together/Constants.dart';
import 'package:together/components/rounded_button.dart';
import 'package:together/screens/group_screen.dart';

import 'package:provider/provider.dart'; 
import '../models/User.dart';
import '../models/sign_in.dart';

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
              // onPressed: () {
              //   Navigator.pushNamed(context, GroupScreen.id);
              // },
              onPressed: (){
                signInWithGoogle().then((result) {
                  if (result != null) {
                    print("[BEFORE setUser]");
                    Provider.of<User>(context, listen: false).setUser(result);
                    print("[AFTER setUser]");
                    Navigator.pushNamed(context, GroupScreen.id);
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
