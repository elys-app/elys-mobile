import 'dart:async';
import 'dart:convert';

import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

import 'package:elys_mobile/models/ModelProvider.dart';
import 'package:elys_mobile/models/SpecialEvent.dart';
import 'package:elys_mobile/amplifyconfiguration.dart';

class PanicPage extends StatefulWidget {
  PanicPage({Key? key}) : super(key: key);

  @override
  _PanicPageState createState() => _PanicPageState();
}

class _PanicPageState extends State<PanicPage> {
  final initFuture = FlutterLibphonenumber().init();
  final countryController = TextEditingController(text: 'United States');
  final nameController = TextEditingController();
  final numberController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  String _bucket = '';
  String _region = '';

  String fullTime = '00:10:00';
  String endTime = '00:00:00';
  String time = '';

  int timeToSend = 10;
  int phoneNumberIndex = 3;
  int emailIndex = 4;

  List<SpecialEvent> events = List<SpecialEvent>.empty(growable: true);

  DateTime goTime = DateTime.now();
  Timer timer = new Timer(Duration(days: 1), (() => null));

  var placeholderHint = '';

  bool _submitted = false;
  bool _sent = false;

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
      if (events[0].sent ?? false) {
        setState(() {
          time = endTime;
          _sent = true;
        });
      } else if (events[0].fileKey != '') {
        goTime = DateTime.parse(events[0].timeSubmitted!);
        _startCountDown();
      } else {
        time = fullTime;
      }
      setState(() {
        numberController.text = events[0].emergencyNumber!;
        nameController.text = events[0].emergencyName!;
      });
    }
    return;
  }

  Future<void> _getVideo() async {
    final user = await Amplify.Auth.fetchUserAttributes();
    if (events.length < 1) {
      SpecialEvent newEvent = new SpecialEvent(
          region: _region,
          bucket: _bucket,
          fileKey: '',
          ownPhone: user[phoneNumberIndex].value,
          ownEmail: user[emailIndex].value,
          emergencyName: nameController.text,
          emergencyNumber: numberController.text,
          timeSubmitted: DateTime.now().toUtc().toIso8601String(),
          sent: false,
          warned: false);
      await Amplify.DataStore.save(newEvent);
      Navigator.pushNamed(context, '/camera', arguments: newEvent);
    } else {
      SpecialEvent existingEvent = events[0];
      SpecialEvent updatedEvent = existingEvent.copyWith(
          emergencyName: nameController.text,
          emergencyNumber: numberController.text);
      await Amplify.DataStore.save(updatedEvent);
      Navigator.pushNamed(context, '/camera', arguments: updatedEvent);
    }
  }

  Future<void> _deleteVideo() async {
    await Amplify.Storage.remove(key: events[0].fileKey!);
    SpecialEvent existingEvent = events[0];
    SpecialEvent updatedEvent = existingEvent.copyWith(fileKey: '');
    await Amplify.DataStore.save(updatedEvent);
  }

  Future<void> _startCountDown() async {
    String timeString = goTime.toString();
    DateTime dateTime = DateTime.parse(timeString);
    DateTime futureTime = dateTime.add(Duration(minutes: timeToSend));

    if (futureTime.difference(DateTime.now()).inSeconds < 0) {
      time = endTime;
      _sent = true;
    } else {
      time = futureTime
          .difference(DateTime.now())
          .toString()
          .substring(0, 7)
          .padLeft(8, '0');
      _updateTime();
    }

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
      _sent = false;
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
          if (futureTime.difference(DateTime.now()) > Duration(seconds: 1)) {
            setState(() {
              time = futureTime
                  .difference(DateTime.now())
                  .toString()
                  .substring(0, 7)
                  .padLeft(8, '0');
            });
          } else {
            setState(() {
              _sent = true;
              time = endTime;
            });
            timer.cancel();
          }
        },
      ),
    );
  }

  void updatePlaceholderHint() {
    late String newPlaceholder;

    newPlaceholder = CountryWithPhoneCode.us().exampleNumberMobileInternational;
    setState(() => placeholderHint = newPlaceholder);
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
                new Image.asset('images/the-hot-button.png',
                    width: 120, height: 120),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 30.0, top: 10.0, right: 30.0, bottom: 20.0),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.lightBlue),
                      onPressed: !_submitted
                          ? () {
                              _getVideo();
                            }
                          : () {
                              _cancelCountDown();
                            },
                      child: (!_submitted || _sent)
                          ? Text('Record', style: TextStyle(fontSize: 18))
                          : Text('Cancel', style: TextStyle(fontSize: 18))),
                ),
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
                      left: 30.0, top: 10.0, right: 30.0, bottom: 20.0),
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
                    inputFormatters: [
                      LibPhonenumberTextFormatter(
                        phoneNumberType: PhoneNumberType.mobile,
                        phoneNumberFormat: PhoneNumberFormat.international,
                        country: CountryWithPhoneCode.us(),
                        inputContainsCountryCode: true,
                        additionalDigits: 3,
                        shouldKeepCursorAtEndOfInput: true,
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Text(
                    'Time To Release',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                Center(
                  child: Text(
                    time,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(1),
                  child: _sent
                      ? Center(
                          child: Text('Video Sent',
                              style: TextStyle(fontSize: 14)))
                      : Center(
                          child: _submitted
                              ? Text('Video Recorded',
                                  style: TextStyle(fontSize: 14))
                              : Text('No Video Recorded',
                                  style: TextStyle(fontSize: 14)),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
