import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:together/Constants.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../models/Group.dart';
import '../models/Diary.dart';

class CreateDiaryScreen extends StatefulWidget {
  @override
  _CreateDiaryScreenState createState() => _CreateDiaryScreenState();
}

class _CreateDiaryScreenState extends State<CreateDiaryScreen> {
  File _image;
  String diaryTitle;
  String diaryContent;
  String diaryLocation = '';
  List<String> diaryImages = [];
  TextEditingController _diaryController = TextEditingController();
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  @override
  void dispose() {
    _diaryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(
          '추억 작성하기',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          FlatButton(
            textColor: Colors.black,
            onPressed: () {
              Provider.of<Diary>(context, listen: false).addDiary(
                  groupId: Provider.of<Group>(context, listen: false)
                      .getGroupInfo()['id'],
                  title: diaryTitle,
                  content: diaryContent,
                  location: diaryLocation,
                  images: diaryImages);
              // _diaryController.clear();
              Navigator.pop(context);
            },
            child: Text("SAVE"),
            shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
          ),
        ],
      ),
      body: SingleChildScrollView(
          child: Column(children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextField(
                minLines: 1,
                maxLines: 2,
                onChanged: (value) {
                  diaryTitle = value;
                },
                decoration: InputDecoration(
                  hintText: '제목',
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 20.0,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                ),
              ),
              _image == null
                  ? Text('no image')
                  : Image.file(_image, height: 200),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      child: Text('Gallery'),
                      onPressed: () {
                        uploadFile(
                            ImageSource.gallery,
                            Provider.of<Group>(context, listen: false)
                                .getGroupInfo()['id']);
                      },
                    ),
                    RaisedButton(
                      child: Text('Camera'),
                      onPressed: () {
                        uploadFile(
                            ImageSource.camera,
                            Provider.of<Group>(context, listen: false)
                                .getGroupInfo()['id']);
                      },
                    )
                  ]),
              TextField(
                minLines: 1,
                maxLines: 4,
                onChanged: (value) {
                  diaryContent = value;
                },
                decoration: InputDecoration(
                  hintText: '내용 작성',
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 20.0,
                    horizontal: 20.0,
                  ),
                ),
                controller: _diaryController,
              ),
            ],
          ),
        ),
      ])),
    );
  }

  Future _getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  Future<void> uploadFile(ImageSource source, String groupId) async {
    File image = await ImagePicker.pickImage(source: source);

    String imageName = groupId + '_' + Timestamp.now().toString() + '.png';
    print(imageName);

    try {
      await _firebaseStorage
          .ref()
          .child('diary_image/${imageName}')
          .putFile(image);
      diaryImages.add(imageName);
    } on FirebaseException catch (e) {}

    if (image == null) return;
    setState(() {
      _image = image;
    });
  }
}
