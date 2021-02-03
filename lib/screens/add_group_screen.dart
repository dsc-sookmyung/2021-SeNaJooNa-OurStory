import 'package:flutter/material.dart';
import 'package:together/Constants.dart';
import 'package:together/models/Group.dart';
import 'package:together/models/User.dart';
import 'package:provider/provider.dart';

class AddGroupScreen extends StatefulWidget {
  @override
  _AddGroupScreenState createState() => _AddGroupScreenState();
}

List<String> userList = [];

class _AddGroupScreenState extends State<AddGroupScreen> {
  String groupName;
  String user;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _userController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text('모임 만들기'),
        actions: [
          FlatButton(
            textColor: Colors.white,
            onPressed: () {
              //ff
              Provider.of<Group>(context, listen: false).addGroup(
                  name: groupName,
                  users: userList,
                  email: Provider.of<User>(context, listen: false).getEmail());

              // .addGroup(name: groupName, users: null);

              _nameController.clear();

              Navigator.pop(context);
            },
            child: Text("SAVE"),
            shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
          ),
        ],
      ),
      body: Padding(
        padding:
            EdgeInsets.only(top: 60.0, left: 20.0, right: 20.0, bottom: 20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextField(
                controller: _nameController,
                onChanged: (value) {
                  groupName = value;
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
              SizedBox(
                height: 48.0,
              ),
              TextField(
                onChanged: (value) {
                  user = value;
                },
                controller: _userController,
                decoration: InputDecoration(
                  hintText: '모임원 추가',
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
              FlatButton(
                onPressed: () {
                  if (!userList.contains(user) &&
                      user !=
                          Provider.of<User>(context, listen: false)
                              .getEmail()) {
                    setState(() {
                      userList.insert(0, user);
                    });
                  }

                  _userController.clear();
                },
                child: Text('ADD'),
              ),
              Expanded(
                child: SizedBox(
                  height: 200.0,
                  child: DeleteChips(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DeleteChips extends StatefulWidget {
  @override
  UsersList createState() => UsersList();
}

class UsersList extends State<DeleteChips> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return buildChip(
          index: index,
          userTitle: userList[index],
        );
      },
      itemCount: userList.length,
    );
  }

  Widget buildChip({int index, String userTitle}) {
    return Chip(
        label: Text(
          userTitle,
          style: TextStyle(color: Colors.black),
        ),
        avatar: CircleAvatar(
          child: Text(
            userTitle[0].toUpperCase(),
          ),
          backgroundColor: Colors.white,
        ),
        padding: EdgeInsets.all(5),
        backgroundColor: Colors.deepPurpleAccent[100],
        onDeleted: () {
          setState(() {
            userList.remove(userTitle);
          });
        });
  }
}
