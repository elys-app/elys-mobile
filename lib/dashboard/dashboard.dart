import 'dart:async';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

import 'content.dart';
import 'detail.dart';
import 'schedule.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key, required this.page}) : super(key: key);

  final String page;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late StreamSubscription hubSubscription;

  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    DetailsPage(),
    ContentPage(),
    SchedulePage()
  ];

  @override
  void initState() {
    if (widget.page == 'contact') {
      setState(() {
        _selectedIndex = 0;
      });
    } else if (widget.page == 'content') {
      setState(() {
        _selectedIndex = 1;
      });
    } else {
      setState(() {
        _selectedIndex = 2;
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    hubSubscription.cancel();
  }

  Widget _getUserName() {
    return new FutureBuilder(
      builder: (context, AsyncSnapshot<AuthUser> snapshot) {
        if (snapshot.hasData) {
          String welcome = 'Welcome, ${snapshot.data!.username}';
          return Text(welcome,
              style: GoogleFonts.bellefair(
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w500)));
        } else {
          return Text('Loading');
        }
      },
      future: Amplify.Auth.getCurrentUser(),
    );
  }

  Future<void> _onLogout() async {
    try {
      Navigator.pop(context);
      await Amplify.DataStore.clear();
      Amplify.Auth.signOut().then((_) {
        Navigator.pushNamed(context, '/');
      });
    } on AuthException catch (e) {
      SnackBar snackBar = SnackBar(
        content: Text('${e.message}'),
        duration: Duration(seconds: 3),
        action: SnackBarAction(label: 'OK', onPressed: () {}),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Elys Mobile',
          style: GoogleFonts.bellefair(
              textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w500)),
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
                child: _getUserName(),
              ),
            ),
            ListTile(
              leading: Icon(Icons.settings, color: Colors.blueAccent),
              title: Text(
                'Settings',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                    color: Colors.blue[900]),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/settings');
              }
            ),
            ListTile(
              leading: Icon(Icons.logout_sharp, color: Colors.blueAccent),
              title: Text(
                'Logout',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                    color: Colors.blue[900]),
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
        selectedItemColor: Colors.blue[800],
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.email_sharp),
              label: 'Connections',
              backgroundColor: Colors.lightBlue),
          BottomNavigationBarItem(
              icon: Icon(Icons.video_camera_front_rounded),
              label: 'Media',
              backgroundColor: Colors.lightBlue),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today_sharp),
              label: 'Schedule',
              backgroundColor: Colors.lightBlue),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/panic');
                },
                heroTag: null,
                child: const Icon(Icons.local_fire_department_sharp),
                backgroundColor: Colors.pink),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: FloatingActionButton(
              onPressed: () {
                switch (_selectedIndex) {
                  case 0:
                    {
                      Navigator.pushNamed(context, '/newcontact');
                      break;
                    }
                  case 1:
                    {
                      Navigator.pushNamed(context, '/newcontent');
                      break;
                    }
                  case 2:
                    {
                      Navigator.pushNamed(context, '/newschedule');
                      break;
                    }
                }
              },
              child: const Icon(Icons.add),
              backgroundColor: Colors.lightBlue,
            ),
          ),
        ],
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}
