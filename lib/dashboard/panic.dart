import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

import 'package:elys_mobile/models/ModelProvider.dart';

import 'package:elys_mobile/models/PendingPage.dart';

class PanicPage extends StatefulWidget {
  PanicPage({Key? key}) : super(key: key);

  @override
  _PanicPageState createState() => _PanicPageState();
}

class _PanicPageState extends State<PanicPage> {
  bool _submitted = false;
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final numberController = TextEditingController();

  late XFile _video;

  String heroText = 'Tap the Button to Record';
  String time = '00:10:00';

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

  Widget _getUserName() {
    return new FutureBuilder(
      builder: (context, AsyncSnapshot<AuthUser> snapshot) {
        if (snapshot.hasData) {
          String welcome = 'Welcome, ${snapshot.data!.username}';
          return Text(
            welcome,
            style: GoogleFonts.bellefair(
              textStyle: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            ),
          );
        } else {
          return Text('Loading');
        }
      },
      future: Amplify.Auth.getCurrentUser(),
    );
  }

  void _getSpecialEvents() async {
    events = await Amplify.DataStore.query(SpecialEvent.classType,
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

    if (video?.length() != null) {
      _startCountDown();
      goTime = TemporalDateTime.now();
      PendingPageArguments infoToPass = PendingPageArguments(
          _video, nameController.text, numberController.text);
      Navigator.pushNamed(context, '/pending', arguments: infoToPass);
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
    DateTime futureTime = dateTime.add(Duration(minutes: 10));
    time = futureTime.difference(DateTime.now()).toString().substring(0, 8);

    _updateTime();
    setState(() {
      _submitted = true;
      heroText = 'Tap the Button to Cancel';
    });
  }

  void _cancelCountDown() {
    time = '00:10:00';

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
          DateTime futureTime = dateTime.add(Duration(minutes: 10));
          time =
              futureTime.difference(DateTime.now()).toString().substring(0, 8);
        },
      ),
    );
  }

  Future<void> _onLogout() async {
    try {
      Navigator.pop(context);
      await Amplify.DataStore.stop();
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
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'On this page, you can send an emergency message to a person you choose',
                    style:
                        GoogleFonts.poppins(textStyle: TextStyle(fontSize: 18)),
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: EdgeInsets.only(
                      left: 30.0, top: 10.0, right: 30.0, bottom: 10.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter a Name';
                      }
                      return null;
                    },
                    obscureText: false,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                      labelText: 'Emergency Contact Name',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: 30.0, top: 10.0, right: 30.0, bottom: 10.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter an Phone Number';
                      }
                      return null;
                    },
                    obscureText: false,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone_sharp),
                      border: OutlineInputBorder(),
                      labelText: 'Emergency Contact Phone Number',
                    ),
                  ),
                ),
                SizedBox(height: 75),
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
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.red),
                      onPressed: !_submitted
                          ? () {
                              _getVideo();
                            }
                          : () {
                              _cancelCountDown();
                            },
                      child: !_submitted
                          ? Text('Record', style: TextStyle(fontSize: 18))
                          : Text('Cancel', style: TextStyle(fontSize: 18))),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
