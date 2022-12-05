import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rescue_pet/model/User/UserController.dart';
import 'package:rescue_pet/module/authenticate/userQuestionare/UserQuestionaire.dart';
import 'package:rescue_pet/services/database.dart';

class ApplicationForm extends StatefulWidget {
  String postId;
  String breed;
  String reason;
  String effort;
  ApplicationForm(this.postId, this.breed, this.reason, this.effort, {Key? key})
      : super(key: key);

  @override
  State<ApplicationForm> createState() => _ApplicationFormState();
}

class _ApplicationFormState extends State<ApplicationForm> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _imagePicker = ImagePicker();
  XFile? image;
  UserController user = Get.find();
  String fullname = '';
  String person = '';
  String contact = '';
  String location = '';
  @override
  Widget build(BuildContext context) {
    DatabaseService service = DatabaseService(uid: user.uid.value);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Application Form'),
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
                  'Fill the following fields',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                ),

                // yeta deki suru
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter full name';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      fullname = value;
                    });
                  },
                  decoration: const InputDecoration(
                      hintText: 'Full Name', label: Text('Full Name')),
                ),

// yo location ho

                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter Your location';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      location = value;
                    });
                  },
                  decoration: const InputDecoration(
                      hintText: 'Location ', label: Text('location')),
                ),

                // Description ho

                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter Description';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      person = value;
                    });
                  },
                  decoration: const InputDecoration(
                      hintText: 'Description', label: Text('Description')),
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
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserQuestionare(
                                      widget.postId,
                                      widget.breed,
                                      widget.reason,
                                      widget.effort,
                                      fullname,
                                      person,
                                      contact,
                                      location,
                                    )));
                        print('breed: ${widget.breed}');
                        print('effort: ${widget.effort}');
                        print('reason: ${widget.reason}');
                        print('postId: ${widget.postId}');
                      }
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => UserQuestionare(
                      //             widget.breed,
                      //             widget.effort,
                      //             widget.postId,
                      //             widget.reason)));
                      {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  backgroundColor: Colors.green,
                                  content:
                                      Text('Submitteed get the score now')));
                          // Future.delayed(const Duration(seconds: 3), () {
                          //   service.postApplication(
                          //       fullname,
                          //       widget.effort,
                          //       widget.reason,
                          //       contact,
                          //       person,
                          //       widget.postId,
                          //       widget.breed,
                          //       location,
                          //       applicantEffort);
                          // });
                        }
                      }
                    },
                    child: Text("Request"))
              ],
            ),
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //     onPressed: (){
      //       if (_formKey.currentState!.validate()) {
      //         ScaffoldMessenger.of(context).showSnackBar(
      //             const SnackBar(content: Text('Posting your application')));
      //         Future.delayed(const Duration(seconds: 3), () {
      //           service
      //               .postApplication(fullname, widget.effort, widget.reason,
      //                   contact, person, widget.postId, widget.breed, location)
      //               .then((value) => Navigator.pop(context));
      //         });
      //       }
      //     },
      //     label: const Text(
      //       'Request',
      //       style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
      //     )),
    );
  }
}
