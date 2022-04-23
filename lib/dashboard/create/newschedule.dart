import 'package:flutter/material.dart';

import 'package:amplify_flutter/amplify_flutter.dart';

import '../../models/Event.dart';
import '../../models/Content.dart';
import '../../models/Contact.dart';

class NewSchedulePage extends StatefulWidget {
  NewSchedulePage({Key? key}) : super(key: key);

  @override
  _NewSchedulePageState createState() => _NewSchedulePageState();
}

class _NewSchedulePageState extends State<NewSchedulePage> {
  final formKey = GlobalKey<FormState>();
  final descriptionController = TextEditingController();
  final eventDateController = TextEditingController();

  String selectedMonth = '';
  String selectedDay = '';
  List<Contact> contacts = new List<Contact>.empty(growable: true);
  List<Content> contentItems = new List<Content>.empty(growable: true);
  Contact selectedContact = new Contact(name: '', email: '');
  Content selectedContent = new Content(
      name: '', description: '', region: '', key: '', bucket: '', type: '');

  List<String> daysOfTheMonth = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '30',
    '31'
  ];

  @override
  void dispose() {
    super.dispose();
    _setup();
  }

  Future<void> _setup() async {
    try {
      await _initContacts();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _initContacts() async {
    try {
      final result = await Amplify.DataStore.query(Contact.classType);
      setState(() {
        contacts = result;
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

  List<DropdownMenuItem<String>> _getDays(String month) {
    var dayList = daysOfTheMonth.sublist(0, daysInMonth(month));
    return (dayList
        .map((item) => new DropdownMenuItem<String>(
            value: item,
            child: Text(item,
                style: TextStyle(fontSize: 18, color: Colors.black))))
        .toList());
  }

  int daysInMonth(String? date) {
    if ((selectedMonth == 'April') ||
        (selectedMonth == 'June') ||
        (selectedMonth == 'September') ||
        (selectedMonth == 'November')) {
      return 30;
    } else if (selectedMonth == 'February') {
      return 28;
    } else {
      return 31;
    }
  }

  Future<List<DropdownMenuItem<Contact>>> _getContacts() async {
    final result = await Amplify.DataStore.query(Contact.classType,
        sortBy: [Contact.NAME.ascending()]);
    return (result
        .map((item) =>
            new DropdownMenuItem<Contact>(value: item, child: Text(item.name)))
        .toList());
  }

  Widget _getContactDropdownItems() {
    return new FutureBuilder(
        future: _getContacts(),
        builder:
            (context, AsyncSnapshot<List<DropdownMenuItem<Contact>>> snapshot) {
          if (snapshot.hasData) {
            return DropdownButtonFormField<Contact>(
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
                  labelText: 'Contact to Share With',
                ),
                onChanged: (Contact? newValue) {
                  if (newValue != null) {
                    selectedContact = newValue;
                  }
                  print(
                      'Selected Contact is now: ' + selectedContact.toString());
                },
                items: snapshot.data);
          } else
            return Text('Loading');
        });
  }

  Future<List<DropdownMenuItem<Content>>> _getContent() async {
    // List<Content> result = await Amplify.DataStore.query(Content.classType);
    final result = await Amplify.DataStore.query(Content.classType,
        sortBy: [Content.DESCRIPTION.ascending()]);
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
                },
                items: snapshot.data);
          } else
            return Text('Loading');
        });
  }

  Future<void> _onAddEventPressed() async {
    if (formKey.currentState!.validate()) {
      Amplify.DataStore.save(new Event(
          name: descriptionController.text,
          contentId: selectedContent.id,
          contactEmail: selectedContact.email,
          eventMonth: selectedMonth,
          eventDate: selectedDay.toString(),
          groupId: '',
          eventYear: '0'));
      Navigator.pushNamed(context, '/main', arguments: 'schedule');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add New Event',
          style: TextStyle(color: Colors.white),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Form(
          key: formKey,
          child: SingleChildScrollView(
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
                    child: DropdownButtonFormField<String>(
                      icon: const Icon(Icons.arrow_downward),
                      iconSize: 18,
                      elevation: 36,
                      isExpanded: true,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        filled: true,
                        labelText: 'Day of the Month',
                      ),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            selectedDay = newValue;
                          });
                        }
                      },
                      items: _getDays(selectedMonth),
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
                    child: _getContactDropdownItems(),
                  ),
                  SizedBox(height: 200),
                ],
              ),
            ),
          )),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: FloatingActionButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  _onAddEventPressed();
                  Navigator.pushNamed(context, '/main');
                }
              },
              child: const Icon(Icons.upload_sharp),
              heroTag: null,
              backgroundColor: Colors.lightBlue,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back_ios_sharp),
              backgroundColor: Colors.lightBlue,
            ),
          )
        ],
      ),
    );
  }
}
