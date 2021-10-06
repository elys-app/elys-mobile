import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:amplify_flutter/amplify.dart';

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
  List<Group> entries = List<Group>.empty(growable: true);
  List<ContactGroup> contactGroup = List<ContactGroup>.empty(growable: true);
  List<Contact> everyContact = List<Contact>.empty(growable: true);
  List<ContactGroup> selectedContacts =
      List<ContactGroup>.empty(growable: true);
  Set<ContactGroup> selectedContactSet = Set<ContactGroup>.identity();

  @override
  void initState() {
    super.initState();
    _setup();

    Amplify.DataStore.observe(Contact.classType);
    Amplify.DataStore.observe(Group.classType);
    Amplify.DataStore.observe(ContactGroup.classType);
  }

  void _setup() async {
    try {
      await _initGroups();
      await _initContacts();
      await _getSelectedContacts(selectedGroup.id);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _initGroups() async {
    entries.clear();
    try {
      final result = await Amplify.DataStore.query(Group.classType);
      setState(() {
        entries = result;
        List<Group> s = result.where((group) => group.name == 'ALL').toList();
        selectedGroup = s[0];
        print("Selected Group: " + selectedGroup.toString());
        _errorOccurred = false;
      });
    } catch (e) {
      setState(() {
        _errorOccurred = true;
      });
    }
  }

  Future<void> _initContacts() async {
    everyContact.clear();
    try {
      final result = await Amplify.DataStore.query(Contact.classType);
      result.sort((a, b) => a.name.compareTo(b.name));
      setState(() {
        everyContact = result;
        _errorOccurred = false;
      });
    } catch (e) {
      setState(() {
        _errorOccurred = true;
      });
    }
  }

  Future<void> _getSelectedContacts(String groupId) async {
    selectedContacts.clear();
    try {
      final result = await Amplify.DataStore.query(ContactGroup.classType); //,

      setState(() {
        selectedContactSet = result.toSet();
        print('Selected Contact Set: ${selectedContactSet.toString()}');
        _errorOccurred = false;
      });
    } catch (e) {
      setState(() {
        print(e.toString());
        _errorOccurred = true;
      });
    }
  }

  Future<List<DropdownMenuItem<Group>>> _getGroupList() async {
    List<Group> result = await Amplify.DataStore.query(Group.classType);
    return (result
        .map((item) =>
            new DropdownMenuItem<Group>(value: item, child: Text(item.name)))
        .toList());
  }

  Widget _getGroupDropdownItems() {
    return new FutureBuilder(
        future: _getGroupList(),
        builder:
            (context, AsyncSnapshot<List<DropdownMenuItem<Group>>> snapshot) {
          if (snapshot.hasData) {
            return DropdownButtonFormField<Group>(
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                value: selectedGroup,
                icon: const Icon(Icons.arrow_downward),
                iconSize: 18,
                elevation: 36,
                isExpanded: true,
                decoration: InputDecoration(
                  filled: true,
                  labelText: 'Select Group',
                ),
                onChanged: (Group? newValue) {
                  if (newValue != null) {
                    selectedGroup = newValue;
                    _getSelectedContacts(selectedGroup.name);
                  }
                },
                items: snapshot.data);
          } else
            return Text('Loading');
        });
  }

  Future<List<ListTile>> _getContactList() async {
    await _initContacts();
    return (everyContact.map(
      (item) => new ListTile(
        title: Text(item.name,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
        trailing: true
            ? Icon(Icons.check_box_outline_blank_sharp)
            : Icon(Icons.check_box_sharp),
        onTap: () {
          print('Move in or Out of Group');
        },
      ),
    )).toList();
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(children: <Widget>[
        Padding(
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 20),
            child: _getGroupDropdownItems()),
        Padding(
            padding: EdgeInsets.only(left: 25, right: 25),
            child: _getContactItems())
      ]),
    );
  }
}
