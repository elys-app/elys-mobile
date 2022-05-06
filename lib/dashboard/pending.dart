import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:flutter/material.dart';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:elys_mobile/models/ModelProvider.dart';
import 'package:elys_mobile/amplifyconfiguration.dart';

class PendingPage extends StatefulWidget {
  PendingPage({Key? key, required this.content, required this.name, required this.number}) : super(key: key);

  final content;
  final name;
  final number;

  @override
  _PendingPageState createState() => _PendingPageState();
}

class _PendingPageState extends State<PendingPage> {
  String _bucket = '';
  String _region = '';
  String _key = '';

  @override
  initState() {
    super.initState();
    _getS3Config();
    _saveContent();
  }

  @override
  dispose() {
    super.dispose();
  }

  void _getS3Config() {
    final s3config =
        jsonDecode(amplifyconfig)['storage']['plugins']['awsS3StoragePlugin'];
    _bucket = s3config['bucket'];
    _region = s3config['region'];
  }

  Future<void> _saveContent() async {
    _key = widget.content.path
        .split('/')
        .last;
    print(_key);

    try {
      await Amplify.Storage.uploadFile(local: File(widget.content.path), key: _key);
      await Amplify.DataStore.save(new SpecialEvent(
          region: _region,
          bucket: _bucket,
          key: _key,
          executorEmail: '',
          emergencyName: '',
          emergencyNumber: '',
          timeSubmitted: TemporalDateTime.now(),
          sent: false,
          warned: false));
      Navigator.pop(context);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Uploading Hot Button Content',
          style: TextStyle(color: Colors.white),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
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
