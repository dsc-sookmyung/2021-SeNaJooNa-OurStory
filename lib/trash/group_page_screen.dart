import 'package:flutter/material.dart';
import 'file:///C:/Users/LEE/AndroidStudioProjects/together/lib/trash/calendar_screen.dart';
import 'file:///C:/Users/LEE/AndroidStudioProjects/together/lib/trash/chat_screen.dart';
import 'package:together/screens/diary_screen.dart';
import 'file:///C:/Users/LEE/AndroidStudioProjects/together/lib/trash/map_screen.dart';

class GroupPageScreen extends StatefulWidget {
  static const String id = 'group_page_screen';

  @override
  _GroupPageScreenState createState() => _GroupPageScreenState();
}

class _GroupPageScreenState extends State<GroupPageScreen> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    DiaryScreen(),
    CalendarScreen(),
    MapScreen(),
    ChatScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('모임명'),
        backgroundColor: Color(0xFF6200EE),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xFF6200EE),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(.60),
        selectedFontSize: 14,
        unselectedFontSize: 14,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Diary',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
