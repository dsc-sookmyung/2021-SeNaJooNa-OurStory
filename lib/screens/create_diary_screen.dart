import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:together/Constants.dart';

class CreateDiaryScreen extends StatefulWidget {
  @override
  _CreateDiaryScreenState createState() => _CreateDiaryScreenState();
}

class _CreateDiaryScreenState extends State<CreateDiaryScreen> {
  File _image;
  TextEditingController _diaryController = TextEditingController();

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
            onPressed: () {},
            child: Text("SAVE"),
            shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              onChanged: (value) {},
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
            _image == null ? Text('no image') : Image.file(_image),
            TextField(
              onChanged: (value) {},
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPLightColor,
        foregroundColor: Colors.black,
        onPressed: _getImage,
        child: Icon(Icons.add_a_photo),
      ),
    );
  }

  Future _getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }
}
