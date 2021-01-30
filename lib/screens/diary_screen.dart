import 'package:flutter/material.dart';
import 'package:together/Constants.dart';
import 'package:together/screens/view_diary_screen.dart';

class DiaryScreen extends StatefulWidget {
  static const String id = 'diary_screen';
  @override
  _DiaryScreenState createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('모임명'),
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
        child: ListView(
          children: [
            DiaryCard(),
            DiaryCard(),
          ],
        ),
      ),
    );
  }
}

class DiaryCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              image: NetworkImage(
                  'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
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
