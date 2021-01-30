import 'package:flutter/material.dart';
import 'package:together/components/group_card.dart';

class GroupList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        GroupCard(),
        GroupCard(),
        GroupCard(),
      ],
    );
  }
}
