import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class User extends ChangeNotifier {
  Map<String, dynamic> _user = {};
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void setUser(user){
    this._user = user;
    // this._firestore.collection('User').doc(user.email).get().catchError((error) =>
    //   this._firestore.collection('User').add(
    //     {
    //       '$user.email':{
    //         'name': user.name
    //       }
    //     }
    //   )
    // );
  }

  Map<String, dynamic> getUser(){
    return this._user;
  }

  String getEmail(){
    return this._user["email"];
  }
}