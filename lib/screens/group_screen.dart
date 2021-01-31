import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:together/Constants.dart';
import 'package:together/screens/add_group_screen.dart';
import 'package:together/screens/diary_screen.dart';

import 'package:provider/provider.dart';
import '../models/User.dart';
import '../models/Group.dart';

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
    // String email = Provider.of<User>(context).getEmail();
    // Future<List<Map<String, dynamic>>> groups = Provider.of<Group>(context).getGroupsList(email);
    // groups.then((value) => {
    //   value.forEach((element) {
    //     print(element);
    //   })
    // });
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
              builder: (context) => AddGroupScreen(),
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
              // child: ListView(
              //   children: <Widget>[
              //     GroupCard(),
              //     GroupCard(),
              //     GroupCard(),
              //   ],
              // ),
              child: projectWidget()),
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

  Widget projectWidget() {
    String email = Provider.of<User>(context).getEmail();
    print(email);
    return FutureBuilder(
      builder: (context, groupSnap) {
        if (groupSnap.connectionState == ConnectionState.none &&
                groupSnap.hasData == null ||
            groupSnap.hasData == false) {
          //print('project snapshot data is: ${projectSnap.data}');
          return Container();
        }
        return ListView.builder(
          itemCount: groupSnap.data.length,
          itemBuilder: (context, index) {
            Map<String, dynamic> group = groupSnap.data[index];
            return Column(
              children: <Widget>[
                GroupCard(group["id"], group["name"], group["users"])
              ],
            );
          },
        );
      },
      future: Provider.of<Group>(context).getGroupsList(email),
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
  String id;
  String name;
  FutureBuilder users;

  GroupCard(id, name, users) {
    this.id = id;
    this.name = name;
    this.users = FutureBuilder(
        builder: (context, userSnap) {
          if (userSnap.connectionState == ConnectionState.none &&
              userSnap.hasData == null) {
            //print('project snapshot data is: ${projectSnap.data}');
            return Text("");
          } else if (userSnap.hasData) {
            return Text(userSnap.data.join(','));
          } else {
            return Text("");
          }
        },
        future: users);
  }
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
              title: Text(this.name),
              subtitle: this.users,
            ),
          ],
        ),
      ),
    );
  }
}