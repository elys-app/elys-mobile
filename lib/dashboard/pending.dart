import 'dart:convert';
import 'dart:async';
import 'dart:math';
import 'dart:io';

import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:elys_mobile/models/ModelProvider.dart';
import 'package:elys_mobile/amplifyconfiguration.dart';

import '../models/Content.dart';

class PendingPage extends StatefulWidget {
  PendingPage({Key? key, required this.content}) : super(key: key);

  final content;

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
    final user = await Amplify.Auth.getCurrentUser();
    final account = await Amplify.DataStore.query(Account.classType,
        where: Account.USERNAME.eq(user.username));

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
          executorEmail: account[0].executor!.email,
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
              child: CircularProgressIndicator(),
              width: 100,
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
