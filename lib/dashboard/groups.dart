import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:amplify_flutter/amplify.dart';

import '../models/Collection.dart';
import '../models/Contact.dart';
import '../models/ContactGroup.dart';

class GroupsPage extends StatefulWidget {
  GroupsPage({Key? key}) : super(key: key);

  @override
  _GroupsPageState createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
  Collection selectedGroup = new Collection(
      name: '', contacts: List<ContactGroup>.empty(growable: true));
  List<Collection> entries = List<Collection>.empty(growable: true);
  List<ContactGroup> contactGroup = List<ContactGroup>.empty(growable: true);
  List<Contact> everyContact = List<Contact>.empty(growable: true);
  List<ContactGroup> selectedContacts =
      List<ContactGroup>.empty(growable: true);
  Set<Contact> selectedContactSet = {};

  @override
  void initState() {
    super.initState();
    _setup();
  }

  @override
  void setState(fn) {
    if (this.mounted) {
      super.setState(fn);
    }
  }

  void _setup() async {
    try {
      _observeContacts();
      _observeGroups();
      _observeContactGroups();

      await _initGroups();
      await _initContacts();
      await _getSelectedContacts(selectedGroup.id);
    } catch (e) {
      print(e.toString());
    }
  }

  void _observeGroups() async {
    final eventStream = await Amplify.DataStore.observe(Collection.classType);
    eventStream.listen((_) => _getGroupDropdownItems());
  }

  void _observeContacts() async {
    final eventStream = await Amplify.DataStore.observe(Contact.classType);
    eventStream.listen((_) => _getSelectedContacts(selectedGroup.id));
  }

  void _observeContactGroups() async {
    final eventStream = await Amplify.DataStore.observe(ContactGroup.classType);
    eventStream.listen((_) => _getSelectedContacts(selectedGroup.id));
  }

  Future<void> _initGroups() async {
    entries.clear();
    try {
      final result = await Amplify.DataStore.query(Collection.classType);
      setState(() {
        entries = result;
        List<Collection> s =
            result.where((group) => group.name == 'ALL').toList();
        selectedGroup = s[0];
        print("Selected Group: " + selectedGroup.toString());
      });
    } catch (e) {
      setState(() {});
    }
  }

  Future<void> _initContacts() async {
    everyContact.clear();
    try {
      final result = await Amplify.DataStore.query(Contact.classType);
      result.sort((a, b) => a.name.compareTo(b.name));
      setState(() {
        everyContact = result;
      });
    } catch (e) {
      setState(() {});
    }
  }

  Future<void> _getSelectedContacts(String groupId) async {
    selectedContactSet.clear();
    try {
      final result = await Amplify.DataStore.query(ContactGroup.classType);
      final filteredResult =
          result.where((item) => item.group.id == selectedGroup.id);

      setState(() {
        filteredResult.forEach((item) => selectedContactSet.add(item.contact));
        print('Selected Contact Set: ${selectedContactSet.toString()}');
      });
    } catch (e) {
      setState(() {
        print(e.toString());
      });
    }
  }

  Future<List<DropdownMenuItem<Collection>>> _getGroupList() async {
    List<Collection> result =
        await Amplify.DataStore.query(Collection.classType);
    return (result
        .map((item) => new DropdownMenuItem<Collection>(
            value: item, child: Text(item.name)))
        .toList());
  }

  Widget _getGroupDropdownItems() {
    return new FutureBuilder(
        future: _getGroupList(),
        builder: (context,
            AsyncSnapshot<List<DropdownMenuItem<Collection>>> snapshot) {
          if (snapshot.hasData) {
            return DropdownButtonFormField<Collection>(
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
                onChanged: (Collection? newValue) {
                  if (newValue != null) {
                    selectedGroup = newValue;
                    _getSelectedContacts(selectedGroup.id);
                  }
                },
                items: snapshot.data);
          } else
            return Text('Loading');
        });
  }

  void _changeContactMembership(Contact selectedContact) async {
    if (selectedGroup.name != 'ALL') {
      if (selectedContactSet.contains(selectedContact)) {
        final List<ContactGroup> result =
            await Amplify.DataStore.query(ContactGroup.classType);
        final filteredResult = result
            .where((item) =>
                (item.group.id == selectedGroup.id) &&
                (item.contact.id == selectedContact.id))
            .toList();

        print(filteredResult[0].toString());
        await Amplify.DataStore.delete(filteredResult[0]);
        _getSelectedContacts(selectedGroup.id);
      } else {
        await Amplify.DataStore.save(
            new ContactGroup(group: selectedGroup, contact: selectedContact));
        _getSelectedContacts(selectedGroup.id);
      }
    }
  }

  Future<List<ListTile>> _getContactList() async {
    await _initContacts();
    return (everyContact.map(
      (item) => new ListTile(
        title: Text(item.name,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
        trailing: selectedContactSet.contains(item)
            ? Icon(Icons.check_box_sharp, color: Colors.orange)
            : Icon(Icons.check_box_outline_blank_sharp),
        onTap: () {
          _changeContactMembership(item);
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
            padding: EdgeInsets.only(left: 40, right: 40),
            child: _getContactItems())
      ]),
    );
  }
}
