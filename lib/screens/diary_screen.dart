import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:together/Constants.dart';
import 'package:together/screens/view_diary_screen.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';
import '../models/Diary.dart';
import '../models/Group.dart';
import '../models/User.dart';

class ArgumentRoom {
  final String roomId;
  final String roomName;
  ArgumentRoom(this.roomId, this.roomName);
}

class DiaryScreen extends StatefulWidget {
  static const String id = 'diary_screen';

  @override
  _DiaryScreenState createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  @override
  Widget build(BuildContext context) {
    final ArgumentRoom argumentRoom = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(
          title: Text(argumentRoom.roomName),
          backgroundColor: kPrimaryColor,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: kPLightColor,
          foregroundColor: Colors.black,
          onPressed: () {
            // Respond to button press
          },
          child: Icon(Icons.add),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: diaryWidget(argumentRoom),
        ));
  }

  Widget diaryWidget(argumentRoom) {
    return FutureBuilder(
      builder: (context, diarySnap) {
        if (diarySnap.connectionState == ConnectionState.none &&
                diarySnap.hasData == null ||
            diarySnap.hasData == false) {
          return Container(); // 여기에 There is no diary 같이 보여주고 싶어서 child: Text('There is no diary')라고 해봤는데 안 나와요.
        }
        return ListView.builder(
          itemCount: diarySnap.data.length,
          itemBuilder: (content, index) {
            Map<String, dynamic> diary = diarySnap.data[index];
            return Column(
              children: <Widget>[
                DiaryCard(
                    diary['id'],
                    diary['title'],
                    diary['content'],
                    diary['location'],
                    diary['date'],
                    diary['images'],
                    argumentRoom,
                    // delete
                    (value) {
                      if (value == 1) {
                        Provider.of<Diary>(context,listen: false).deleteDiary(diaryId:diary['id'], roomId: Provider.of<Group>(context,listen: false).getGroupInfo()["id"]);
                      }
                    }
                  )
              ],
            );
          },
        );
      },
      future: Provider.of<Diary>(context)   // 삭제하면 바로 반영되게 listen:false 지움
          .getDiaryFromRoomId(argumentRoom.roomId),
    );
  }
}

class DiaryCard extends StatelessWidget {
  String id;
  String title;
  String content;
  String location;
  Timestamp date;
  List<dynamic> images;
  List<dynamic> imagesPath;
  ArgumentRoom argumentRoom;

  Function diarySetting; //delete

  DiaryCard(id, title, content, location, date, images, argumentRoom, diarySetting) {
    this.id = id;
    this.title = title;
    this.content = content;
    this.location = location;
    this.date = date;
    this.images = images;
    this.imagesPath =
        images.map((imageName) => getImageURLFromImageName(imageName)).toList();
    this.argumentRoom = argumentRoom;
    this.diarySetting = diarySetting;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, ViewDiaryScreen.id,
              // arguments: Argument(
              //     this.argument.roomId, this.argument.roomName, this.id));
              arguments: ArgumentRoomAndDiary(argumentRoom, this));
        },
        child: Column(
          children: [
            ListTile(
              trailing: PopupMenuButton(
                icon: Icon(Icons.more_vert),
                onSelected: diarySetting,   // delete
                itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                  const PopupMenuItem(child: Text('수정하기')),
                  const PopupMenuItem(
                    child: Text('삭제하기'),
                    value: 1,   // delete
                  ),
                ],
              ),
              title: Text(this.title),
              subtitle: Text(
                this.location,
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
              ),
            ),
            Image(
              image: NetworkImage(this.imagesPath[0]),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(DateFormat.yMd().add_jm().format(this.date.toDate())),
                  Text(
                    this.content,
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String getImageURLFromImageName(String imageName) {
  FirebaseStorage storage = FirebaseStorage.instance;
  var storageRef = storage.ref();
  var imageRef = storageRef.child('diary_image/' + imageName);

  String https = 'https://firebasestorage.googleapis.com/v0/b/';
  String bucket = imageRef.bucket;
  String folder = '/o/diary_image%2F';
  String name = imageRef.name;
  String contentType = '?alt=media';

  String imageURL = https + bucket + folder + name + contentType;
  return imageURL;
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
