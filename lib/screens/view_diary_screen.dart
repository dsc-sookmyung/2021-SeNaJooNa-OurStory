import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:together/Constants.dart';
import 'package:together/screens/diary_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ArgumentDiary {
  String id;
  String title;
  String content;
  String location;
  Timestamp date;
  List<String> images;
  List<String> imagesPath;
  ArgumentDiary(id, title, content, location, date, images, imagesPath) {
    this.id = id;
    this.title = title;
    this.content = content;
    this.location = location;
    this.date = date;
    this.images = images.cast<String>();
    this.imagesPath = imagesPath.cast<String>();
  }
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

List<String> imgList;

class ViewDiaryScreen extends StatefulWidget {
  static const String id = 'view_diary_screen';
  @override
  _ViewDiaryScreenState createState() => _ViewDiaryScreenState();
}

class _ViewDiaryScreenState extends State<ViewDiaryScreen> {
  @override
  Widget build(BuildContext context) {
    final ArgumentRoomAndDiary argumentRoomAndDiary =
        ModalRoute.of(context).settings.arguments;
    imgList = argumentRoomAndDiary.argumentDiary.imagesPath;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ), //
        title: Text(
          argumentRoomAndDiary.argumentDiary.title,
          style: TextStyle(color: Colors.black),
        ),
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
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            // margin: EdgeInsets.all(4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.location_on),
                    Text(argumentRoomAndDiary.argumentDiary.location),
                  ],
                ),
                SizedBox(height: 8.0),
                Divider(
                  height: 1,
                  thickness: 1,
                ),
                SizedBox(height: 8.0),
                Row(
                  children: [
                    Icon(Icons.today),
                    Text(
                      DateFormat.yMd().add_jm().format(
                          argumentRoomAndDiary.argumentDiary.date.toDate()),
                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
                Divider(
                  height: 1,
                  thickness: 1,
                ),
                CarouselWithIndicator(),
                Divider(
                  height: 1,
                  thickness: 1,
                ),
                SizedBox(height: 8.0),
                Text(argumentRoomAndDiary.argumentDiary.content),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CarouselWithIndicator extends StatefulWidget {
  @override
  _CarouselWithIndicatorState createState() => _CarouselWithIndicatorState();
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicator> {
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8.0),
      child: Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
                height: 350.0,
                enableInfiniteScroll: false,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
            items: imgList.map<Widget>((item) {
              // return Builder(builder: (BuildContext context) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 3.0),
                child: Image(
                  image: NetworkImage(item),
                ),
              );
              // });
            }).toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imgList.map<Widget>((url) {
              int index = imgList.indexOf(url);
              return Container(
                width: 8.0,
                height: 8.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == index
                      ? Colors.black.withOpacity(0.87)
                      : Colors.black.withOpacity(0.38),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
