import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ApplicationDetail extends StatefulWidget {
  String appId;
  ApplicationDetail(this.appId, {Key? key}) : super(key: key);

  @override
  State<ApplicationDetail> createState() => _ApplicationDetailState();
}

class _ApplicationDetailState extends State<ApplicationDetail> {
  String fullname = '';
  String desc = '';
  String person = '';
  String contact = '';
  bool isApproved = false;
  String postId = '';
  String userId = '';
  double longitude = 0;
  double latitude = 0;
  String location = '';
  String effort = '';
  String breed = '';
  bool _isLoading = true;
  bool _isAdmin = false;

  _checki() {
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
    CollectionReference appRef =
        FirebaseFirestore.instance.collection('Applications');
    var data = await appRef.doc(widget.appId).get();
    setState(() {
      fullname = data.get('fullname');
      desc = data.get('desc');
      person = data.get('person');
      contact = data.get('contact');
      postId = data.get('postId');
      userId = data.get('userid');
      location = data.get('location');
      effort = data.get('effort');

      breed = data.get('breed');
      latitude = data.get('lat');
      longitude = data.get('long');
      isApproved = data.get('isApproved');
    });
  }

  _verifyApplication() async {
    CollectionReference appRef =
        FirebaseFirestore.instance.collection('Applications');
    await appRef.doc(widget.appId).set({
      'isApproved': true,
      'fullname': fullname,
      'desc': desc,
      'person': person,
      'contact': contact,
      'postId': postId,
      'userid': userId,
      'effort': effort,
      'breed': breed,
      'location': location,
      'lat': latitude,
      'long': longitude
    });
    _getData();
  }

  @override
  void initState() {
    _checki();
    _getData();
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Application Detail'),
      ),
      body: _isLoading
          ? const LinearProgressIndicator()
          : SingleChildScrollView(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                child: Column(
                  children: [
                    const Text(
                      'Application Details',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87),
                    ),
                    const Divider(
                      height: 10,
                      color: Colors.black54,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Full Name',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black54),
                            ),
                            SizedBox(
                              width: 200,
                              child: Text(fullname,
                                  maxLines: 5,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black87)),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Description',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black54),
                            ),
                            SizedBox(
                              width: 200,
                              child: Text(desc,
                                  maxLines: 5,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black87)),
                            )
                          ],
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     // const Text(
                        //     //   'Reason',
                        //     //   style: TextStyle(
                        //     //       fontSize: 18,
                        //     //       fontWeight: FontWeight.normal,
                        //     //       color: Colors.black54),
                        //     // ),
                        //     // SizedBox(
                        //     //   width: 200,
                        //     //   child: Text(reason,
                        //     //       maxLines: 5,
                        //     //       style: const TextStyle(
                        //     //           fontSize: 18,
                        //     //           fontWeight: FontWeight.normal,
                        //     //           color: Colors.black87)),
                        //     // )
                        //   ],
                        // ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Effort',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black54),
                            ),
                            SizedBox(
                              width: 200,
                              child: Text(effort,
                                  maxLines: 5,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black87)),
                            )
                          ],
                        ),

                        //

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Breed',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black54),
                            ),
                            SizedBox(
                              width: 200,
                              child: Text(breed,
                                  maxLines: 5,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black87)),
                            )
                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Contact',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black54),
                            ),
                            SizedBox(
                              width: 200,
                              child: Text(contact,
                                  maxLines: 5,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black87)),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Longitude',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black54),
                            ),
                            SizedBox(
                              width: 200,
                              child: Text('$longitude',
                                  maxLines: 5,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black87)),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Latitude',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black54),
                            ),
                            SizedBox(
                              width: 200,
                              child: Text('$latitude',
                                  maxLines: 5,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black87)),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Location',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black54),
                            ),
                            SizedBox(
                              width: 200,
                              child: Text(location,
                                  maxLines: 5,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black87)),
                            )
                          ],
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     const Text(
                        //       'Status:',
                        //       style: TextStyle(
                        //           fontSize: 18,
                        //           fontWeight: FontWeight.normal,
                        //           color: Colors.black54),
                        //     ),
                        //     isApproved
                        //         ? const Text('Verified',
                        //             style: TextStyle(
                        //                 fontSize: 18,
                        //                 fontWeight: FontWeight.normal,
                        //                 color: Colors.green))
                        //         : const Text('Not Verified',
                        //             style: TextStyle(
                        //                 fontSize: 18,
                        //                 fontWeight: FontWeight.normal,
                        //                 color: Colors.black87))
                        //   ],
                        // ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Status',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black54),
                            ),
                            isApproved
                                ? const Text('Verified',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.green))
                                : const Text('Not Verified',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black87))
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    const Divider(
                      height: 10,
                      color: Colors.black54,
                    ),
                    _isAdmin
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                  onPressed: _verifyApplication,
                                  child: const Text(
                                    'Accept',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.lightBlue),
                                  ))
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "Waiting for admin to verify...",
                                style: TextStyle(color: Colors.red),
                              )
                            ],
                          )
                  ],
                ),
              ),
            ),
    );
  }
}
