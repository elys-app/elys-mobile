import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:amplify_flutter/amplify.dart';

import '../models/Contact.dart';

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
    _initContacts();
  }

  void _initContacts() async {
    entries.clear();
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

  List<Slidable> _getContactList() {
    return (entries
        .map(
          (item) => new Slidable(
              actionPane: SlidableDrawerActionPane(),
              child: ListTile(
                title: Text(
                  item.name,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(item.email),
              ),
              secondaryActions: <Widget>[
                IconSlideAction(
                    caption: 'Delete',
                    color: Colors.red,
                    icon: Icons.cancel,
                    onTap: () => {
                          setState(
                            () {
                              entries.remove(item);
                            },
                          )
                        }),
              ]),
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
