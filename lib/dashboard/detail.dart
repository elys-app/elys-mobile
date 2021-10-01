import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify.dart';

import '../models/Contact.dart';

class DetailsPage extends StatefulWidget {
  DetailsPage({Key? key}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  bool _errorOccurred = false;

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
        _errorOccurred = false;
      });
    } catch (e) {
      setState(() {
        _errorOccurred = true;
      });
    }
  }

  void _observeContacts() async {
    final contactStream = await Amplify.DataStore.observe(Contact.classType);
    contactStream.listen((_) => _getContacts());
  }

  List<Column> _getContactList() {
    return (entries
        .map((item) => new Column(children: <Widget>[
              new ListTile(
                title: Text(item.name,
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                subtitle: Text(item.email),
                //     style:
                //         TextStyle(fontSize: 14, fontWeight: FontWeight.normal)),
                // isThreeLine: false,
                onLongPress: () {
                  print('Remove Item');
                },
              ),
              Divider(
                thickness: 1,
              )
            ]))
        .toList());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
          children: _errorOccurred
              ? <Widget>[Text('An Error Occurred')]
              : _getContactList()),
    );
  }
}
