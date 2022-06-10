import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';

import 'package:elys_mobile/models/Content.dart';
import 'package:elys_mobile/models/Event.dart';

class ContentPage extends StatefulWidget {
  ContentPage({Key? key}) : super(key: key);

  @override
  _ContentPageState createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  List<Content> entries = List<Content>.empty(growable: true);

  @override
  void initState() {
    super.initState();
  }

  @override
  void setState(fn) {
    if (this.mounted) {
      super.setState(fn);
    }
  }

  Future<void> _getContent() async {
    try {
      final result = await Amplify.DataStore.query(Content.classType,
          sortBy: [Content.DESCRIPTION.ascending()]);
      setState(() {
        entries = result;
      });
    } catch (e) {
      SnackBar snackBar = SnackBar(
        content: Text(e.toString()),
        duration: Duration(seconds: 3),
        action: SnackBarAction(label: 'OK', onPressed: () {}),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      setState(() {});
    }
  }

  void _observeContent() async {
    final contentStream = Amplify.DataStore.observe(Content.classType);
    contentStream.listen((_) => _getContent());
  }

  Future<List<Slidable>> _getContentList() async {
    _observeContent();
    final result = await Amplify.DataStore.query(Content.classType,
        sortBy: [Content.DESCRIPTION.ascending()]);
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
                    onDeleteContentPressed(item);
                  },
                ),
              ],
            ),
            endActionPane: ActionPane(
              motion: BehindMotion(),
              children: [
                SlidableAction(
                  flex: 1,
                  label: 'Related',
                  backgroundColor: Colors.blue.shade900,
                  foregroundColor: Colors.white,
                  icon: Icons.share_sharp,
                  onPressed: (BuildContext context) {
                    Navigator.pushNamed(context, '/relatedcontent', arguments: item);
                  },
                ),
                SlidableAction(
                  flex: 1,
                  label: 'Edit',
                  backgroundColor: Colors.lightBlue,
                  foregroundColor: Colors.white,
                  icon: Icons.edit_sharp,
                  onPressed: (BuildContext context) {
                    Navigator.pushNamed(context, '/editcontent', arguments: item);
                  },
                )
              ],
            ),
            child: ListTile(
              title: Text(
                item.description,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(item.name),
              isThreeLine: false,
            ),
          ),
        )
        .toList());
  }

  Widget _getContentItems() {
    return FutureBuilder(
      future: _getContentList(),
      builder: (BuildContext context, AsyncSnapshot<List<Slidable>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.length > 0) {
            return new ListView.separated(
                separatorBuilder: (context, item) => Divider(thickness: 1),
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, item) {
                  return snapshot.data![item];
                });
          } else {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: new Text('\nNo Media Items found',
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

  void onDeleteContentPressed(Content item) async {
    final contact = (await Amplify.DataStore.query(Content.classType,
        where: Content.ID.eq(item.id)))[0];
    final events = await Amplify.DataStore.query(Event.classType,
        where: Event.CONTENTID.eq(item.id));

    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("Warning"),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Deleting this Connection will '),
                Text('delete the Events attached '),
                Text('to this Connection')
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                _deleteAll(contact, events);
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

  Future<void> _deleteAll(Content item, List<Event> events) async {
    try {
      await Amplify.Storage.remove(key: item.key);
      await Amplify.DataStore.delete(item);
      events.forEach((event) async {
        await Amplify.DataStore.delete(event);
      });
      Navigator.pushNamed(context, '/main', arguments: 'content');
    } on StorageException catch (e) {
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
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'Upload any photo or video for future messages',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
          ),
          Divider(
            height: 20,
            thickness: 2,
            indent: 0,
            endIndent: 0,
            color: Colors.black,
          ),
          Expanded(child: _getContentItems())
        ],
      ),
    );
  }
}
