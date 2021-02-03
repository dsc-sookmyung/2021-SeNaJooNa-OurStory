import 'package:flutter/material.dart';
import 'package:together/Constants.dart';
import 'package:together/screens/view_diary_screen.dart';

import 'package:cloud_firestore/cloud_firestore.dart'; //---------
import 'package:firebase_storage/firebase_storage.dart'; //---------
import 'package:provider/provider.dart';
import '../models/Diary.dart';
import '../models/Group.dart';
import '../models/User.dart';

//---------
class RoomClass {
  final String roomId;
  final String roomName;

  RoomClass(this.roomId, this.roomName);
}

//---------
class DiaryScreen extends StatefulWidget {
  static const String id = 'diary_screen';

  @override
  _DiaryScreenState createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  @override
  Widget build(BuildContext context) {
    //---------
    final RoomClass argument = ModalRoute.of(context).settings.arguments;
    // print(argument.roomId);
    // print(argument.roomName);
    String roomName = argument.roomName;
    //---------
    return Scaffold(
      appBar: AppBar(
        title: Text(roomName), //----------
        backgroundColor: kPrimaryColor,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPLightColor,
        foregroundColor: Colors.black,
        onPressed: () {
          // Respond to button press
          // getDataFromFireStore(argument.roomId);
          // getImageFromFireStorage();
          testtest(argument.roomId);
        },
        child: Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            DiaryCard(),
            DiaryCard(),
          ],
        ),
      ),
    );
  }

  Widget testtest(String roomIddd) {
    String email = Provider.of<User>(context, listen: false).getEmail();
    print(email);
    return FutureBuilder(
      builder: (context, diarySnap) {
        print('a');
      },
      future: Provider.of<Diary>(context, listen: false)
          .getDiariesIdListFromRoomId(roomIddd),
    );
  }
}

void getDataFromFireStore(String roomId) {
  // FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //
  // CollectionReference collecRef =
  //     _firestore.collection('Diary').doc(roomId).collection('Contents');

  // collecRef
  //     .get()
  //     .then((QuerySnapshot querySnapShot) => querySnapShot.docs.forEach((doc) {
  //           print(doc.id);
  //           print(doc.data());
  //         })); // 한 group에 대한 공동일기 id 목록

  // DocumentReference doc1Ref = collecRef.doc('Ddi3v8EbmZUuijISjakt');
  // doc1Ref.get().then((DocumentSnapshot documentSnapshot) =>
  //     documentSnapshot.data().forEach((key, value) {
  //       print(key);
  //       print(value);
  //     })); // 일기 1개에 대한 내용 가져오기

  // CollectionReference commentsRef = doc1Ref.collection('Comments');
  // commentsRef
  //     .get()
  //     .then((QuerySnapshot querySnapShot) => querySnapShot.docs.forEach((doc) {
  //           print(doc.id);
  //           print(doc.data());
  //         })); // 일기 1개에 대한 한 사용자의 댓글들 가져오기
}

String getImageFromFireStorage() {
  FirebaseStorage storage = FirebaseStorage.instance;
  var storageRef = storage.ref();
  var imagesRef = storageRef.child('diary_image');
  var laputaRef = storageRef.child('diary_image/laputa.png');

  String https = 'https://firebasestorage.googleapis.com/v0/b/';
  String bucket = laputaRef.bucket;
  String folder = '/o/diary_image%2F';
  String name = laputaRef.name;
  name = name.replaceRange(name.length - 3, null, 'PNG');
  String contentType = '?alt=media';

  String myHttp = https + bucket + folder + name + contentType;
  // print(myHttp);
  return myHttp;
}

class DiaryCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String imagePath = getImageFromFireStorage();
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, ViewDiaryScreen.id);
        },
        child: Column(
          children: [
            ListTile(
              trailing: PopupMenuButton(
                icon: Icon(Icons.more_vert),
                itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                  const PopupMenuItem(child: Text('수정하기')),
                  const PopupMenuItem(child: Text('삭제하기')),
                ],
              ),
              leading: Icon(Icons.arrow_drop_down_circle),
              title: const Text('약속 명칭'),
              subtitle: Text(
                '장소',
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
              ),
            ),
            Image(
              // image: NetworkImage(
              //     'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
              image: NetworkImage(imagePath),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('날짜'),
                  Text('함께 한 사람'),
                  Text(
                    'Greyhound divisively hello coldly wonderfully marginally far upon excluding.',
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                ],
              ),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.end,
              children: [
                FlatButton(
                  textColor: kPDarkColor,
                  onPressed: () {
                    // Perform some action
                  },
                  child: const Text('댓글'),
                ),
                FlatButton(
                  onPressed: () {
                    // Perform some action
                  },
                  child: Icon(
                    Icons.favorite,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
