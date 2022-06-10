import 'package:flutter/material.dart';

import 'package:amplify_flutter/amplify_flutter.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:elys_mobile/models/Contact.dart';

class EditContactPage extends StatefulWidget {
  EditContactPage({Key? key, required this.contactItem}) : super(key: key);

  final Contact contactItem;

  @override
  _EditContactPageState createState() => _EditContactPageState();
}

class _EditContactPageState extends State<EditContactPage> {
  final ButtonStyle style =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();

  bool deleteConnection = false;

  @override
  void initState() {
    super.initState();

    nameController.text = widget.contactItem.name;
    emailController.text = widget.contactItem.email;
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

  void onEditContactPressed() async {
    try {
      Contact updatedContact = widget.contactItem.copyWith(
          id: widget.contactItem.id,
          name: nameController.text,
          email: emailController.text);
      await Amplify.DataStore.save(updatedContact);
      print('Updated: ${updatedContact.toString()}');

      Navigator.pushNamed(context, '/main', arguments: 'contact');
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Elys Mobile',
          style: GoogleFonts.bellefair(
              textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w500)),
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
                SizedBox(height: 50),
                Padding(
                  padding: EdgeInsets.only(
                      left: 30.0, top: 10.0, right: 30.0, bottom: 10.0),
                  child: Text(
                    'Change the Connection info',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                SizedBox(height: 20),
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
                  onEditContactPressed();
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
                Navigator.pushNamed(context, '/main', arguments: 'contact');
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
