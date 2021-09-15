import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_api/amplify_api.dart';

import '../models/contactitem.dart';

class ContactsPage extends StatefulWidget {
  ContactsPage({Key? key}) : super(key: key);

  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  bool _errorOccurred = false;

  List<ContactItem> entries =
  List<ContactItem>.filled(0, new ContactItem(id: '0'), growable: true);

  @override
  void initState() {
    super.initState();
    _initContacts();
  }

  void _initContacts() async {
    entries.clear();
    try {
      String graphQLDocument = '''query ListContacts {
        listContacts {
          items {
            id
            name
            owner
            email
            relationship
            updatedAt
            createdAt
          }
        }
      }''';
      var operation = Amplify.API.query(
          request: GraphQLRequest<String>(
            document: graphQLDocument,
          ));
      var response = await operation.response;

      setState(() {
        Map<String, dynamic> data = jsonDecode(response.data)['listContacts'];
        for (var item in data['items']) {
          entries.add(ContactItem.fromJSON(item));
        }
        _errorOccurred = false;
      });
    } on ApiException {
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
    ).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        child: Column(children: _errorOccurred ? <Widget>[
          Text('An Error Occurred')] : _getContactList()));
  }
}
