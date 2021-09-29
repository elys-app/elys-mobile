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
  List<Contact> contacts = List<Contact>.empty(growable: true);

  @override
  void initState() {
    super.initState();
    _initGroups();
  }

  void _initGroups() async {
    entries.clear();
    try {
      final result = await Amplify.DataStore.query(Group.classType);
      setState(() {
        entries = result;
        List<Group> s = result.where((group) => group.name == 'ALL').toList();
        selectedGroup = s[0];
        _errorOccurred = false;
      });
    } catch (e) {
      setState(() {
        _errorOccurred = true;
      });
    }
  }

  Future<List<DropdownMenuItem<Group>>> _getGroupDropdownItems() async {
    List<Group> result = await Amplify.DataStore.query(Group.classType);
    return (result
        .map((item) => new DropdownMenuItem<Group>(
            value: item, child: Text(item.name)))
        .toList());
  }

  Widget _getGroups() {
    return new FutureBuilder(
      future: _getGroupDropdownItems(),
      builder: (context, AsyncSnapshot<List<DropdownMenuItem<Group>>>snapshot) {
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
                }
                print('Selected Group is now: ' + selectedGroup.toString());
              },
              items: snapshot.data);
        }
        else return Text('Loading');
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(10), child: _getGroups());
  }
}
