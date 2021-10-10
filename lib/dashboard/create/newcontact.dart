import 'package:flutter/material.dart';

import 'package:amplify_flutter/amplify.dart';

import '../../models/Group.dart';
import '../../models/Contact.dart';
import '../../models/ContactGroup.dart';

class NewContactPage extends StatefulWidget {
  NewContactPage({Key? key}) : super(key: key);

  @override
  _NewContactPageState createState() => _NewContactPageState();
}

class _NewContactPageState extends State<NewContactPage> {
  final ButtonStyle style =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();

  String name = '';
  String email = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void setState(fn) {
    if (this.mounted) {
      super.setState(fn);
    }
  }

  void onAddNewContactPressed() async {
    final groupWithEveryContact = await Amplify.DataStore.query(Group.classType,
        where: Group.NAME.eq('ALL'));

    try {
      Contact newContact = new Contact(
          name: nameController.text,
          email: emailController.text,
          groups: List<ContactGroup>.empty(growable: false));
      await Amplify.DataStore.save(newContact);
      print('Saved: ${newContact.toString()}');
      final newContactGroupItem = new ContactGroup(
          contact: newContact, group: groupWithEveryContact[0]);
      await Amplify.DataStore.save(newContactGroupItem);
      print('Saved: ${newContactGroupItem.toString()}');

      Navigator.pushNamed(context, '/main');
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add a New Contact',
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
                      return 'Please Enter a Contact Name';
                    }
                    return null;
                  },
                  controller: nameController,
                  obscureText: false,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                    labelText: 'Contact Name',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 30.0, top: 10.0, right: 30.0, bottom: 10.0),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter an Email';
                    }
                    return null;
                  },
                  controller: emailController,
                  obscureText: false,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                    labelText: 'Email Address',
                  ),
                ),
              ),
              SizedBox(height: 200),
              const SizedBox(height: 30)
            ],
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: FloatingActionButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  onAddNewContactPressed();
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
          ),
        ],
      ),
    );
  }
}
