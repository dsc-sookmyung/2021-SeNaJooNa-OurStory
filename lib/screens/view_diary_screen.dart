import 'package:flutter/material.dart';
import 'package:together/Constants.dart';

class ViewDiaryScreen extends StatefulWidget {
  static const String id = 'view_diary_screen';
  @override
  _ViewDiaryScreenState createState() => _ViewDiaryScreenState();
}

class _ViewDiaryScreenState extends State<ViewDiaryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('약속 명칭'),
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
                Text('제목'),
                Text(
                  'Greyhound divisively hello coldly wonderfully marginally far upon excluding.',
                  style: TextStyle(color: Colors.black.withOpacity(0.6)),
                ),
                Image(
                  image: NetworkImage(
                      'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
                ),
                FlatButton(
                  onPressed: () {
                    // Perform some action
                  },
                  child: const Text('댓글'),
                ),
                FlatButton(
                  onPressed: () {
                    // Perform some action
                  },
                  child: Icon(Icons.favorite),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
