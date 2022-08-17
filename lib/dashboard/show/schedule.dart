import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:amplify_flutter/amplify_flutter.dart';

import 'package:google_fonts/google_fonts.dart';

import '../../models/Event.dart';
import '../../models/Contact.dart';
import '../../models/Content.dart';

class SchedulePage extends StatefulWidget {
  SchedulePage({Key? key}) : super(key: key);

  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  List<Event> entries = List<Event>.empty(growable: true);
  List<Contact> contacts = List<Contact>.empty(growable: true);
  List<Content> content = List<Content>.empty(growable: true);

  @override
  void initState() {
    super.initState();
    _getEvents();
    _observeEvents();

    _checkStatus();
  }

  void _checkStatus() async {
    await _getContacts();
    await _getContent();

    if (contacts.length == 0) {
      if (content.length == 0) {
        Navigator.pushNamed(context, '/startup', arguments: 'both');
      } else {
        Navigator.pushNamed(context, '/startup', arguments: 'contacts');
      }
    } else if (content.length == 0) {
      Navigator.pushNamed(context, '/startup', arguments: 'content');
    }
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

  Future<void> _getContacts() async {
    try {
      final result = await Amplify.DataStore.query(Contact.classType);
      setState(() {
        contacts = result;
      });
    } catch (e) {
      setState(() {});
    }
  }

  Future<void> _getContent() async {
    try {
      final result = await Amplify.DataStore.query(Content.classType);
      setState(() {
        content = result;
      });
    } catch (e) {
      setState(() {});
    }
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

  void onDeleteEventPressed(Event item) async {
    // set up are you sure dialog

    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text("Warning"),
              content: SingleChildScrollView(
                child: ListBody(
                  children: const <Widget>[Text('Are you sure?')],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Delete'),
                  onPressed: () async {
                    await Amplify.DataStore.delete(item);
                    Navigator.pushNamed(context, '/main',
                        arguments: 'schedule');
                  },
                ),
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    setState(() {
                      Navigator.pop(context);
                    });
                  },
                )
              ],
            ),
        barrierDismissible: false);
  }

  Future<List<Slidable>> _getEventList() async {
    final result = await Amplify.DataStore.query(Event.classType,
        sortBy: [Event.DESCRIPTION.ascending()]);

    return (result
        .map(
          (item) => Slidable(
            key: const ValueKey(0),
            startActionPane: ActionPane(
              motion: BehindMotion(),
              children: [
                SlidableAction(
                  label: 'Delete',
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  icon: Icons.delete_sharp,
                  onPressed: (BuildContext context) {
                    onDeleteEventPressed(item);
                  },
                ),
              ],
            ),
            endActionPane: ActionPane(
              motion: BehindMotion(),
              children: [
                SlidableAction(
                  flex: 1,
                  label: 'Edit',
                  backgroundColor: Colors.lightBlue,
                  foregroundColor: Colors.white,
                  icon: Icons.edit_sharp,
                  onPressed: (BuildContext context) {
                    Navigator.pushNamed(context, '/editschedule',
                        arguments: item);
                  },
                )
              ],
            ),
            child: new ListTile(
              title: Text(
                item.name,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              subtitle: (item.eventMonth == '0')
                  ? Text('Send Email to: ${item.contactEmail} \nImmediately')
                  : Text(
                      'Send Email to: ${item.contactEmail} \nOn: ${item.eventMonth} ${item.eventDate} '),
              isThreeLine: true,
              onLongPress: () {
                _editScheduleItem(item);
              },
            ),
          ),
        )
        .toList());
  }

  Widget _getEventItems() {
    return FutureBuilder(
      future: _getEventList(),
      builder: (BuildContext context, AsyncSnapshot<List<Slidable>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.length > 0) {
            return new ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (context, item) => Divider(thickness: 1),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, item) {
                  return snapshot.data![item];
                });
          } else {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: new Text('\nNo Schedule Items found',
                  style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14)),
            );
          }
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

  void _editScheduleItem(Event item) async {
    Navigator.pushNamed(context, '/editschedule', arguments: item);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'Schedule the Media Items you want to send',
              style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 18)),
            ),
          ),
          Divider(
            height: 20,
            thickness: 2,
            indent: 0,
            endIndent: 0,
            color: Colors.black,
          ),
          Expanded(child: _getEventItems())
        ],
      ),
    );
  }
}
