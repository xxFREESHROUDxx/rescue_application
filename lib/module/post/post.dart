import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rescue_pet/model/User/UserController.dart';
import 'package:rescue_pet/module/post/components/alertBox.dart';
import 'package:get/get.dart';

import '../details/details.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  UserController controller = Get.find();
  List<String> param = [];

  @override
  void initState() {
    super.initState();
    print(controller.score.value);
    if (controller.score.value < 3) {
      param = ["min"];
    } else if (controller.score.value >= 3 && controller.score.value <= 5) {
      param = ["mid", "min"];
    } else {
      param = ["max", "mid", "min"];
    }
  }

  _addPost() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const CustomAlertDialog()));
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> dataStream =
        FirebaseFirestore.instance.collection('Posts').snapshots();

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: SingleChildScrollView(
          child: StreamBuilder<QuerySnapshot>(
            stream: dataStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text(
                    'Something went wrong!',
                    style: TextStyle(color: Colors.black38),
                  ),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasData) {
                return ListView(
                  shrinkWrap: true,
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    print('data: ${data}');
                    // for (var params in param) {
                    // if (params == data['attention']) {
                    return ListTile(
                      leading: Image.network(
                        '${data['imgUrl']}',
                        width: 60,
                      ),
                      title: Text('${data['breed']}'),
                      subtitle: Text('Location ${data['location']}'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DetailScreen(document.id)));
                      },
                    );
                    // } else {
                    //   continue;
                    // }
                    // }
                    return ListTile();
                  }).toList(),
                );
              } else {
                return const Text('No Posts yet');
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        // isExtended: true,
        onPressed: _addPost,
        label: const Text(
          'Add Post',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
