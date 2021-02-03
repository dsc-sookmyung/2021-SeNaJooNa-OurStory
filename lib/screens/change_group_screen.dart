import 'package:flutter/material.dart';
import 'package:together/Constants.dart';
import 'package:together/models/Group.dart';
import 'package:together/models/User.dart';
import 'package:provider/provider.dart';

class ChangeGroupScreen extends StatefulWidget {
  @override
  _ChangeGroupScreenState createState() => _ChangeGroupScreenState();
}

class _ChangeGroupScreenState extends State<ChangeGroupScreen> {
  String groupName;
  String user;
  List<dynamic> userList = [];
  TextEditingController _nameController = TextEditingController();
  TextEditingController _userController = TextEditingController();
  bool fromList = true;

  @override
  Widget build(BuildContext context) {
    if(fromList)
      // setState(() => userList = Provider.of<Group>(context, listen: false).getEmails()); 
      Provider.of<Group>(context, listen: false).getEmails().then((value) => setState(() {userList = value;}));

    this.userList.remove(Provider.of<User>(context).getEmail());
    groupName = Provider.of<Group>(context, listen: false).getGroupInfo()["name"];
    print("Change group");

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: kPrimaryColor,
        title: Text(
          '모임 설정 변경',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        leading: IconButton(icon: new Icon(Icons.clear) , onPressed: (){
          fromList = true;
          Navigator.pop(context);
        }),
        actions: [
          FlatButton(
            onPressed: () {
              if (groupName == null) return;
              //ff
              Provider.of<Group>(context, listen: false).addUser(users: userList, email:Provider.of<User>(context,listen: false).getEmail());
              Provider.of<Group>(context, listen: false).renameGroup(name: groupName);
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
                decoration: kTextFieldDecoration.copyWith(hintText: '모임 이름', labelText: '$groupName'),
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
    fromList = false;
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
