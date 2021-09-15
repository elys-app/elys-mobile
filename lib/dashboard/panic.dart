import 'package:flutter/material.dart';

import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

import '../login/login.dart';

class PanicPage extends StatefulWidget {
  PanicPage({Key? key, required this.username}) : super(key: key);

  final String username;

  @override
  _PanicPageState createState() => _PanicPageState();
}

class _PanicPageState extends State<PanicPage> {
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
    String _time = '72:00:00';
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
              ),
            ),
            ListTile(
              leading: Icon(Icons.settings, color: Colors.blueAccent),
              title: Text(
                'Settings',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal, color: Colors.blue[900]),
              ),
            ),
            ListTile(
                leading: Icon(Icons.info_outline, color: Colors.blueAccent),
                title: Text(
                  'About',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal, color: Colors.blue[900]),
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
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal, color: Colors.blue[900]),
              ),
              onTap: _onLogout,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('pressed');
        },
        child: const Icon(Icons.volume_down_sharp),
        backgroundColor: Colors.lightBlue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(child: Text('Press the Button to Leave a Recording',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
          Center(child: Text('Time Remaining: ' + _time,
              style: TextStyle(fontSize: 14))),
        ],
      ),
    );
  }
}
