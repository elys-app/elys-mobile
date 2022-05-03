import 'package:flutter/material.dart';

import 'package:amplify_flutter/amplify_flutter.dart';

import '../../models/Event.dart';
import '../../models/Content.dart';
import '../../models/Contact.dart';

class EditSchedulePage extends StatefulWidget {
  EditSchedulePage({Key? key, required this.eventItem}) : super(key: key);

  final Event eventItem;

  @override
  _EditSchedulePageState createState() => _EditSchedulePageState();
}

class _EditSchedulePageState extends State<EditSchedulePage> {
  final formKey = GlobalKey<FormState>();
  final descriptionController = TextEditingController();
  final eventDateController = TextEditingController();

  String selectedMonth = '';
  String selectedDay = '';
  List<Content> contentItems = new List<Content>.empty(growable: true);
  Contact selectedContact = new Contact(name: '', email: '');
  Contact originalContact = new Contact(name: '', email: '');
  Content selectedContent = new Content(description: '', name: '', type: '', bucket: '', region: '', key: '');

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
  void initState() {
    super.initState();
    _setup();
    descriptionController.text = widget.eventItem.name;
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _setup() async {
    try {
      // final contactItems = await Amplify.DataStore.query(Contact.classType);
      // this.selectedContact = result.where((item) => item.email == widget.eventItem.contactEmail).first;
      final contentItems = await Amplify.DataStore.query(Content.classType);
      var currentContent = contentItems.where((item) => item.id == widget.eventItem.contentId).first;

      currentContent =
          contentItems.where((item) => item.id == widget.eventItem.contentId).first;
      if (currentContent.id != "") {
        setState(() {
          selectedContent = currentContent;
        });
      } else {
        setState(() {
          selectedContent = contentItems[0];
        });
      }

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
                // value: originalContact,
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
                value: selectedContent,
                items: snapshot.data);
          } else
            return Text('Loading');
        });
  }

  Future<void> onEditEventPressed() async {
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

  void onDeleteEventPressed() async {
    await Amplify.DataStore.delete(widget.eventItem);
    Navigator.pushNamed(context, '/main', arguments: 'schedule');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Event',
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
                        value: widget.eventItem.eventMonth),
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
                        value: widget.eventItem.eventDate),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 30, top: 0, right: 30.0, bottom: 8.0),
                    child: _getContentDropdownItems(),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(
                  //       left: 30, top: 0, right: 30.0, bottom: 8.0),
                  //   child: _getContactDropdownItems(),
                  // ),
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
                onDeleteEventPressed();
              },
              child: const Icon(Icons.delete_sharp),
              heroTag: null,
              backgroundColor: Colors.pink,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20),

            child: FloatingActionButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  onEditEventPressed();
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
