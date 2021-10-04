import 'package:flutter/material.dart';

import 'package:amplify_flutter/amplify.dart';

import '../../models/Group.dart';
import '../../models/Event.dart';
import '../../models/Content.dart';
import '../../models/ContactGroup.dart';

class NewSchedulePage extends StatefulWidget {
  NewSchedulePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _NewSchedulePageState createState() => _NewSchedulePageState();
}

class _NewSchedulePageState extends State<NewSchedulePage> {
  final formKey = GlobalKey<FormState>();
  final descriptionController = TextEditingController();
  final eventDateController = TextEditingController();

  String selectedMonth = '';
  List<Group> groups = new List<Group>.empty(growable: true);
  List<Content> contentItems = new List<Content>.empty(growable: true);
  Group selectedGroup =
      new Group(name: '', contacts: List<ContactGroup>.empty(growable: true));
  Content selectedContent = new Content(
      name: '',
      description: '',
      dateSubmitted: '',
      region: '',
      key: '',
      bucket: '',
      type: '');

  @override
  void dispose() {
    super.dispose();
    _setup();
  }

  Future<void> _setup() async {
    try {
      await _initGroups();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _initGroups() async {
    try {
      final result = await Amplify.DataStore.query(Group.classType);
      setState(() {
        groups = result;
        List<Group> s = result.where((group) => group.name == 'ALL').toList();
        selectedGroup = s[0];
        print("Selected Group: " + selectedGroup.toString());
      });
    } catch (e) {
      setState(() {
        print(e);
      });
    }
  }

  List<DropdownMenuItem<String>> _getMonths() {
    List<String> monthList = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return (monthList
        .map((item) => new DropdownMenuItem<String>(
            value: item,
            child: Text(item,
                style: TextStyle(fontSize: 18, color: Colors.black))))
        .toList());
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
            return DropdownButtonFormField<Group>(
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                // value: selectedGroup,
                icon: const Icon(Icons.arrow_downward),
                iconSize: 18,
                elevation: 36,
                isExpanded: true,
                decoration: InputDecoration(
                  filled: true,
                  labelText: 'Group to Share With',
                ),
                onChanged: (Group? newValue) {
                  if (newValue != null) {
                    selectedGroup = newValue;
                  }
                  print('Selected Group is now: ' + selectedGroup.toString());
                },
                items: snapshot.data);
          } else
            return Text('Loading');
        });
  }

  Future<List<DropdownMenuItem<Content>>> _getContent() async {
    List<Content> result = await Amplify.DataStore.query(Content.classType);
    return (result
        .map((item) => new DropdownMenuItem<Content>(
            value: item, child: Text(item.description)))
        .toList());
  }

  Widget _getContentDropdownItems() {
    return new FutureBuilder(
        future: _getContent(),
        builder:
            (context, AsyncSnapshot<List<DropdownMenuItem<Content>>> snapshot) {
          if (snapshot.hasData) {
            return DropdownButtonFormField<Content>(
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                icon: const Icon(Icons.arrow_downward),
                iconSize: 18,
                elevation: 36,
                isExpanded: true,
                decoration: InputDecoration(
                  filled: true,
                  labelText: 'Content to Share',
                ),
                onChanged: (Content? newValue) {
                  if (newValue != null) {
                    selectedContent = newValue;
                  }
                  print(
                      'Selected Content is now: ' + selectedContent.toString());
                },
                items: snapshot.data);
          } else
            return Text('Loading');
        });
  }

  Future<void> _onAddEventPressed() async {
    if (formKey.currentState!.validate()) {
      print(descriptionController.text);
      print(selectedMonth);
      print(eventDateController.text);
      print(selectedGroup.toString());
      print(selectedContent.toString());
      await Amplify.DataStore.save(new Event(
          name: descriptionController.text,
          contentId: selectedGroup.id,
          groupId: selectedGroup.id,
          eventMonth: selectedMonth,
          eventDate: eventDateController.text,
          eventYear: '0'));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.white),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Form(
        key: formKey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                    left: 30.0, top: 10.0, right: 30.0, bottom: 10.0),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter a Description';
                    }
                    return null;
                  },
                  controller: descriptionController,
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: 'Description',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 30.0, top: 10.0, right: 30.0, bottom: 10.0),
                child: DropdownButtonFormField<String>(
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 18,
                  elevation: 36,
                  isExpanded: true,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    filled: true,
                    labelText: 'Event Month',
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedMonth = newValue!;
                    });
                  },
                  items: _getMonths(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 30.0, top: 10.0, right: 30.0, bottom: 10.0),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter a Date';
                    }
                    return null;
                  },
                  controller: eventDateController,
                  decoration: InputDecoration(labelText: 'Event Date'),
                  keyboardType: TextInputType.number,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 30, top: 0, right: 30.0, bottom: 8.0),
                child: _getContentDropdownItems(),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 30, top: 0, right: 30.0, bottom: 8.0),
                child: _getGroupDropdownItems(),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                style: style,
                onPressed: () {
                  _onAddEventPressed();
                },
                child: const Text('Add New Event'),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Icon(Icons.arrow_back_ios_sharp),
        backgroundColor: Colors.lightBlue,
      ),
    );
  }
}
