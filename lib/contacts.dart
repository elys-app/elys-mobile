import 'package:flutter/material.dart';
import 'content.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ContactPage> createState() => _ContactPageState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _ContactPageState extends State<ContactPage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Content',
      style: optionStyle,
    ),
    Text(
      'Index 1: Contacts',
      style: optionStyle,
    ),
    Text(
      'Index 2: Schedule',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ContentPage(title: 'Your Content'),
            ),
          );
        }
      // case 3: {
      //           Navigator.push(
      //               context,
      //               MaterialPageRoute(
      //                   builder: (context) =>
      //                       SchedulePage(title: 'Register for ELYS')));

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.video_camera_back),
            label: 'Content',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.email_sharp),
            label: 'Contacts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Schedule',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.lightBlue,
        onTap: _onItemTapped,
      ),
    );
  }
}
