import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rescue_pet/model/User/UserController.dart';
import 'package:rescue_pet/module/authenticate/register.dart';
import 'package:rescue_pet/services/auth.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  UserController user = Get.find();

  String email = '';
  String password = '';
  String? name;
  String? contact;
  String? address;

  @override
  Widget build(BuildContext context) {
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
                      'Rescue',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w800,
                          color: Colors.blueAccent),
                    ),
                    Text(
                      ' Dog',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const Text(
                  'Sign In',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
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
                  height: 20,
                ),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _authService.signInWithEmailandPassword(
                                email, password, context);
                            if (user.uid.value != '') {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('User logged in successfully'),
                                behavior: SnackBarBehavior.floating,
                              ));
                            }
                          }
                        },
                        child: const Text(
                          'Sign In',
                          style: TextStyle(fontSize: 18),
                        ))),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Don"t have an Account?'),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Register(email,
                                        password, contact, address, name)));
                          },
                          child: const Text('Sign Up'))
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
