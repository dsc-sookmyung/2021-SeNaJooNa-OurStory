import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Diary extends ChangeNotifier {
  Map<String, dynamic> _diary_info = {};
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void setDiary(groupId) {}

  void addDiary() {}

  Future<List<Map<String, dynamic>>> getDiaryFromRoomId(roomId) async {
    List<Map<String, dynamic>> _diaries = List<Map<String, dynamic>>();
    await this
        ._firestore
        .collection('Diary')
        .doc(roomId)
        .collection('Contents')
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) async {
                if (doc.id != null) {
                  _diaries.add({
                    'id': doc.id,
                    'title': doc['title'],
                    'content': doc['content'],
                    'date': doc['date'],
                    'location': doc['location'],
                    'images': doc['images']
                  });
                }
              })
            });
    return _diaries;
  }

  Map<String, dynamic> getDiaryInfo() {
    return this._diary_info;
  }
}
