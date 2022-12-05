import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rescue_pet/module/profile/components/AboutMe.dart';
import 'package:rescue_pet/services/database.dart';
import '../../model/User/UserController.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  bool _isLoading = true;

  UserController userController = Get.find();

  @override
  void initState(){
    // print(AuthService().user);
    DatabaseService databaseService = DatabaseService(uid: userController.uid.value);
    databaseService.getUserDetail();
    Future.delayed(const Duration(seconds: 1),(){
      setState((){
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 60,
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.only(top: 18, right: 10, left: 10, bottom: 10),
      child: _isLoading? const Center(
        child: CircularProgressIndicator(),
      ):SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListTile(
              leading: const CircleAvatar(
                radius: 25,
                child: Icon(Icons.person_rounded),
              ),
              title:  Text(userController.fullName.toString()),
              subtitle: Text(userController.email.toString()),
              trailing: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_vert_rounded),
              ),
            ),
            const Divider(
              height: 8,
              color: Colors.black12,
            ),
            AboutMe(),
            const SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: (){
                  Navigator.pushNamed(context, '/recApplication');
                }, child: const Text('Received Applications', style: TextStyle(
                    fontSize: 16
                ),)),
                ElevatedButton(onPressed: (){
                  Navigator.pushNamed(context, '/applications');
                }, child: const Text('My Applications', style: TextStyle(
                    fontSize: 16
                ),))
              ],
            )
          ],
        ),
      ),
    );
  }
}
