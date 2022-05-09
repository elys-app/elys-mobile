import 'dart:async';
import 'dart:convert';

import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

import 'package:elys_mobile/models/ModelProvider.dart';
import 'package:elys_mobile/amplifyconfiguration.dart';

class PanicPage extends StatefulWidget {
  PanicPage({Key? key}) : super(key: key);

  @override
  _PanicPageState createState() => _PanicPageState();
}

class _PanicPageState extends State<PanicPage> {
  bool _submitted = false;
  final formKey = GlobalKey<FormState>();

  String _bucket = '';
  String _region = '';

  String fullTime = '00:30:00';
  String time = '';

  int timeToSend = 30;

  final nameController = TextEditingController();
  final numberController = TextEditingController();

  List<SpecialEvent> events = List<SpecialEvent>.empty(growable: true);

  ImagePicker imagePicker = new ImagePicker();

  TemporalDateTime goTime = TemporalDateTime.now();
  Timer timer = new Timer(Duration(days: 1), (() => null));

  @override
  void initState() {
    super.initState();
    _getSpecialEvents();
    _getS3Config();
  }

  void _getS3Config() {
    final s3config =
        jsonDecode(amplifyconfig)['storage']['plugins']['awsS3StoragePlugin'];
    _bucket = s3config['bucket'];
    _region = s3config['region'];
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
      if (events[0].key != '') {
        goTime = events[0].timeSubmitted;
        _startCountDown();
      }
      setState(() {
        numberController.text = events[0].emergencyNumber!;
        nameController.text = events[0].emergencyName!;
      });
    }
    return;
  }

  Future<void> _getVideo() async {
    if (events.length < 1) {
      SpecialEvent newEvent = new SpecialEvent(
          region: _region,
          bucket: _bucket,
          key: '',
          executorEmail: '',
          emergencyName: nameController.text,
          emergencyNumber: numberController.text,
          timeSubmitted: TemporalDateTime.now(),
          sent: false,
          warned: false);
      await Amplify.DataStore.save(newEvent);
      Navigator.pushNamed(context, '/camera', arguments: newEvent);
    }
    else {
      SpecialEvent existingEvent = events[0];
      SpecialEvent updatedEvent = existingEvent.copyWith(
        emergencyName: nameController.text,
        emergencyNumber: numberController.text
      );
      await Amplify.DataStore.save(updatedEvent);
      Navigator.pushNamed(context, '/camera', arguments: updatedEvent);
    }
  }

  Future<void> _deleteVideo() async {
    await Amplify.Storage.remove(key: events[0].key);
    SpecialEvent existingEvent = events[0];
    SpecialEvent updatedEvent = existingEvent.copyWith(
      key: ''
    );
    await Amplify.DataStore.save(updatedEvent);
  }

  Future<void> _startCountDown() async {
    String timeString = goTime.toString();
    DateTime dateTime = DateTime.parse(timeString);
    DateTime futureTime = dateTime.add(Duration(minutes: timeToSend));
    time = futureTime.difference(DateTime.now()).toString().substring(0, 7);

    _updateTime();
    setState(() {
      _submitted = true;
    });
  }

  void _cancelCountDown() {
    time = fullTime;

    _deleteVideo();

    timer.cancel();
    setState(() {
      _submitted = false;
    });
  }

  void _updateTime() {
    timer = Timer.periodic(
      Duration(seconds: 1),
      (Timer t) => setState(
        () {
          String timeString = goTime.toString();
          DateTime dateTime = DateTime.parse(timeString);
          DateTime futureTime = dateTime.add(Duration(minutes: timeToSend));
          time =
              futureTime.difference(DateTime.now()).toString().substring(0, 7);
        },
      ),
    );
  }

  Future<void> _onLogout() async {
    try {
      Navigator.pop(context);
      await Amplify.DataStore.clear();
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
                  padding: EdgeInsets.only(
                      left: 30.0, top: 10.0, right: 30.0, bottom: 10.0),
                  child: Text(
                    'Add your Hot Button contact',
                    style:
                        GoogleFonts.poppins(textStyle: TextStyle(fontSize: 18)),
                  ),
                ),
                SizedBox(height: 100), // sub for icon
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 30.0, top: 10.0, right: 30.0, bottom: 20.0),
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
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: 30.0, top: 20.0, right: 30.0, bottom: 10.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter a Name';
                      }
                      return null;
                    },
                    controller: nameController,
                    obscureText: false,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                      labelText: 'Hot Button Contact Name',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: 30.0, top: 10.0, right: 30.0, bottom: 30.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Hot Button Contact Phone Number';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    controller: numberController,
                    obscureText: false,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone_sharp),
                      border: OutlineInputBorder(),
                      labelText: 'Enter Hot Button Contact Phone Number',
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    'Time Until Release: ' + time,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: !_submitted
                      ? Center(
                          child: Text('No Video Recorded',
                              style: TextStyle(fontSize: 14)))
                      : Center(
                          child: Text('Video Available',
                              style: TextStyle(fontSize: 14))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
