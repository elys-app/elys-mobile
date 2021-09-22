import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_api/amplify_api.dart';

import '../models/contactitem.dart';

class DetailsPage extends StatefulWidget {
  DetailsPage({Key? key}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
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
        listContacts(limit:10) {
          items {
            id
            name
            owner
            email
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
        print(response.data);
        for (var item in data['items']) {
          entries.add(ContactItem.fromJSON(item));
        }
        entries.sort((a,b) => a.name.compareTo(b.name));
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
