import 'dart:convert';
import 'dart:async';
import 'dart:math';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:elys_mobile/models/ModelProvider.dart';
import 'package:elys_mobile/amplifyconfiguration.dart';

import '../models/Content.dart';

class PanicPage extends StatefulWidget {
  PanicPage({Key? key}) : super(key: key);

  @override
  _PanicPageState createState() => _PanicPageState();
}

class _PanicPageState extends State<PanicPage> {
  bool _submitted = false;

  String _bucket = '';
  String _region = '';
  String videoPath = '';

  String heroText = 'Tap the Button to Leave a Recording';

  String time = '72:00:00';
  late SpecialEvent specialEvent;

  ImagePicker imagePicker = new ImagePicker();
  VideoPlayerController? videoPlayerController;

  TemporalDateTime goTime = TemporalDateTime.now();
  Timer timer = new Timer(Duration(days: 1), (() => null));

  @override
  void initState() {
    super.initState();
    _getS3Config();
    _getSpecialEvents();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void _getS3Config() {
    final s3config =
        jsonDecode(amplifyconfig)['storage']['plugins']['awsS3StoragePlugin'];
    _bucket = s3config['bucket'];
    _region = s3config['region'];
  }

  void _getSpecialEvents() async {
    List<SpecialEvent> events =
        await Amplify.DataStore.query(SpecialEvent.classType);
    if (events.length > 0) {
      setState(() {
        goTime = events[0].timeSubmitted;
      });
      _startCountDown();
    }
    return;
  }

  String _generateRandomString(int length) {
    var r = Random();
    const _chars = '-abcdefghijklmnopqrstuvwxyz1234567890';
    return List.generate(length, (index) => _chars[r.nextInt(_chars.length)])
        .join();
  }

  Future<void> _getVideo() async {
    final video = await imagePicker.pickVideo(
        source: ImageSource.camera, maxDuration: Duration(seconds: 10));

    if ((video != null) && (video.path != null)) {
      videoPath = video.path;
      final _videoPlayerController =
          VideoPlayerController.file(File(video.path));
      videoPlayerController = _videoPlayerController;
      videoPlayerController!.initialize();
      setState(() {});

      final key = video.path.split('/').last;
      try {
        await Amplify.Storage.uploadFile(local: File(video.path), key: key);
        final newContent = new Content(
            dateSubmitted: new DateTime.now().toString(),
            name: key,
            description: 'Hot Button Recording',
            region: _region,
            bucket: _bucket,
            key: key,
            type: key.split('.').last);
        await Amplify.DataStore.save(newContent);
        final newGroup = new Group(
            name: _generateRandomString(16),
            contacts: List<ContactGroup>.empty(growable: true));
        await Amplify.DataStore.save(newGroup);
        final newEvent = new Event(
            contentId: newContent.id,
            groupId: newGroup.id,
            name: 'Hot Button Event',
            description: '',
            eventDate: DateTime.now().day.toString(),
            eventMonth: DateTime.now().month.toString(),
            eventYear: DateTime.now().year.toString());
        await Amplify.DataStore.save(newEvent);
        await Amplify.DataStore.save(new SpecialEvent(
            eventId: newEvent.id,
            timeSubmitted: TemporalDateTime.now(),
            sent: false,
            warned: false,
            event: newEvent));
      } catch (e) {
        print(e);
      }
    }
    _startCountDown();
  }

  Future<void> _startCountDown() async {
    String timeString = goTime.toString();
    DateTime dateTime = DateTime.parse(timeString);
    DateTime futureTime = dateTime.add(Duration(hours: 72));
    time = futureTime.difference(DateTime.now()).toString().substring(0, 8);

    _updateTime();
    setState(() {
      _submitted = true;
      heroText = 'Tap the Button to Cancel the Recording';
    });
  }

  Future<void> _deleteVideo() async {
    List<SpecialEvent> specialEvents =
        await Amplify.DataStore.query(SpecialEvent.classType);
    List<Event> events = await Amplify.DataStore.query(Event.classType,
        where: Event.ID.eq(specialEvents[0].eventId));
    List<Group> groups = await Amplify.DataStore.query(Group.classType);
    List<Group> _group =
        groups.where((item) => item.id == events[0].groupId).toList();
    List<Content> contentItems =
        await Amplify.DataStore.query(Content.classType);
    List<Content> _contentItem =
        contentItems.where((item) => item.id == events[0].contentId).toList();

    await Amplify.Storage.remove(key: contentItems[0].key);
    await Amplify.DataStore.delete(specialEvents[0]);
    await Amplify.DataStore.delete(events[0]);
    await Amplify.DataStore.delete(_contentItem[0]);
    await Amplify.DataStore.delete(_group[0]);
  }

  void _cancelCountDown() {
    time = '72:00:00';

    _deleteVideo();

    timer.cancel();
    setState(() {
      _submitted = false;
      heroText = 'Tap the Button to Leave a Recording';
    });
  }

  void _updateTime() {
    timer = Timer.periodic(
        Duration(seconds: 1),
        (Timer t) => setState(() {
              String timeString = goTime.toString();
              DateTime dateTime = DateTime.parse(timeString);
              DateTime futureTime = dateTime.add(Duration(hours: 72));
              time = futureTime
                  .difference(DateTime.now())
                  .toString()
                  .substring(0, 8);
            }));
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
          'ELYS Mobile',
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
              leading: Icon(Icons.settings, color: Colors.blueAccent),
              title: Text(
                'Settings',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                    color: Colors.blue[900]),
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
          GestureDetector(
            // When the child is tapped, show a snackbar.
            onTap: () {
              setState(() {
                if (videoPlayerController!.value.isPlaying) {
                  videoPlayerController!.pause();
                } else {
                  // If the video is paused, play it.
                  videoPlayerController!.play();
                }
              });
            },
            // The custom button
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                height: 160,
                width: 160,
                child: !_submitted
                    ? Center(child: Text('No Video Recorded'))
                    : Center(child: Text('Video Available')),
                // : AspectRatio(
                //     aspectRatio: videoPlayerController!.value.aspectRatio,
                //     child: VideoPlayer(videoPlayerController!),
                //   ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
