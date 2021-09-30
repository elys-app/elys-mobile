import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify.dart';

import '../models/Group.dart';
import '../models/Contact.dart';
import '../models/ContactGroup.dart';

class DetailsPage extends StatefulWidget {
  DetailsPage({Key? key}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  bool _errorOccurred = false;

  List<Contact> entries =
      List<Contact>.filled(0, new Contact(name: '', email: ''), growable: true);

  @override
  void initState() {
    super.initState();
    _getContacts();
    _observeContacts();
  }

  void _getContacts() async {
    try {
      final result = await Amplify.DataStore.query(Contact.classType);
      result.sort((a, b) => a.name.compareTo(b.name));
      setState(() {
        entries = result;
        _errorOccurred = false;
      });
    } catch(e) {
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
        .map(
          (item) => new Column(
            children: <Widget>[
              new ListTile(
                  title: Text(item.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
                  subtitle: Text(item.email, style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal)),
                  isThreeLine: false,
                  onLongPress: () {
                    print('remove');
                  },
              ),
              Divider(thickness: 1,)
            ]
          )
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
              : _getContactList()),
    );
  }
}
