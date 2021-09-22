import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_api/amplify_api.dart';

import '../models/groupitem.dart';
import '../models/contactitem.dart';
import '../models/contactgroupitem.dart';

class GroupsPage extends StatefulWidget {
  GroupsPage({Key? key}) : super(key: key);

  @override
  _GroupsPageState createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
  bool _errorOccurred = false;

  GroupItem selectedGroup = new GroupItem(id: '0');
  List<GroupItem> entries =
      List<GroupItem>.filled(0, new GroupItem(id: '0'), growable: true);
  List<ContactGroupItem> contactGroup = List<ContactGroupItem>.filled(
      0, new ContactGroupItem('', ContactItem(id: '0')),
      growable: true);
  List<ContactItem> contacts =
      List<ContactItem>.filled(0, new ContactItem(id: '0'), growable: true);

  @override
  void initState() {
    super.initState();
    _initGroups();
    _getContacts(selectedGroup.id);
  }

  void _initGroups() async {
    entries.clear();
    try {
      String graphQLDocument = '''query ListGroups {
        listGroups {
          items {
            id
            name
            owner
          }
        }
      }''';
      var operation = Amplify.API.query(
          request: GraphQLRequest<String>(
        document: graphQLDocument,
      ));
      var response = await operation.response;

      setState(() {
        Map<String, dynamic> data = jsonDecode(response.data)['listGroups'];
        for (var item in data['items']) {
          entries.add(GroupItem.fromJSON(item));
        }
        _errorOccurred = false;
        selectedGroup = entries.elementAt(0);
      });
    } on ApiException {
      setState(() {
        _errorOccurred = true;
      });
    }
  }

  void _getContacts(String id) async {
    entries.clear();
    try {
      String graphQLDocument = '''query ContactsByGroup(\$groupId: ID!) {
        contactsByGroup(input: {groupId: \$groupId}) {
          items {
            contactId
            contact {
              id
              name
              email
            }
          }
        }
      }''';

      var operation = Amplify.API.query(
          request: GraphQLRequest<String>(
              document: graphQLDocument,
              variables: {'groupId': '46390741-6e01-4d93-af42-bb51b0586d6f'}));
      var response = await operation.response;

      setState(() {
        Map<String, dynamic> data =
            jsonDecode(response.data)['contactsByGroup'];
        print(response.data);
        for (var item in data['items']) {
          var contactGroupItem = new ContactGroupItem.fromJSON(item);
          contacts.add(contactGroupItem.contactItem);
        }
        _errorOccurred = false;
      });
    } catch(e){
      print(e);
      setState(() {
        _errorOccurred = true;
      });
    }
  }

  List<DropdownMenuItem<GroupItem>> _getGroupDropdownItems() {
    return (entries
        .map((item) => new DropdownMenuItem<GroupItem>(
            value: item, child: Text(item.name)))
        .toList());
  }

  List<Slidable> _getContactList() {
    return (contacts
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
            : <Widget>[
                Padding(
                  padding:
                      EdgeInsets.only(left: 18, top: 1, right: 18, bottom: 1),
                  child: DropdownButton<GroupItem>(
                    value: selectedGroup,
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 18,
                    elevation: 24,
                    isExpanded: true,
                    underline: Container(
                      height: 1,
                      color: Colors.white,
                    ),
                    onChanged: (GroupItem? newValue) {
                      setState(() {
                        selectedGroup = newValue!;
                        _getContactList();
                      });
                    },
                    items: _getGroupDropdownItems(),
                  ),
                ),
                Divider(color: Colors.black, height: 2, thickness: 1),
                Column(children: _getContactList()),
              ],
      ),
    );
  }
}
