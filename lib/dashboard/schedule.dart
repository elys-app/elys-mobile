import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:amplify_flutter/amplify_flutter.dart';

import '../models/Event.dart';

class SchedulePage extends StatefulWidget {
  SchedulePage({Key? key}) : super(key: key);

  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
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

  void _observeEvents() async {
    final eventStream = Amplify.DataStore.observe(Event.classType);
    eventStream.listen((_) => _getEvents());
  }

  void _getEvents() async {
    entries.clear();
    try {
      final result = await Amplify.DataStore.query(Event.classType,
          sortBy: [Event.NAME.ascending()]);
      setState(() {
        entries = result;
      });
    } catch (e) {
      setState(() {});
    }
  }

  Future<List<ListTile>> _getEventList() async {
    final result = await Amplify.DataStore.query(Event.classType,
        sortBy: [Event.DESCRIPTION.ascending()]);

    return (result
        .map(
          (item) => new ListTile(
            title: Text(
              item.name,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
                'Send Email to: ${item.contactEmail} \nOn: ${item.eventMonth} ${item.eventDate} '),
            isThreeLine: true,
            onLongPress: () {
              _removeScheduleItem(item);
            },
          ),
        )
        .toList());
  }

  Widget _getEventItems() {
    return FutureBuilder(
      future: _getEventList(),
      builder: (BuildContext context, AsyncSnapshot<List<ListTile>> snapshot) {
        if (snapshot.hasData) {
          return new ListView.separated(
            shrinkWrap: true,
            separatorBuilder: (context, item) => Divider(thickness: 1),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, item) {
              return snapshot.data![item];
            },
          );
        } else {
          return Container(
            child: SpinKitThreeBounce(
              color: Colors.lightBlue,
              size: 50.0,
            ),
          );
        }
      },
    );
  }

  void _removeScheduleItem(Event item) async {
    await Amplify.DataStore.delete(item);
  }

  @override
  Widget build(BuildContext context) {
    return Container(padding: EdgeInsets.all(10), child: _getEventItems());
  }
}
