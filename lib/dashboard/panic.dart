import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:elys_mobile/models/ModelProvider.dart';

class PanicPage extends StatefulWidget {
  PanicPage({Key? key}) : super(key: key);

  @override
  _PanicPageState createState() => _PanicPageState();
}

class _PanicPageState extends State<PanicPage> {
  bool _submitted = false;

  late XFile _video;

  String heroText = 'Tap the Button to Record';
  String time = '72:00:00';

  List<SpecialEvent> events = List<SpecialEvent>.empty(growable: true);

  ImagePicker imagePicker = new ImagePicker();

  TemporalDateTime goTime = TemporalDateTime.now();
  Timer timer = new Timer(Duration(days: 1), (() => null));

  @override
  void initState() {
    super.initState();
    _getSpecialEvents();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void _getSpecialEvents() async {
    events = await Amplify.DataStore.query(
        SpecialEvent.classType,
        sortBy: [SpecialEvent.TIMESUBMITTED.descending()]);
    if (events.length > 0) {
      goTime = events[0].timeSubmitted;
      _startCountDown();
    }
    return;
  }

  Future<void> _getVideo() async {
    final video = await imagePicker.pickVideo(
        source: ImageSource.camera, maxDuration: Duration(seconds: 10));

    if (video != null) {
      _startCountDown();
      goTime = TemporalDateTime.now();
      Navigator.pushNamed(context, '/pending', arguments: _video);
    }
  }
  Future<void> _deleteVideo() async {
    List<SpecialEvent> specialEvents = await Amplify.DataStore.query(
        SpecialEvent.classType,
        sortBy: [SpecialEvent.TIMESUBMITTED.descending()]);

    await Amplify.Storage.remove(key: specialEvents[0].key);
    await Amplify.DataStore.delete(specialEvents[0]);
  }

  Future<void> _startCountDown() async {
    String timeString = goTime.toString();
    DateTime dateTime = DateTime.parse(timeString);
    DateTime futureTime = dateTime.add(Duration(hours: 72));
    time = futureTime.difference(DateTime.now()).toString().substring(0, 8);

    _updateTime();
    setState(() {
      _submitted = true;
      heroText = 'Tap the Button to Cancel';
    });
  }

  void _cancelCountDown() {
    time = '72:00:00';

    _deleteVideo();

    timer.cancel();
    setState(() {
      _submitted = false;
      heroText = 'Tap the Button to Record';
    });
  }

  void _updateTime() {
    timer = Timer.periodic(
      Duration(seconds: 1),
      (Timer t) => setState(
        () {
          String timeString = goTime.toString();
          DateTime dateTime = DateTime.parse(timeString);
          DateTime futureTime = dateTime.add(Duration(hours: 72));
          time =
              futureTime.difference(DateTime.now()).toString().substring(0, 8);
        },
      ),
    );
  }

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
          'Elys Mobile',
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
                _getVideo();
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
            child: Text(
              heroText,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Center(
            child: Text(
              'Time Until Release: ' + time,
              style: TextStyle(fontSize: 14),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: !_submitted
                ? Center(child: Text('No Video Recorded'))
                : Center(child: Text('Video Available')),
          )
        ],
      ),
    );
  }
}
