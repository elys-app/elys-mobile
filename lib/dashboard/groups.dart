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
  List<ContactGroup> selectedContacts = List<ContactGroup>.empty(growable: true);

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
    }
    catch (e) {
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
    print("Selected Group: " + selectedGroup.toString());
    try {
      final result = await Amplify.DataStore.query(ContactGroup.classType); //,
        // where: ContactGroup.GROUP.eq(selectedGroup.id));
      setState(() {
        selectedContacts = result;
        print("Number of Contacts: " + selectedContacts.length.toString());
        print("Selected Contacts: " + selectedContacts.toString());
        _errorOccurred = false;
      });
    } catch (e) {
      setState(() {
        print(e.toString());
        _errorOccurred = true;
      });
    }
  }

  Future<List<DropdownMenuItem<Group>>> _getGroups() async {
    List<Group> result = await Amplify.DataStore.query(Group.classType);
    return (result
        .map((item) =>
            new DropdownMenuItem<Group>(value: item, child: Text(item.name)))
        .toList());
  }

  Widget _getGroupDropdownItems() {
    return new FutureBuilder(
        future: _getGroups(),
        builder:
            (context, AsyncSnapshot<List<DropdownMenuItem<Group>>> snapshot) {
          if (snapshot.hasData) {
            return DropdownButton<Group>(
                style: TextStyle(color: Colors.black, fontSize: 18),
                value: selectedGroup,
                icon: const Icon(Icons.arrow_downward),
                iconSize: 18,
                elevation: 36,
                isExpanded: true,
                underline: Container(
                  height: 2,
                  color: Colors.grey,
                ),
                onChanged: (Group? newValue) {
                  if (newValue != null) {
                    selectedGroup = newValue;
                    print("Selected Group: " + selectedGroup.toString());
                  }
                  print('Selected Group is now: ' + selectedGroup.toString());
                },
                items: snapshot.data);
          } else
            return Text('Loading');
        });
  }

  List<ListTile> _getContactList() {
    return (everyContact.map(
      (item) => new ListTile(
        title: Text(item.name,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal)),
        trailing: Icon(Icons.check_box_outline_blank_sharp),
        onTap: () {
          print('Move in or Out of Group');
        },
      ),
    )).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(children: <Widget>[
        Padding(padding: EdgeInsets.only(left: 15, right: 15), child: _getGroupDropdownItems()),
        Column(children: _getContactList())
      ]),
    );
  }
}
