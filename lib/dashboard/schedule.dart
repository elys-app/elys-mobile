import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:amplify_flutter/amplify.dart';

import '../models/Event.dart';
import '../models/Group.dart';

class SchedulePage extends StatefulWidget {
  SchedulePage({Key? key}) : super(key: key);

  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  bool _errorOccurred = false;

  List<Event> entries = List<Event>.empty(growable: true);

  @override
  void initState() {
    super.initState();
    _getEvents();
    _observeEvents();
  }

  @override
  void setState(fn) {
    if (this.mounted) {
      super.setState(fn);
    }
  }

  void _getEvents() async {
    entries.clear();
    try {
      final result = await Amplify.DataStore.query(Event.classType,
          sortBy: [Event.EVENTMONTH.ascending()]);
      setState(() {
        entries = result;
        _errorOccurred = false;
      });
    } catch (e) {
      setState(() {
        _errorOccurred = true;
      });
    }
  }

  void _observeEvents() async {
    final eventStream = await Amplify.DataStore.observe(Event.classType);
    eventStream.listen((_) => _getEvents());
  }

  Future<String> _getGroupNameFromId(String id) async {
    List<Group> result = await Amplify.DataStore.query(Group.classType);
    List<Group> group = result.where((item) => item.id == id).toList();
    if (group != null) {
      return group[0].name;
    } else {
      return 'Error';
    }
  }

  Widget _getGroupName(String id, String date, String month) {
    return new FutureBuilder(
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          String subtitle =
              'Group to Send: ${snapshot.data.toString()} \nOn: ${date} ${month}';
          return Text(subtitle);
        } else {
          return Text('Loading');
        }
      },
      future: _getGroupNameFromId(id),
    );
  }

  List<Column> _getEventList() {
    return (entries
        .map(
          (item) => Column(
            children: <Widget>[
              new ListTile(
                title: Text(
                  item.name,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                subtitle: _getGroupName(
                    item.groupId, item.eventDate, item.eventMonth),
                isThreeLine: true,
                onLongPress: () {
                  print('Remove item');
                },
              ),
              Divider(thickness: 1)
            ],
          ),
        )
        .toList());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        child: Column(
            children: _errorOccurred
                ? <Widget>[Text('An Error Occurred')]
                : _getEventList()));
  }
}
