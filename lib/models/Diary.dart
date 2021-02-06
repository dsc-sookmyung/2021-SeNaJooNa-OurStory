import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Diary extends ChangeNotifier {
  Map<String, dynamic> _diary_info = {};
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void addDiary(
      {String groupId,
      String title,
      String content,
      String location,
      List<String> images}) {
    _firestore.collection('Diary').doc(groupId).collection('Contents').add({
      'title': title,
      'content': content,
      'location': location,
      'date': Timestamp.now(),
      'images': images,
    });
    notifyListeners();
  }

  Future<List<Map<String, dynamic>>> getDiaryFromRoomId(roomId) async {
    List<Map<String, dynamic>> _diaries = List<Map<String, dynamic>>();
    await this
        ._firestore
        .collection('Diary')
        .doc(roomId)
        .collection('Contents')
        .orderBy('date', descending: true)
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

  // delete
  void deleteDiary({dynamic diaryId, dynamic roomId}) {
    print("[deleteDiary]");
    print(roomId);
    print(diaryId);
    _firestore
        .collection('Diary')
        .doc(roomId)
        .collection('Contents')
        .doc(diaryId)
        .delete();
    notifyListeners();
  }

  Future<void> updateDiary(
      {dynamic diaryId, dynamic roomId, String title, String content}) {
    notifyListeners();
    return _firestore
        .collection('Diary')
        .doc(roomId)
        .collection('Contents')
        .doc(diaryId)
        .update({
      'title': title,
      'content': content,
    });
  }
}
