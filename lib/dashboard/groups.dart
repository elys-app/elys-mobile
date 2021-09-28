import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_api/amplify_api.dart';

import '../models/Group.dart';
import '../models/Contact.dart';
import '../models/ContactGroup.dart';

class GroupsPage extends StatefulWidget {
  GroupsPage({Key? key}) : super(key: key);

  @override
  _GroupsPageState createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
  bool _errorOccurred = false;

  Group selectedGroup =
      new Group(name: '', contacts: List<ContactGroup>.empty(growable: true));
  List<Group> entries = List<Group>.filled(0,
      new Group(name: '', contacts: List<ContactGroup>.empty(growable: true)),
      growable: true);
  List<ContactGroup> contactGroup = List<ContactGroup>.filled(
      0,
      new ContactGroup(
          group: new Group(
              name: '', contacts: List<ContactGroup>.empty(growable: true)),
          contact: new Contact(name: '', email: '')),
      growable: true);
  List<Contact> contacts =
      List<Contact>.filled(0, new Contact(name: '', email: ''), growable: true);

  @override
  void initState() {
    super.initState();
    _initGroups();
    // _getContacts(selectedGroup.id);
  }

  void _initGroups() async {
    entries.clear();
    try {
      final result = await Amplify.DataStore.query(Group.classType);
      result.sort((a, b) => a.name.compareTo(b.name));
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

  void _getContacts(String id) async {
    entries.clear();
  }

  List<DropdownMenuItem<Group>> _getGroupDropdownItems() {
    return (entries
        .map((item) =>
            new DropdownMenuItem<Group>(value: item, child: Text(item.name)))
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
                  child: DropdownButton<Group>(
                    value: selectedGroup,
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 18,
                    elevation: 24,
                    isExpanded: true,
                    underline: Container(
                      height: 1,
                      color: Colors.white,
                    ),
                    onChanged: (Group? newValue) {
                      setState(() {
                        selectedGroup = newValue!;
                        _getContactList();
                      });
                    },
                    items: _getGroupDropdownItems(),
                  ),
                ),
                Divider(color: Colors.black, height: 2, thickness: 1),
              ],
      ),
    );
  }
}
