import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:together/Constants.dart';
import 'package:together/models/sign_in.dart';
import 'package:together/screens/add_group_screen.dart';
import 'package:together/screens/change_group_screen.dart';
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
      ),
      drawer:
          Navigation_Drawer(userEmail: Provider.of<User>(context).getEmail()),
      body: Column(
        children: <Widget>[
          Expanded(
            child: projectWidget(),
          ),
          SizedBox(
            width: 16.0,
          )
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
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
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
                    if (value == 0) {
                      leaveGroupDialog(group['id'], email);
                    } else if (value == 1) {
                      removeGroupDialog(group["id"]);
                    } else {
                      print(group);
                      Provider.of<Group>(context, listen: false)
                          .setGroup(group);

                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (context) => ChangeGroupScreen(),
                          fullscreenDialog: true,
                        ),
                      );
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

  Future<Widget> removeGroupDialog(dynamic groupId) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("모임 삭제"),
            content: Text("정말 삭제하시겠습니까?"),
            actions: [
              FlatButton(
                child: Text("OK"),
                onPressed: () {
                  Provider.of<Group>(context, listen: false)
                      .removeGroup(id: groupId);
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  Future<Widget> leaveGroupDialog(dynamic groupId, dynamic email) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("모임 탈퇴"),
            content: Text("정말 탈퇴하시겠습니까?"),
            actions: [
              FlatButton(
                child: Text("OK"),
                onPressed: () {
                  Provider.of<Group>(context, listen: false).leaveGroup(
                    groupID: groupId,
                    email: email,
                  );
                },
              ),
              FlatButton(
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }
}

class Navigation_Drawer extends StatelessWidget {
  String userEmail;

  Navigation_Drawer({@required userEmail}) {
    this.userEmail = userEmail;
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
              userEmail,
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
      padding: EdgeInsets.only(
        top: 8.0,
        left: 8.0,
        right: 8.0,
        bottom: 8.0,
      ),
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
                    child: Text('모임 설정'),
                    value: 2,
                  ),
                ],
              ),
              onTap: () {
                Provider.of<Group>(context, listen: false)
                    .setGroup({"id": this.id}); // delete
                Navigator.pushNamed(context, DiaryScreen.id,
                    arguments: ArgumentRoom(this.id, this.name));
              },
              title: Text(this.name),
              subtitle: this.users,
            ),
          ],
        ),
      ),
    );
  }
}
