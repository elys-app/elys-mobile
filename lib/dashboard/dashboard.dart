import 'package:flutter/material.dart';

import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

import '../login/login.dart';

import 'content.dart';
import 'contacts.dart';
import 'schedule.dart';
import 'panic.dart';

import 'newcontent.dart';
import 'newcontact.dart';
import 'newschedule.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key, required this.username}) : super(key: key);

  final String username;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    ContentPage(),
    ContactsPage(),
    SchedulePage(),
    PanicPage()
  ];

  void initState() {
    super.initState();
  }

  Future<String> _onLogout() async {
    try {
      Amplify.Auth.signOut().then((_) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LoginPage(title: 'Welcome to ELYS')));
      });
      return 'success';
    } on AuthException catch (e) {
      SnackBar snackBar = SnackBar(
        content: Text('${e.message}'),
        duration: Duration(seconds: 3),
        action: SnackBarAction(label: 'OK', onPressed: () {}),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return 'failed';
    }
  }

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
          padding: EdgeInsets.all(5),
          children: <Widget>[
            Container(
                height: 120,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Text(
                    'Hello, ${widget.username}',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                )),
            ListTile(
              leading: Icon(Icons.settings, color: Colors.blueAccent),
              title: Text(
                'Settings',
                style: TextStyle(fontSize: 18, color: Colors.blue[900]),
              ),
            ),
            ListTile(
                leading: Icon(Icons.info_outline, color: Colors.blueAccent),
                title: Text(
                  'About',
                  style: TextStyle(fontSize: 18, color: Colors.blue[900]),
                ),
                onTap: () {
                  showAboutDialog(
                      context: context,
                      applicationName: 'ELYS Legacy Management',
                      applicationVersion: '0.1.0');
                }),
            ListTile(
              leading: Icon(Icons.logout_sharp, color: Colors.blueAccent),
              title: Text(
                'Logout',
                style: TextStyle(fontSize: 18, color: Colors.blue[900]),
              ),
              onTap: _onLogout,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 32,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue[900],
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.video_camera_front_rounded),
              label: 'Content',
              backgroundColor: Colors.lightBlue),
          BottomNavigationBarItem(
              icon: Icon(Icons.email_sharp),
              label: 'Contacts',
              backgroundColor: Colors.lightBlue),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today_sharp),
              label: 'Schedule',
              backgroundColor: Colors.lightBlue),
          BottomNavigationBarItem(
              icon: Icon(Icons.warning),
              label: 'Panic',
              backgroundColor: Colors.lightBlue)
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
            case 2:
              {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            NewSchedulePage(title: 'New Schedule Item')));
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
