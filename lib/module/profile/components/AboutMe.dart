import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rescue_pet/services/database.dart';

import '../../../model/User/UserController.dart';

class AboutMe extends StatefulWidget {
  const AboutMe({Key? key}) : super(key: key);

  @override
  State<AboutMe> createState() => _AboutMeState();
}

class _AboutMeState extends State<AboutMe> {
  UserController userController = Get.find();


  @override
  Widget build(BuildContext context) {
    DatabaseService databaseService = DatabaseService(uid: userController.uid.toString());
    databaseService.getUserDetail();
    return Card(
      child: Container(
        height: 170,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Personal Information', style: TextStyle(
              fontSize: 18,
              color: Colors.blueAccent
            ),),
            const Divider(
              height: 8,
              color: Colors.black,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Full Name'),
                Text(userController.fullName.toString(), style:const TextStyle(
                  color: Colors.black54
                ),),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Address'),
                Text(userController.address.toString(), style:const TextStyle(
                  color: Colors.black54
                ),),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Email'),
                Text(userController.email.toString(), style:const TextStyle(
                  color: Colors.black54
                ),),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Contact'),
                Text(userController.contact.toString(), style:const TextStyle(
                  color: Colors.black54
                ),),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
