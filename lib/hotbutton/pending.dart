import 'dart:async';
import 'dart:io';

import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';

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
    _key = widget.content.path
        .split('/')
        .last;

    final currentEvent = widget.event;
    try {
      SpecialEvent updatedEvent = currentEvent.copyWith(
          fileKey: 'public/' + _key,
          timeSubmitted: DateTime.now().toUtc().toString(),
          sent: false,
          warned: false);
      File fileToUpload = File(this.widget.content.path);
      await Amplify.DataStore.save(updatedEvent);
      await Amplify.Storage.uploadFile(local: fileToUpload, key: _key);
      Navigator.pushNamed(context, '/panic');
    } catch (e) {
      SnackBar snackBar = SnackBar(
        content: Text(e.toString()),
        duration: Duration(seconds: 5),
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
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Uploading Hot Button Content...',
              style: TextStyle(fontSize: 18),
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
