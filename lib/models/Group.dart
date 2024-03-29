import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Group extends ChangeNotifier {
  Map<String, dynamic> _group_info = {};
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void setGroup(group) {
    this._group_info = group;
  }

  void addGroup({String name, List<String> users, String email}) {
    users.insert(0, email);

    _firestore.collection('Room').add({
      'name': name,
      'time': Timestamp.now(),
      'users': users,
    });
    notifyListeners();
  }

  Future<void> removeGroup({dynamic id}) {
    notifyListeners();
    return _firestore.collection('Room').doc(id).delete();
  }

  Future<void> leaveGroup({dynamic groupID, String email}) {
    notifyListeners();
    return _firestore.collection('Room').doc(groupID).update({
      'users': FieldValue.arrayRemove([email])
    });
  }

  // Future<void> renameGroup({String name}) {
  //   notifyListeners();
  //   return _firestore.collection('Room').doc(this._group_info["id"]).update({
  //     'name': name,
  //   });
  // }

  Future<void> addUser({dynamic users, String email, String name}) {
    notifyListeners();
    print("[CHANGE ROOM]");
    print(name);
    print(users);
    users.insert(0, email);
    return _firestore.collection('Room').doc(this._group_info["id"]).update({
      'name': name,
      'users': users
    });
  }

  Future<List<Map<String, dynamic>>> getGroupsList(userId) async {
    List<Map<String, dynamic>> _groups = List<Map<String, dynamic>>();
    await this
        ._firestore
        .collection('Room')
        .where('users', arrayContains: userId)
        .orderBy('time')
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) async {
                if (doc.id != null) {
                  _groups.add({
                    "id": doc.id,
                    "name": doc["name"],
                    "emails": doc["users"],
                    "users": getUsers(doc["users"])
                  });
                }
              })
            });
    return _groups;
  }

  Future<List<String>> getUsers(users) async {
    List<String> userInfo = List<String>();
    for (var i = 0; i < users.length; i++) {
      await this
          ._firestore
          .collection('User')
          .doc(users[i])
          .get()
          .then((value) => {userInfo.add(value["name"])})
          .catchError((error) => {print("No User")});
    }
    return userInfo;
  }

  Map<String, dynamic> getGroupInfo() {
    return this._group_info;
  }
  Future<List<dynamic>> getEmails() async{
    List<dynamic> emails = [];
    await this
      ._firestore
      .collection('Room')
      .doc(this._group_info["id"])
      .get()
      .then((value) => {emails = value["users"]});
    return emails;
  }
}
