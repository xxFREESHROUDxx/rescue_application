import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rescue_pet/module/authenticate/login.dart';
import 'package:rescue_pet/module/authenticate/userQuestionare/UserQuestionaire.dart';

import '../../model/User/UserController.dart';
import '../../services/auth.dart';

class Register extends StatefulWidget {
  String? email;
  String? password;
  String? name;
  String? contact;
  String? address;
  Register(this.email, this.password, this.name, this.contact, this.address);

  @override
  State<Register> createState() =>
      _RegisterState(email, address, password, contact, name);
}

class _RegisterState extends State<Register> {
  UserController user = Get.find();

  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  String? name;
  String? contact;
  String? address;
  _RegisterState(
      this.email, this.password, this.name, this.contact, this.address);

  @override
  Widget build(BuildContext context) {
    final AuthService _authService = AuthService();
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Text(
                      'Stay',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      ' Connected',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                          color: Colors.blueAccent),
                    ),
                  ],
                ),
                const Text(
                  'Sign Up',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                      color: Colors.blueAccent),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Email Here',
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.mail_rounded),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Email';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      email = value;
                      // print(email);
                    });
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Name Here',
                    labelText: 'Full Name',
                    prefixIcon: Icon(Icons.person_rounded),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Full Name';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      name = value;
                      // print(email);
                    });
                  },
                ),
                TextFormField(
                  maxLength: 10,
                  decoration: const InputDecoration(
                    hintText: 'Contact Here',
                    labelText: 'Contact Info',
                    prefixIcon: Icon(Icons.call_rounded),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your contact info';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      contact = value;
                    });
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Location Here',
                    labelText: 'Location',
                    prefixIcon: Icon(Icons.gps_fixed_rounded),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your contact info';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      address = value;
                    });
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Password Here',
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.key_rounded),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  obscureText: true,
                  onChanged: (value) {
                    setState(() {
                      password = value;
                      // print(password);
                    });
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () async {
                          await _authService.signUpWithEmailandPassword(email!,
                              password!, name!, contact!, address!, context);
                          if (_formKey.currentState!.validate()) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignIn()));
                          }
                        },
                        child: const Text(
                          'Register',
                          style: TextStyle(fontSize: 18),
                        ))),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an Account?'),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignIn()));
                          },
                          child: const Text('Sign In'))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
