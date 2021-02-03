import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:together/Constants.dart';
import 'package:together/screens/diary_screen.dart';

class ViewDiaryScreen extends StatefulWidget {
  static const String id = 'view_diary_screen';
  @override
  _ViewDiaryScreenState createState() => _ViewDiaryScreenState();
}

class ArgumentDiary {
  final String id;
  final String title;
  final String content;
  final String location;
  final Timestamp date;
  final List<dynamic> images;
  final List<dynamic> imagesPath;
  ArgumentDiary(this.id, this.title, this.content, this.location, this.date,
      this.images, this.imagesPath);
}

class ArgumentRoomAndDiary {
  ArgumentRoom argumentRoom;
  ArgumentDiary argumentDiary;
  ArgumentRoomAndDiary(argumentRoom, DiaryCard diaryCard) {
    this.argumentRoom = argumentRoom;
    this.argumentDiary = ArgumentDiary(
        diaryCard.id,
        diaryCard.title,
        diaryCard.content,
        diaryCard.location,
        diaryCard.date,
        diaryCard.images,
        diaryCard.imagesPath);
  }
}

class _ViewDiaryScreenState extends State<ViewDiaryScreen> {
  @override
  Widget build(BuildContext context) {
    final ArgumentRoomAndDiary argumentRoomAndDiary =
        ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        // title: Text('약속 명칭'),
        title: Text(argumentRoomAndDiary.argumentDiary.title),
        backgroundColor: kPrimaryColor,
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              const PopupMenuItem(child: Text('수정하기')),
              const PopupMenuItem(child: Text('삭제하기')),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                //Text(argumentRoomAndDiary.argumentDiary.title),
                Text(
                  argumentRoomAndDiary.argumentDiary.content,
                  style: TextStyle(color: Colors.black.withOpacity(0.6)),
                ),
                Image(
                  image: NetworkImage(
                      argumentRoomAndDiary.argumentDiary.imagesPath[1]),
                ),
                FlatButton(
                  onPressed: () {
                    // Perform some action
                  },
                  child: const Text('댓글'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
