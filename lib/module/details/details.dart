import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rescue_pet/model/spons/spons.dart';
import 'package:rescue_pet/module/authenticate/userQuestionare/UserQuestionaire.dart';
import 'package:rescue_pet/module/details/component/popUp.dart';

class DetailScreen extends StatefulWidget {
  final String postId;
  const DetailScreen(this.postId, {Key? key}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  String imgUrl = '';
  String location = '';
  String reason = '';

  String breed = '';
  String contact = '';
  String effort = '';
  bool _isAdmin = false;

  _checkUser() {
    FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    String? tempEmail = user?.email.toString();
    if (tempEmail == 'leader@gmail.com') {
      setState(() {
        _isAdmin = true;
      });
    }
    print('Is Admin?');
    print(_isAdmin);
  }

  _getData() async {
    CollectionReference postRef =
        FirebaseFirestore.instance.collection('Posts');
    var data = await postRef.doc(widget.postId).get();
    setState(() {
      imgUrl = data.get('imgUrl');
      location = data.get('location');
      reason = data.get('reason');
      effort = data.get('attention');
      breed = data.get('breed');
      contact = data.get('contact');
      // effort = data.get('attention');
    });
  }

  _deletePost() async {
    CollectionReference postRef =
        FirebaseFirestore.instance.collection('Posts');
    var data = await postRef.doc(widget.postId).delete();
    Navigator.pop(context);
  }

  @override
  void initState() {
    _checkUser();
    _getData();
    print(widget.postId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(breed),
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height - 60,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                imgUrl.isEmpty
                    ? const CircularProgressIndicator()
                    : Image.network(
                        imgUrl,
                        height: (MediaQuery.of(context).size.height / 2) - 20,
                        width: double.infinity,
                        fit: BoxFit.contain,
                      ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  height: 5,
                  width: double.infinity,
                  color: Colors.black12,
                ),
                const Text(
                  'Dog Details',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Breed :',
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    Text(
                      breed,
                      style:
                          const TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Effort :',
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    Text(
                      effort,
                      style:
                          const TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Location :',
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    Text(
                      location,
                      style:
                          const TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Contact :',
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    Text(
                      contact,
                      style:
                          const TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Description :',
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    Text(
                      reason,
                      style:
                          const TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                  ],
                ),
                //
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     const Text(
                //       'Description :',
                //       style: TextStyle(
                //         fontSize: 18,
                //       ),
                //     ),
                //     Expanded(
                //       child: Text(
                //         reason,
                //         style: const TextStyle(
                //             fontSize: 18, color: Colors.black54),
                //       ),
                //     ),
                //   ],
                // ),
                _isAdmin
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Deleting Post!')));
                                Future.delayed(const Duration(seconds: 1), () {
                                  _deletePost();
                                });
                              },
                              child: const Text(
                                'Delete Post',
                                style: TextStyle(
                                    color: Colors.redAccent,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                              )),
                          // TextButton(
                          //     onPressed: () {},
                          //     child: ElevatedButton(
                          //       child: const Text(
                          //         'Adopt Me',
                          //         style: TextStyle(fontSize: 16),
                          //       ),
                          //       onPressed: () {
                          //         Navigator.push(
                          //             context,
                          //             MaterialPageRoute(
                          //                 builder: (context) => ApplicationForm(
                          //                     widget.postId, breed, reason)));
                          //       },
                          //     ))
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: ElevatedButton(
                              child: const Text(
                                'Adopt Me',
                                style: TextStyle(fontSize: 16),
                              ),
                              onPressed: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => ApplicationForm(
                                // widget.postId,
                                // breed,
                                // reason,
                                // effort,
                                //             )));

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ApplicationForm(
                                              widget.postId,
                                              breed,
                                              reason,
                                              effort,
                                            )));
                              },
                            ),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Sponsfer()),
                                );
                              },
                              child: Text(
                                'Sponser This Dog',
                                style: TextStyle(fontSize: 16),
                              ))
                        ],
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
