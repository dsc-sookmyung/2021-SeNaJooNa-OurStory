import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:together/screens/add_group_screen.dart';
import 'package:together/screens/group_page_screen.dart';

class GroupScreen extends StatefulWidget {
  static const String id = 'group_screen';
  @override
  _GroupScreenState createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => AddGroupScreen(),
              fullscreenDialog: true,
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      appBar: AppBar(
        backgroundColor: Color(0xFF6200EE),
        bottom: PreferredSize(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "모임 목록",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.0,
              ),
            ),
          ),
          preferredSize: Size(0.0, 80.0),
        ),
        // leading: IconButton(
        //   icon: Icon(Icons.menu),
        //   onPressed: () {},
        // ),
        // title: Text('모임 목록'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add_alert,
              color: Colors.white,
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.share,
              color: Colors.white,
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
        ],
      ),
      drawer: Navigation_Drawer(),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 30.0,
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                GroupCard(),
                GroupCard(),
                GroupCard(),
              ],
            ),
          ),
          // FloatingActionButton(
          //   backgroundColor: Colors.lightBlueAccent,
          //   onPressed: () {
          //     // Respond to button press
          //   },
          //   child: Icon(Icons.add),
          // ),
        ],
      ),
    );
  }
}

class Navigation_Drawer extends StatelessWidget {
  const Navigation_Drawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Drawer Header',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ),
          Divider(
            height: 1,
            thickness: 1,
          ),
          ListTile(
            leading: Icon(Icons.message),
            title: Text('Messages'),
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Profile'),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
          ),
          Divider(
            height: 1,
            thickness: 1,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Label',
            ),
          ),
          ListTile(
            leading: Icon(Icons.bookmark),
            title: Text('Item A'),
          ),
        ],
      ),
    );
  }
}

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
                Navigator.pushNamed(context, GroupPageScreen.id);
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
