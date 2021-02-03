import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Diary extends ChangeNotifier {
  Map<String, dynamic> _diary_info = {};
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void setDiary(groupId) {}

  void addDiary() {}

  Future<List<Map<String, dynamic>>> getDiariesIdListFromRoomId(
      roomIddd) async {
    List<Map<String, dynamic>> _diariesIdList = List<Map<String, dynamic>>();
    await this
        ._firestore
        .collection('Diary')
        .doc(roomIddd)
        .collection('Contents')
        .get()
        .then(
            (QuerySnapshot querySnapshot) => querySnapshot.docs.forEach((doc) {
                  if (doc.id != null) {
                    _diariesIdList.add({'id': doc.id});
                  }

                  // print(doc.id);
                  // print(doc.data());
                }));
    print(
        _diariesIdList); // 임의의 RoomId에 속한 공동일기 id list. ex) [{id: Ddi3v8EbmZUuijISjakt}, {id: I7u6ywmFGuui6jOB42WG}]
    return _diariesIdList;
  }

  Future<List<Map<String, dynamic>>> getDiary() async {
    List<Map<String, dynamic>> _diaries = List<Map<String, dynamic>>();
    await this
        ._firestore
        .collection('Diary')
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
                    'like': doc['like'],
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
