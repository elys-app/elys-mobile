import 'package:flutter/material.dart';

import 'package:amplify_flutter/amplify_flutter.dart';

import '../../models/Account.dart';
import '../../models/Contact.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<SettingsPage> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final eventDateController = TextEditingController();

  Account currentAccount = new Account(
      userName: '',
      customerId: '',
      userFullName: '',
      executorName: '',
      executorEmail: '');

  List<Contact> contacts = List<Contact>.empty(growable: true);
  Contact selectedContact = new Contact(name: '', email: '');

  @override
  void initState() {
    super.initState();
    _setup();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _setup() async {
    try {
      final user = await Amplify.Auth.getCurrentUser();
      final accounts = await Amplify.DataStore.query(Account.classType);
      currentAccount =
          accounts.where((item) => item.userName == user.username).first;
      if (currentAccount.executorId != "") {
        setState(() {
          selectedContact = contacts.where((item) => item.id == currentAccount.executorId).first;
        });
      } else {
        setState(() {
          selectedContact = contacts[0];
        });
      }
    } catch (e) {
      setState(() {
        print(e);
      });
    }
  }

  Future<List<DropdownMenuItem<Contact>>> _getContacts() async {
    contacts = await Amplify.DataStore.query(Contact.classType,
        sortBy: [Contact.NAME.ascending()]);
    return (contacts
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
                  labelText: 'Designee Name',
                ),
                onChanged: (Contact? newValue) {
                  if (newValue != null) {
                    selectedContact = newValue;
                  }
                  print(
                      'Selected Contact is now: ' + selectedContact.toString());
                },
                value: selectedContact,
                items: snapshot.data);
          } else
            return Text('Loading');
        });
  }

  Future<void> onEditEventPressed() async {
    if (formKey.currentState!.validate()) {
      Account updatedAccount = currentAccount.copyWith(
          id: currentAccount.id,
          executorEmail: selectedContact.email,
          executorName: selectedContact.name,
          executorId: selectedContact.id);
      await Amplify.DataStore.save(updatedAccount);
      print('Updated: ${updatedAccount.toString()}');

      Navigator.pushNamed(context, '/main', arguments: 'contact');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Designee',
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
                  SizedBox(height: 100),
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
