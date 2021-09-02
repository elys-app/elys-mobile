import 'package:elys_mobile/dashboard/newcontent.dart';
import 'package:flutter/material.dart';
import '../login/login.dart';

import 'content.dart';
import 'contacts.dart';
import 'schedule.dart';
import 'newcontent.dart';
import 'newcontact.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    ContentPage(),
    ContactsPage(),
    SchedulePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ELYS Mobile',
          style: TextStyle(color: Colors.white),
        ),
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
                height: 120,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Text(
                    'User Name',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                )),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text(
                'Settings',
                style: TextStyle(fontSize: 18, color: Colors.lightBlue),
              ),
            ),
            ListTile(
              leading: Icon(Icons.question_answer),
              title: Text(
                'About',
                style: TextStyle(fontSize: 18, color: Colors.lightBlue),
              ),
            ),
            ListTile(
              leading: Icon(Icons.warning_sharp),
              title: Text(
                'Panic',
                style: TextStyle(fontSize: 18, color: Colors.lightBlue),
              ),
              onTap: () {
                final snackBar = SnackBar(
                  content: const Text('To Do: Add Panic Page'),
                  action: SnackBarAction(label: 'OK', onPressed: () {}),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text(
                'Logout',
                style: TextStyle(fontSize: 18, color: Colors.lightBlue),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            LoginPage(title: 'Welcome To ELYS')));
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 40,
        currentIndex: _selectedIndex,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: [
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
          )
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          switch (_selectedIndex) {
            case 0:
              {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            NewContentPage(title: 'New Content')));
                break;
              }
            case 1:
              {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            NewContactPage(title: 'New Contact')));
                break;
              }
            default:
              {
                final snackBar = SnackBar(
                  content: const Text('To Do: Add Pages'),
                  action: SnackBarAction(label: 'OK', onPressed: () {}),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
          }
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.lightBlue,
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}
