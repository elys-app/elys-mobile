import 'package:flutter/material.dart';
import 'content.dart';
import 'contacts.dart';
import 'schedule.dart';

class ElysNavigationBar extends StatefulWidget {
  const ElysNavigationBar({Key? key}) : super(key: key);

  @override
  State<ElysNavigationBar> createState() => _ElysNavigationState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _ElysNavigationState extends State<ElysNavigationBar> {
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
          break;
        }
      case 1:
        {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ContactPage(title: 'Your Contacts'),
            ),
          );
          break;
        }
      case 2:
        {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SchedulePage(title: 'Your Schedule'),
            ),
          );
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
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
        selectedItemColor: Colors.lightBlue,
        onTap: _onItemTapped,
      ),
    ));
  }
}
