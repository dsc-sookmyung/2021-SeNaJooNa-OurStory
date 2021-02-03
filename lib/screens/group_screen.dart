import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:together/Constants.dart';
import 'package:together/models/sign_in.dart';
import 'package:together/screens/add_group_screen.dart';
import 'package:together/screens/diary_screen.dart';

import 'package:provider/provider.dart';
import 'package:together/screens/welcome_screen.dart';
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
      drawer: Navigation_Drawer(userName: Provider.of<User>(context).getName()),
      body: Column(
        children: <Widget>[
          Expanded(
            child: projectWidget(),
          ),
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
                GroupCard(
                  group["id"],
                  group["name"],
                  group["users"],
                  (value) {
                    if (value == 1) {
                      Provider.of<Group>(context, listen: false)
                          .removeGroup(id: group["id"]);
                    } else if (value == 0) {
                      Provider.of<Group>(context, listen: false).leaveGroup(
                        groupID: group["id"],
                        email: email,
                      );
                    } else {
                      changeName(group);
                    }
                  },
                )
              ],
            );
          },
        );
      },
      future: Provider.of<Group>(context).getGroupsList(email),
    );
  }
  Future<Widget> changeName(group){
    TextEditingController _nameController = TextEditingController();
    String newGroupName;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("모임명 변경"),
          content: TextField(
          controller: _nameController,
          onChanged: (value) {
            newGroupName = value;
          },
          decoration: InputDecoration(
            hintText: '모임 이름',
            contentPadding: EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 20.0,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 1.0),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.deepPurpleAccent[100], width: 2.0),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
          ),
        ),
          actions: <Widget>[ 
            new FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Provider.of<Group>(context, listen: false).renameGroup(
                  id: group["id"],
                  name: newGroupName
                );
                _nameController.clear();
                Navigator.pop(context);
              },
            ),
            new FlatButton(
              child: new Text("Cancel"),
              onPressed: () {
                _nameController.clear();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}

class Navigation_Drawer extends StatelessWidget {
  String userName;

  Navigation_Drawer({@required userName}) {
    this.userName = userName;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              userName,
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
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              signOutGoogle();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => WelcomeScreen()),
                  (route) => false);
            },
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
  Function removeCard;
  FutureBuilder users;

  GroupCard(id, name, users, removeCard) {
    this.id = id;
    this.name = name;
    this.removeCard = removeCard;
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
              trailing: PopupMenuButton(
                onSelected: removeCard,
                icon: Icon(Icons.more_vert),
                itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                  const PopupMenuItem(
                    child: Text('탈퇴하기'),
                    value: 0,
                  ),
                  const PopupMenuItem(
                    child: Text('삭제하기'),
                    value: 1,
                  ),
                  const PopupMenuItem(
                    child: Text('모임명 변경'),
                    value: 2,
                  ),
                ],
              ),
              onTap: () {
                Navigator.pushNamed(context, DiaryScreen.id,
                    arguments: RoomClass(this.id, this.name));
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
