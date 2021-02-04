import 'package:flutter/material.dart';
import 'package:together/Constants.dart';

class AddDiaryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text('추억 작성하기'),
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
            SizedBox(
              height: 48.0,
            ),
            const Divider(
              color: Colors.grey,
              height: 10,
              thickness: 2,
              indent: 10,
              endIndent: 10,
            ),
            //image picker
            const Divider(
              color: Colors.grey,
              height: 10,
              thickness: 2,
              indent: 10,
              endIndent: 10,
            ),
            TextField(
              onChanged: (value) {},
              decoration: InputDecoration(
                hintText: '내용 작성',
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 20.0,
                ),
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            const Divider(
              color: Colors.grey,
              height: 10,
              thickness: 2,
              indent: 10,
              endIndent: 10,
            ),
          ],
        ),
      ),
    );
  }
}
