import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:sentry/sentry.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:amplify_flutter/amplify_flutter.dart';

import 'package:elys_mobile/models/ModelProvider.dart';

class PendingPage extends StatefulWidget {
  PendingPage({Key? key, required this.event, required this.content}) : super(key: key);

  final event;
  final content;

  @override
  _PendingPageState createState() => _PendingPageState();
}

class _PendingPageState extends State<PendingPage> {
  String _key = '';
  late String currentDefaultSystemLocale;
  late List<Locale> currentSystemLocales;

  @override
  initState() {
    super.initState();
    _saveContent();
  }

  @override
  dispose() {
    super.dispose();
  }

  Future<void> _saveContent() async {
    print('Current time zone: ${DateTime.now().timeZoneName} (offset ${DateTime.now().timeZoneOffset}).');
    _key = widget.content.path
        .split('/')
        .last;
    final currentEvent = widget.event;
    try {
      SpecialEvent updatedEvent = currentEvent.copyWith(
          fileKey: 'public/' + _key,
          timeSubmitted: DateTime.now().toUtc().toString(),
          timeZone: DateTime.now().toString(),
          sent: false,
          warned: false);
      File fileToUpload = File(this.widget.content.path);
      await Amplify.DataStore.save(updatedEvent);
      await Amplify.Storage.uploadFile(local: fileToUpload, key: _key);
      Navigator.pushNamed(context, '/panic');
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      SnackBar snackBar = SnackBar(
        content: Text("An error occured uploading your Hot Button Content"),
        duration: Duration(seconds: 5),
        action: SnackBarAction(label: 'OK', onPressed: () {}),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.pushNamed(context, '/panic');
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
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Uploading Hot Button Content...',
              style: TextStyle(fontSize: 18, color: Colors.blue),
            ),
            SizedBox(
              child: SpinKitThreeBounce(
                color: Colors.lightBlue,
                size: 50.0,
              ),
              width: 100,
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
