import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rescue_pet/model/User/UserController.dart';
import 'package:rescue_pet/services/database.dart';

class CustomAlertDialog extends StatefulWidget {
  const CustomAlertDialog({Key? key}) : super(key: key);

  @override
  State<CustomAlertDialog> createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _imagePicker = ImagePicker();
  XFile? image;
  UserController user = Get.find();
  String location = '';
  String breed = '';
  String reason = '';
  String contact = '';

  _selectImage() async {
    XFile? img = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (img != null) {
      setState(() {
        image = img;
      });
    }
  }

  var items = ['min', 'mid', 'max'];
  String _dropDownvalue = 'min';

  @override
  Widget build(BuildContext context) {
    DatabaseService service = DatabaseService(uid: user.uid.value);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 25,
                ),
                const Text(
                  'Create a Post',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter location';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      location = value;
                    });
                  },
                  decoration: const InputDecoration(
                      hintText: 'Location', label: Text('Location')),
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter breed of the dog';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      breed = value;
                    });
                  },
                  decoration: const InputDecoration(
                      hintText: 'Breed', label: Text('Breed')),
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter Description';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      reason = value;
                    });
                  },
                  decoration: const InputDecoration(
                      hintText: 'Description', label: Text('Description')),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Effort to take care:'),
                    DropdownButton(
                        value: _dropDownvalue,
                        items: items.map((String items) {
                          return DropdownMenuItem(
                            child: Text('$items effort'),
                            value: items,
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _dropDownvalue = newValue!;
                          });
                        })
                  ],
                ),
                TextFormField(
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter contact';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      contact = value;
                    });
                  },
                  decoration: const InputDecoration(
                      hintText: 'Contact', label: Text('Contact')),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: _selectImage,
                  child: const Text('Upload Image'),
                ),
                const SizedBox(
                  height: 10,
                ),
                image != null
                    ? Image.file(
                        File(image!.path),
                        fit: BoxFit.contain,
                      )
                    : Container(
                        width: double.infinity,
                        height: 180,
                        color: Colors.black26,
                        child: const Center(
                          child: Text(
                            'No Image Selected',
                            style: TextStyle(color: Colors.black54),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              if (image == null) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                  'Select an image to continue',
                  style: TextStyle(color: Color.fromRGBO(223, 120, 97, 1)),
                )));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Posting your content')));
                Future.delayed(const Duration(seconds: 3), () {
                  service
                      .uploadPost(location, breed, reason, image!, contact,
                          _dropDownvalue)
                      .then((value) => service
                          .pushLocation()
                          .then((value) => Navigator.pop(context)));
                });
              }
            }
          },
          label: const Text(
            'Post',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
          )),
    );
  }
}
