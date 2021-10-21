import 'dart:core';
import 'dart:io';
import 'dart:convert';

import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:elys_mobile/amplifyconfiguration.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/content.dart';

class NewContentPage extends StatefulWidget {
  NewContentPage({Key? key}) : super(key: key);

  @override
  _NewContentPageState createState() => _NewContentPageState();
}

class _NewContentPageState extends State<NewContentPage> {
  bool _imageSelected = false;
  File _image = new File('');

  int _currentStep = 0;
  String _bucket = '';
  String _region = '';

  final formKey = GlobalKey<FormState>();
  final imagePicker = ImagePicker();
  final descriptionController = TextEditingController();
  final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20), primary: Colors.lightBlue);

  @override
  void initState() {
    super.initState();
    _getS3Config();
  }

  void _getS3Config() {
    final s3config = jsonDecode(amplifyconfig)['storage']['plugins']['awsS3StoragePlugin'];
    _bucket = s3config['bucket'];
    _region = s3config['region'];
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _getImage() async {
    final image = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (image != null) {
        _image = File(image.path);
        _imageSelected = true;
        print(image.path);
        print(_imageSelected.toString());
      }
    });
  }

  Future<void> onAddNewContentPressed() async {
    final username = (await Amplify.Auth.getCurrentUser()).username;
    final filename = _image.path.split('/').last;
    final key = username + '-' + filename;
    try {
      await Amplify.Storage.uploadFile(local: File(_image.path), key: key);
      await Amplify.DataStore.save(new Content(
        name: key,
        description: descriptionController.text,
        region: _region,
        bucket: _bucket,
        key: filename,
        type: key.split('.').last
      ));
      Navigator.pop(context);
    } on StorageException catch (e) {
      print('Error uploading image: $e');
    }
  }

  void _continue() {
    if (_currentStep < 1) {
      if (formKey.currentState!.validate()) {
        setState(() => _currentStep += 1);
      }
      return;
    } else if (_currentStep == 1) {
      onAddNewContentPressed();
      return;
    }
  }

  void _cancel() {
    if (_currentStep == 0) {
      Navigator.pop(context);
      return;
    } else if (_currentStep > 0) {
      setState(() => _currentStep -= 1);
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add New Content',
          style: TextStyle(color: Colors.white),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Expanded(
                child: Stepper(
                  type: StepperType.vertical,
                  physics: ScrollPhysics(),
                  currentStep: _currentStep,
                  onStepTapped: (step) => setState(() => _currentStep = step),
                  onStepContinue: _continue,
                  onStepCancel: _cancel,
                  steps: <Step>[
                    Step(
                      title: new Text('Select'),
                      content: Column(
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
                                  left: 30.0,
                                  top: 5.0,
                                  right: 30.0,
                                  bottom: 5.0),
                              child: new ElevatedButton.icon(
                                  icon: Icon(Icons.photo_camera),
                                  label: Text('Select a Photo or Video'),
                                  onPressed: () {
                                    _getImage();
                                  })),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 30.0,
                                  top: 5.0,
                                  right: 30.0,
                                  bottom: 5.0),
                              child: !_imageSelected
                                  ? Text('No Image Selected')
                                  : Container(
                                      child: Image.file(_image),
                                      height: 120,
                                      width: 120)),
                          SizedBox(height: 64),
                          const SizedBox(height: 30),
                        ],
                      ),
                      isActive: _currentStep >= 0,
                      state: _currentStep >= 0
                          ? StepState.complete
                          : StepState.disabled,
                    ),
                    Step(
                      title: new Text('Upload'),
                      content: Spacer(),
                      isActive: _currentStep >= 0,
                      state: _currentStep >= 1
                          ? StepState.complete
                          : StepState.disabled,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
