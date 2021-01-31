import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class User extends ChangeNotifier {
  Map<String, dynamic> _user = {};
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void setUser(user){
    this._user = user;
    this._firestore.collection('User').doc(user["email"]).get()
    .then((value) => {
      if(!value.exists){
        this._firestore.collection('User').doc(user["email"]).set(
          {
            'name': user["name"]
          }
        )
      }
    })
    .catchError((error) =>
      print("get user error!")
    );
  }

  Map<String, dynamic> getUser(){
    return this._user;
  }

  String getEmail(){
    return this._user["email"];
  }
}