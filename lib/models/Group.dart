import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Group extends ChangeNotifier {
  Map<String, dynamic> _group_info = {};
  
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void setGroup(groupId){

  }

  Future<List<Map<String, dynamic>>> getGroupsList(userId) async {
    // this._firestore.collection('User').doc(userId).collection('Room').get()
    // .then((QuerySnapshot querySnapshot) => {
    //     querySnapshot.docs.forEach((doc) {
    //         this._firestore.collection('Room').doc(doc.id).get().then((DocumentSnapshot documentSnapshot) => {
    //           // _groups.add(documentSnapshot)
    //           print(documentSnapshot.data())
    //         });
    //         print(_groups);
    //     })
    // });
    List<Map<String, dynamic>> _groups = List<Map<String, dynamic>>();
    await this._firestore.collection('Room').where('users', arrayContains:userId).get()
    .then((QuerySnapshot querySnapshot) => {
        querySnapshot.docs.forEach((doc) async {
            _groups.add({
                  "id": doc.id,
                  "name": doc["name"],
                  "users": getUsers(doc["users"])
            });
        })
    });
    return _groups;
  }

  Future<List<String>> getUsers(users) async{
    List<String> userInfo = List<String>();
    for(var i=0;i<users.length;i++){
      await this._firestore.collection('User').doc(users[i]).get().then((value)=>{
          userInfo.add(value["name"])
      });
    }
    return userInfo;
  }

  Map<String, dynamic> getGroupInfo(){
    return this._group_info;
  }
}