import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:rescue_pet/model/Application/ApplicationController.dart';
import 'package:rescue_pet/model/Post/postController.dart';
import 'package:rescue_pet/model/User/User.dart';
import 'package:rescue_pet/module/profile/applications/applications.dart';
import 'package:rescue_pet/module/wrapper.dart';
import 'package:rescue_pet/services/auth.dart';
import 'model/User/UserController.dart';
import 'module/profile/applications/receivedApplication/recievedApp.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  String? email = '';
  String? password = '';
   MyApp({Key? key, this.email, this.password}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    final UserController userController = Get.put(UserController());
    final PostController postController = Get.put(PostController());
    ApplicationController applicationController = Get.put(ApplicationController());
    applicationController.getAllApplication();
    applicationController.getUsersApplication();
    applicationController.getPendingApplication();
    postController.getAllPosts();
    return StreamProvider<CustomUser?>.value(
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
        title: 'RescueDog',
        theme: ThemeData(
          fontFamily: 'Poppins',
          primarySwatch: Colors.blue,
          //color for theme is red
        ),
        home: Wrapper(),
        routes: {
          '/applications': (context)=> const ApplicationScreen(),
          '/recApplication': (context)=> const RecApplicationScreen()
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
