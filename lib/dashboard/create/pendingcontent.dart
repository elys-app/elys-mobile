import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:amplify_flutter/amplify_flutter.dart';

import 'package:elys_mobile/models/ModelProvider.dart';

class PendingContentPage extends StatefulWidget {
  PendingContentPage({Key? key, required this.item, required this.content}) : super(key: key);

  final Content item;
  final File content;

  @override
  _PendingContentPageState createState() => _PendingContentPageState();
}

class _PendingContentPageState extends State<PendingContentPage> {
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
    try {
      await Amplify.Storage.uploadFile(local: File(widget.content.path), key: widget.item.key);
      await Amplify.DataStore.save(widget.item);
      Navigator.pushNamed(context, '/main', arguments: 'content');
    } catch (e) {
      print('Error uploading image: $e');
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
              'Uploading Media Item...',
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
