import 'package:flutter/material.dart';

class User extends ChangeNotifier {
  Map<String, dynamic> _user = {};

  void setUser(user){
    this._user = user;
  }

  Map<String, dynamic> getUser(){
    return this._user;
  }

  String getEmail(){
    return this._user["email"];
  }
}