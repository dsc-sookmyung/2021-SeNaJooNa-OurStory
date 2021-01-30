import 'package:flutter/material.dart';
import 'package:together/screens/diary_screen.dart';

class GroupCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          children: [
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, DiaryScreen.id);
              },
              leading: Icon(Icons.photo),
              title: Text('Card title 1'),
              subtitle: Text('name, name, name'),
            ),
          ],
        ),
      ),
    );
  }
}
