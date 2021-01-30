import 'package:flutter/material.dart';
import 'package:together/Constants.dart';
import 'package:together/screens/add_group_screen.dart';
import 'package:together/components/group_list.dart';

class GroupScreen extends StatefulWidget {
  static const String id = 'group_screen';
  @override
  _GroupScreenState createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() {
    _scaffoldKey.currentState.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPLightColor,
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
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
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.list,
            color: Colors.black,
          ),
          onPressed: _openDrawer,
        ),
        backgroundColor: kPrimaryColor,
        title: Text(
          '모임 목록',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: null,
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
          ),
        ],
      ),
      drawer: Navigation_Drawer(),
      body: Column(
        children: <Widget>[
          // SizedBox(
          //   height: 10.0,
          // ),
          Expanded(
            child: GroupList(),
          ),
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
