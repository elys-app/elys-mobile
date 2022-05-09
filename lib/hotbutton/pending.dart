import 'dart:async';
import 'dart:io';

import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';

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
    print(_key);

    final currentEvent = widget.event;
    try {
      await Amplify.Storage.uploadFile(local: File(widget.content.path), key: _key);
      SpecialEvent updatedEvent = currentEvent.copyWith(
          key: _key,
          timeSubmitted: TemporalDateTime.now());
      await Amplify.DataStore.save(updatedEvent);
      Navigator.pushNamed(context, '/panic');
    } catch (e) {
      print(e);
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
