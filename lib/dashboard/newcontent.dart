import 'dart:io';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

class NewContentPage extends StatefulWidget {
  NewContentPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _NewContentPageState createState() => _NewContentPageState();
}

class _NewContentPageState extends State<NewContentPage> {
  bool _imageSelected = false;
  File _image = new File('assets/images/elys.jpeg');

  final formKey = GlobalKey<FormState>();
  final imagePicker = ImagePicker();
  final descriptionController = TextEditingController();
  final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20), primary: Colors.lightBlue);

  @override
  void dispose() {
    super.dispose();
  }

  Future _getImage() async {
    final image = await imagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      if (image != null) {
        _image = File(image.path);
        _imageSelected = true;
      }
    });
  }

  Widget _buildNavigationButton() {
    return FloatingActionButton(
        backgroundColor: Colors.lightBlue,
        child: Icon(Icons.camera_alt),
        onPressed: () {
          _getImage();
        });
  }

  Widget _addNewContentButton() {
    return ElevatedButton(
        style: style,
    onPressed: () {
      if (formKey.currentState!.validate()) {
        print('Add New Photo or Video');
        print(descriptionController.text);
        Navigator.pop(context);
      }
    },
    child: Text('Add New Photo or Video')
    );
  }

  @override
  Widget build(BuildContext context) {
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
                    left: 30.0, top: 5.0, right: 30.0, bottom: 5.0),
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
                  padding: EdgeInsets.only(
                      left: 30.0, top: 5.0, right: 30.0, bottom: 5.0),
                  child: !_imageSelected
                      ? Text('No Image Selected')
                      : Container(
                          child: Image.file(_image), height: 320, width: 320)),
              SizedBox(height: 64),
              _addNewContentButton(),
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
      floatingActionButton: _buildNavigationButton(),
    );
  }
}
