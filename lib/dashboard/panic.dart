import 'dart:async';

import 'package:flutter/material.dart';

import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:image_picker/image_picker.dart';

class PanicPage extends StatefulWidget {
  PanicPage({Key? key}) : super(key: key);

  @override
  _PanicPageState createState() => _PanicPageState();
}

class _PanicPageState extends State<PanicPage> {
  bool _submitted = false;
  String time = '72:00:00';
  String heroText = 'Tap the Button to Leave a Recording';

  DateTime goTime = new DateTime.now();
  Timer timer = new Timer(Duration(days: 1), (() => null));

  ImagePicker imagePicker = new ImagePicker();
  String videoPath = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  Future<void> _startCountDown() async {
    goTime = DateTime(2021, 10, 11, 0, 0, 0);
    time = goTime.difference(DateTime.now()).toString().substring(0, 8);

    XFile? video = await imagePicker.pickVideo(
        source: ImageSource.camera, maxDuration: Duration(seconds: 15));

    _updateTime();
    setState(() {
      _submitted = true;
      heroText = 'Tap the Button to Cancel the Recording';
    });
  }

  void _cancelCountDown() {
    goTime = DateTime(2021, 10, 11, 0, 0, 0);
    time = '72:00:00';

    timer.cancel();
    setState(() {
      _submitted = false;
      heroText = 'Tap the Button to Leave a Recording';
    });
  }

  void _updateTime() {
    timer = Timer.periodic(
        Duration(seconds: 1),
        (Timer t) => setState(() {
              time =
                  goTime.difference(DateTime.now()).toString().substring(0, 8);
            }));
  }

  void _getVideo() {}

  Future<void> _onLogout() async {
    try {
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
                  'Hello, user',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
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
            ),
            ListTile(
                leading: Icon(Icons.info_outline, color: Colors.blueAccent),
                title: Text(
                  'About',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      color: Colors.blue[900]),
                ),
                onTap: () {
                  showAboutDialog(
                      context: context,
                      applicationName: 'ELYS Legacy Management',
                      applicationVersion: '0.2.0');
                }),
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
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Visibility(
            visible: !_submitted,
            child: FloatingActionButton(
              onPressed: () {
                _startCountDown();
              },
              child: const Icon(Icons.volume_down_sharp),
              backgroundColor: Colors.lightBlue,
            ),
          ),
          Visibility(
            visible: _submitted,
            child: FloatingActionButton(
              onPressed: () {
                _cancelCountDown();
              },
              child: const Icon(Icons.close_sharp),
              backgroundColor: Colors.lightBlue,
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
              child: Text(heroText,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
          Center(
              child: Text('Time Now: ' + time, style: TextStyle(fontSize: 14))),
        ],
      ),
    );
  }
}
