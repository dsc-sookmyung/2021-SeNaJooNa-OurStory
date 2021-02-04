import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:together/Constants.dart';
import 'package:together/screens/diary_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ViewDiaryScreen extends StatefulWidget {
  static const String id = 'view_diary_screen';
  @override
  _ViewDiaryScreenState createState() => _ViewDiaryScreenState();
}

// class ArgumentDiary {
//   final String id;
//   final String title;
//   final String content;
//   final String location;
//   final Timestamp date;
//   final List<dynamic> images;
//   final List<dynamic> imagesPath;
//   ArgumentDiary(this.id, this.title, this.content, this.location, this.date,
//       this.images, this.imagesPath);
// }

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

List<String> imgListst;

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
    imgListst = argumentRoomAndDiary.argumentDiary.imagesPath;
    return Scaffold(
      appBar: AppBar(
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
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(argumentRoomAndDiary.argumentDiary.location),
                Text(
                  DateFormat.yMd()
                      .add_jm()
                      .format(argumentRoomAndDiary.argumentDiary.date.toDate()),
                  style: TextStyle(color: Colors.black.withOpacity(0.6)),
                ),
                CarouselWithIndicator(),
                // imageSliderWidget(
                //     argumentRoomAndDiary.argumentDiary.imagesPath),
                Text(argumentRoomAndDiary.argumentDiary.content),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // final List<Widget> imageSliders = imgListst.map((item) => Container(
  //       child: Container(
  //         margin: EdgeInsets.all(5.0),
  //         child: ClipRRect(
  //           borderRadius: BorderRadius.all(Radius.circular(5.0)),
  //           child: Stack(
  //             children: <Widget>[
  //               Image.network(item, fit: BoxFit.cover, width: 1000.0),
  //               Positioned(
  //                 bottom: 0.0,
  //                 left: 0.0,
  //                 right: 0.0,
  //                 child: Container(
  //                   decoration: BoxDecoration(
  //                     gradient: LinearGradient(
  //                       // colors: [
  //                       //   Color.fromARGB(200, 0, 0, 0),
  //                       //   Color.fromARGB(0, 0, 0, 0)
  //                       // ],
  //                       begin: Alignment.bottomCenter,
  //                       end: Alignment.topCenter,
  //                     ),
  //                   ),
  //                   padding:
  //                       EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  //                   child: Text(
  //                     'No. ${imgListst.indexOf(item)} image',
  //                     style: TextStyle(
  //                       color: Colors.white,
  //                       fontSize: 20.0,
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                   ),
  //                 ),
  //               )
  //             ],
  //           ),
  //         ),
  //       ),
  //     ));

  Widget imageSliderWidget(imgList) {
    int _current = 0;
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
              height: 250.0,
              enableInfiniteScroll: false,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
          items: imgList.map<Widget>((item) {
            // return Builder(builder: (BuildContext context) {
            return Container(
              child: Image(
                image: NetworkImage(item),
              ),
              // child: Image.network(
              //   item,
              //   fit: BoxFit.cover,
              //   width: 1000,
              // ),
            );
            // });
          }).toList(),
          // items: imageSliders,
          // items: [1, 2, 3, 4, 5].map((i) {
          //   return Builder(
          //     builder: (BuildContext context) {
          //       return Container(
          //           width: MediaQuery.of(context).size.width,
          //           margin: EdgeInsets.symmetric(horizontal: 3.0),
          //           decoration: BoxDecoration(color: Colors.amber),
          //           child: Center(
          //             child: Text(
          //               'text $i',
          //               style: TextStyle(fontSize: 16.0),
          //             ),
          //           ));
          //     },
          //   );
          // }).toList(),
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
            items: imgListst.map<Widget>((item) {
              // return Builder(builder: (BuildContext context) {
              return Container(
                child: Image(
                  image: NetworkImage(item),
                ),
              );
              // });
            }).toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imgListst.map<Widget>((url) {
              int index = imgListst.indexOf(url);
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
