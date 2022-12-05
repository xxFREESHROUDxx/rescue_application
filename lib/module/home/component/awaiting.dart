import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rescue_pet/model/User/UserController.dart';
import 'package:get/get.dart';
import 'package:rescue_pet/module/details/details.dart';

import '../../../model/Post/postController.dart';

class Awaiting extends StatefulWidget {
  const Awaiting({Key? key}) : super(key: key);

  @override
  State<Awaiting> createState() => _AwaitingState();
}

class _AwaitingState extends State<Awaiting> {
  UserController user = Get.find();
  late Stream<QuerySnapshot> _dataStream;
  PostController postController = Get.find();
  List<String> param = [];

  @override
  void initState() {
    setState(() {
      _dataStream =
          FirebaseFirestore.instance.collection('Posts').limit(5).snapshots();
      if (user.score.value < 3) {
        param = ["min"];
      } else if (user.score.value >= 3 && user.score.value <= 5) {
        param = ["mid", "min"];
      } else {
        param = ["max", "mid", "min"];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _dataStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
        return ListView(
          shrinkWrap: true,
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            for(var params in param){
              if(params == data['attention']){
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
              }else{
                continue;
              }
            }
            return ListTile();
          }).toList(),
        );
      },
    );
  }
}
