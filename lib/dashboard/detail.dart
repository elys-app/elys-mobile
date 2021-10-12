import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify.dart';

import '../models/Contact.dart';

class DetailsPage extends StatefulWidget {
  DetailsPage({Key? key}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  List<Contact> entries = List<Contact>.empty(growable: true);

  @override
  void initState() {
    super.initState();
    _getContacts();
    _observeContacts();
  }

  @override
  void setState(fn) {
    if (this.mounted) {
      super.setState(fn);
    }
  }

  void _getContacts() async {
    try {
      final result = await Amplify.DataStore.query(Contact.classType,
          sortBy: [Contact.NAME.ascending()]);
      setState(() {
        entries = result;
      });
    } catch (e) {
      setState(() {});
    }
  }

  void _observeContacts() async {
    final contactStream = await Amplify.DataStore.observe(Contact.classType);
    contactStream.listen((_) => _getContacts());
  }

  Future<List<ListTile>> _getContactList() async {
    final result = await Amplify.DataStore.query(Contact.classType,
        sortBy: [Contact.NAME.ascending()]);

    return (result
        .map((item) => ListTile(
              title: Text(item.name,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              subtitle: Text(item.email),
              isThreeLine: false,
              onLongPress: () {
                _removeContactItem(item);
              },
            ))
        .toList());
  }

  Widget _getContactItems() {
    return FutureBuilder(
      future: _getContactList(),
      builder: (BuildContext context, AsyncSnapshot<List<ListTile>> snapshot) {
        if (snapshot.hasData) {
          return new ListView.separated(
              separatorBuilder: (context, item) => Divider(thickness: 1),
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, item) {
                return snapshot.data![item];
              });
        } else {
          return Text('Loading');
        }
      },
    );
  }

  void _removeContactItem(Contact item) async {
    final contact = (await Amplify.DataStore.query(Contact.classType,
        where: Contact.ID.eq(item.id)))[0];
    SnackBar snackBar = SnackBar(
        content: Text('Delete is Currently Unavailable'),
        duration: Duration(seconds: 3),
        action: SnackBarAction(label: 'OK', onPressed: () {}));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    // To Do: waiting for fix to delete with hasOne
    //
    // await Amplify.DataStore.delete(contact);
  }

  @override
  Widget build(BuildContext context) {
    return Container(padding: EdgeInsets.all(10), child: _getContactItems());
  }
}
