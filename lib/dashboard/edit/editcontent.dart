import 'dart:core';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:elys_mobile/models/Content.dart';
import 'package:elys_mobile/models/Event.dart';


class EditContentPage extends StatefulWidget {
  EditContentPage({Key? key, required this.contentItem}) : super(key: key);

  final Content contentItem;

  @override
  _EditContentPageState createState() => _EditContentPageState();
}

class _EditContentPageState extends State<EditContentPage> {
  final formKey = GlobalKey<FormState>();
  final descriptionController = TextEditingController();
  final nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    descriptionController.text = widget.contentItem.description;
    nameController.text = widget.contentItem.name;
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> onEditContentPressed() async {
    try {
      Content updatedContent = widget.contentItem.copyWith(
          id: widget.contentItem.id,
          description: descriptionController.text);
      await Amplify.DataStore.save(updatedContent);
      print('Updated: ${updatedContent.toString()}');

      Navigator.pushNamed(context, '/main', arguments: 'content');
    } catch (e) {
      print(e.toString());
    }
  }

  void onDeleteContentPressed() async {
    final contact = (await Amplify.DataStore.query(Content.classType,
        where: Content.ID.eq(widget.contentItem.id)))[0];
    final events = await Amplify.DataStore.query(Event.classType,
        where: Event.CONTENTID.eq(widget.contentItem.id));

    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("Warning"),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Deleting this Media Item will '),
                Text('delete the Events attached to'),
                Text('this Media Item')
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                _deleteAll(contact, events);
              },
            ),
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                setState(() {
                  Navigator.pop(context);
                });
              },
            )
          ],
        ),
        barrierDismissible: false);
  }

  Future<void> _deleteAll(Content item, List<Event> events) async {
    try {
      await Amplify.Storage.remove(key: widget.contentItem.key);
      await Amplify.DataStore.delete(item);
      events.forEach((event) async {
        await Amplify.DataStore.delete(event);
      });
      Navigator.pushNamed(context, '/main', arguments: 'content');
    } on StorageException catch (e) {
      SnackBar snackBar = SnackBar(
        content: Text('${e.message}'),
        duration: Duration(seconds: 3),
        action: SnackBarAction(label: 'OK', onPressed: () {}),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
      body: Container(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(height: 50),
              Padding(
                padding: EdgeInsets.only(
                    left: 30.0, top: 10.0, right: 30.0, bottom: 10.0),
                child: Text(
                  'Change the Media Item info',
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
                      return 'Please Enter a Description';
                    }
                    return null;
                  },
                  controller: descriptionController,
                  obscureText: false,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.description_sharp),
                    border: OutlineInputBorder(),
                    labelText: 'Description',
                  ),
                ),
              ),
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
                  controller: nameController,
                  enabled: false,
                  obscureText: false,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.description_sharp),
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                  ),
                ),
              ),
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
                onDeleteContentPressed();
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
                  onEditContentPressed();
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
                Navigator.pushNamed(context, '/main', arguments: 'content');
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
