import 'package:flutter/material.dart';

class ViewDiaryScreen extends StatefulWidget {
  static const String id = 'view_diary_screen';
  @override
  _ViewDiaryScreenState createState() => _ViewDiaryScreenState();
}

class _ViewDiaryScreenState extends State<ViewDiaryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff03dac6),
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
        onTap: () {},
        child: Column(
          children: [
            ListTile(
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
                  textColor: const Color(0xFF6200EE),
                  onPressed: () {
                    // Perform some action
                  },
                  child: const Text('댓글'),
                ),
                FlatButton(
                  textColor: const Color(0xFF6200EE),
                  onPressed: () {
                    // Perform some action
                  },
                  child: Icon(Icons.favorite),
                ),
                FlatButton(
                  textColor: const Color(0xFF6200EE),
                  onPressed: () {
                    // Perform some action
                  },
                  child: Icon(Icons.share),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
