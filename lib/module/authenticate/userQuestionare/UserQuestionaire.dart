import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rescue_pet/layout/mainLayout.dart';
import 'package:rescue_pet/model/User/UserController.dart';
import 'package:rescue_pet/module/home/component/awaiting.dart';
import 'package:rescue_pet/module/post/post.dart';
import 'package:rescue_pet/module/home/home.dart';
import 'package:rescue_pet/module/profile/profile.dart';
import 'package:rescue_pet/services/database.dart';

import '../../../services/auth.dart';

class UserQuestionare extends StatefulWidget {
  String breed;
  String effort;
  String postId;
  String reason;
  String fullname;
  String person;
  String contact;
  String location;
  UserQuestionare(this.breed, this.effort, this.postId, this.reason,
      this.fullname, this.person, this.location, this.contact,
      {Key? key})
      : super(key: key);
  // String? email;
  // String? password;
  // String? name;
  // String? contact;
  // String? address;
  // UserQuestionare(
  //     this.email, this.password, this.name, this.contact, this.address,
  //     {Key? key})
  //     : super(key: key);

  @override
  State<UserQuestionare> createState() => _UserQuestionareState();
}

class _UserQuestionareState extends State<UserQuestionare> {
  UserController user = Get.find();
  String? postId = '';
  String breed = '';
  final _formKey = GlobalKey<FormState>();
  final List<String> _hours = ["can't", "half", "half_one", "one_more"];
  String _hour = "";
  int hour_score = 0;

  final List<String> _moneys = ["can't", "one", "one_three", "three_more"];
  String _money = "";
  int money_score = 0;

  final List<String> _spaces = ["can't", "one", "one_three", "three_more"];
  String _space = "";
  int space_score = 0;
  int total_score = 0;

  @override
  Widget build(BuildContext context) {
    DatabaseService service = DatabaseService(uid: user.uid.value);
    // final AuthService _authService = AuthService();

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            // height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Text(
                      'Almost',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      ' There',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                          color: Colors.blueAccent),
                    ),
                  ],
                ),
                const Text(
                  'Please answer the following questions',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      color: Colors.black),
                ),
                const Divider(
                  height: 10,
                  thickness: 5,
                  color: Colors.blue,
                ),
                const Text(
                  'How many hours daily can you make time to roam the dog?',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: Colors.black),
                ),
                RadioListTile(
                  title: const Text("I can't"),
                  value: _hours[0],
                  groupValue: _hour,
                  onChanged: (value) {
                    setState(() {
                      _hour = value.toString();
                    });
                  },
                ),
                RadioListTile(
                  title: const Text('Less than half an hour'),
                  value: _hours[1],
                  groupValue: _hour,
                  onChanged: (value) {
                    setState(() {
                      _hour = value.toString();
                      hour_score = 1;
                    });
                  },
                ),
                RadioListTile(
                  title: const Text('Half an hour to one hour'),
                  value: _hours[2],
                  groupValue: _hour,
                  onChanged: (value) {
                    setState(() {
                      _hour = value.toString();
                      hour_score = 2;
                    });
                  },
                ),
                RadioListTile(
                  title: const Text('More than one hour'),
                  value: _hours[3],
                  groupValue: _hour,
                  onChanged: (value) {
                    setState(() {
                      _hour = value.toString();
                      hour_score = 3;
                    });
                  },
                ),
                //money
                const Text(
                  'How much money are you able to spend on a dog in a month?',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: Colors.black),
                ),
                RadioListTile(
                  title: const Text("I can't"),
                  value: _moneys[0],
                  groupValue: _money,
                  onChanged: (value) {
                    setState(() {
                      _money = value.toString();
                    });
                  },
                ),
                RadioListTile(
                  title: const Text('Up to Rs. 1000 a month'),
                  value: _moneys[1],
                  groupValue: _money,
                  onChanged: (value) {
                    setState(() {
                      _money = value.toString();
                      money_score = 1;
                    });
                  },
                ),
                RadioListTile(
                  title: const Text('Rs. 1000 to 3000 a month'),
                  value: _moneys[2],
                  groupValue: _money,
                  onChanged: (value) {
                    setState(() {
                      _money = value.toString();
                      money_score = 2;
                    });
                  },
                ),
                RadioListTile(
                  title: const Text('More than rs. 3000 a month'),
                  value: _moneys[3],
                  groupValue: _money,
                  onChanged: (value) {
                    setState(() {
                      _money = value.toString();
                      money_score = 3;
                    });
                  },
                ),
                //space
                const Text(
                  'How much space do you have in your home for the mobility of the dog?',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: Colors.black),
                ),
                RadioListTile(
                  title: const Text("I don't"),
                  value: _spaces[0],
                  groupValue: _space,
                  onChanged: (value) {
                    setState(() {
                      _space = value.toString();
                    });
                  },
                ),
                RadioListTile(
                  title: const Text('Up to 100sq.ft'),
                  value: _moneys[1],
                  groupValue: _space,
                  onChanged: (value) {
                    setState(() {
                      _space = value.toString();
                      money_score = 1;
                    });
                  },
                ),
                RadioListTile(
                  title: const Text('100 to 300 sq.ft'),
                  value: _moneys[2],
                  groupValue: _space,
                  onChanged: (value) {
                    setState(() {
                      _space = value.toString();
                      money_score = 2;
                    });
                  },
                ),
                RadioListTile(
                  title: const Text('More than 300sq.ft'),
                  value: _moneys[3],
                  groupValue: _space,
                  onChanged: (value) {
                    setState(() {
                      _space = value.toString();
                      money_score = 3;
                    });
                  },
                ),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () async {
                          if (_hour != "" && _space != "" && _money != "") {
                            setState(() {
                              total_score =
                                  money_score + hour_score + space_score;
                            });
                            String result = '';
                            if (total_score >= 0 && total_score <= 3) {
                              result = 'min effort';
                            } else if (total_score >= 4 && total_score <= 6) {
                              result = 'mid effort';
                            } else {
                              result = 'max effort';
                            }
                            print(result);
                            Future.delayed(const Duration(seconds: 3), () {
                              service.postApplication(
                                  breed,
                                  widget.effort,
                                  widget.postId,
                                  widget.reason,
                                  widget.fullname,
                                  widget.person,
                                  widget.location,
                                  widget.contact,
                                  result);
                            });
                            // print('breed: ${widget.breed}');
                            print('effort: ${widget.effort}');
                            print('reason: ${widget.reason}');
                            print('postId: ${widget.postId}');
                            print('result: ${result}');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MainLayout()),
                            );
                            // dynamic result =
                            //     await _authService.signUpWithEmailandPassword(
                            //         widget.email!,
                            //         widget.password!,
                            //         widget.name!,
                            //         widget.contact!,
                            //         widget.address!,

                            //         context);
                            // user.uid.value != ''
                            //     ? ScaffoldMessenger.of(context)
                            //         .showSnackBar(const SnackBar(
                            //         content:
                            //             Text('User Registered Successfully!'),
                            //         behavior: SnackBarBehavior.floating,
                            //       ))
                            //     : null;
                            // Future.delayed(const Duration(seconds: 5));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    elevation: 5,
                                    behavior: SnackBarBehavior.floating,
                                    content: Text('Please select values')));
                          }
                        },
                        child: const Text(
                          'Submit',
                          style: TextStyle(fontSize: 18),
                        ))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
