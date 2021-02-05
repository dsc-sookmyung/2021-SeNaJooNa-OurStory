import 'package:flutter/material.dart';
import 'package:together/Constants.dart';
import 'package:together/models/Group.dart';
import 'package:together/models/User.dart';
import 'package:provider/provider.dart';

class AddGroupScreen extends StatefulWidget {
  @override
  _AddGroupScreenState createState() => _AddGroupScreenState();
}

class _AddGroupScreenState extends State<AddGroupScreen> {
  String groupName;
  String user;
  List<String> userList = [];
  TextEditingController _nameController = TextEditingController();
  TextEditingController _userController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: kPrimaryColor,
        title: Text(
          '모임 만들기',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          FlatButton(
            onPressed: () {
              if (groupName == null) return;
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
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
        Padding(
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
                decoration: kTextFieldDecoration.copyWith(hintText: '모임 이름'),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                onChanged: (value) {
                  user = value;
                },
                controller: _userController,
                decoration: kTextFieldDecoration.copyWith(hintText: '모임원 추가'),
              ),
              FlatButton(
                onPressed: () {
                  if (user == null) {
                    return;
                  }
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
                  child: userListWidget(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget userListWidget() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return userChip(
            userTitle: userList[index],
            onDeleted: () {
              setState(() {
                userList.remove(userList[index]);
              });
            });
      },
      itemCount: userList.length,
    );
  }
}

class userChip extends StatelessWidget {
  String userTitle;
  Function onDeleted;
  userChip({userTitle, onDeleted}) {
    this.userTitle = userTitle;
    this.onDeleted = onDeleted;
  }
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        userTitle,
        style: TextStyle(color: Colors.white),
      ),
      avatar: CircleAvatar(
        child: Text(
          userTitle[0].toUpperCase(),
        ),
        backgroundColor: Colors.white,
      ),
      padding: EdgeInsets.all(5),
      backgroundColor: kPDarkColor,
      onDeleted: onDeleted,
    );
  }
}
