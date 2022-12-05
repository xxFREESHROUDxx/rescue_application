import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:rescue_pet/model/Application/Application.dart';
import 'package:rescue_pet/model/Post/postController.dart';
import 'package:rescue_pet/model/User/UserController.dart';

class ApplicationController extends GetxController {
  List allApplication = [].obs;

  List usersApplication = [].obs;

  List pendingApplication = [].obs;

  List receivedApplication = [].obs;

  UserController userController = Get.find();

  getAllApplication() async {
    allApplication.clear();
    await FirebaseFirestore.instance
        .collection('Applications')
        .get()
        .then((value) {
      for (int i = 0; i < value.docs.length; i++) {
        allApplication.add(ApplicationModel(
            value.docs[i].id,
            value.docs[i].get('fullname'),
            value.docs[i].get('effort'),
            value.docs[i].get('desc'),
            value.docs[i].get('person'),
            value.docs[i].get('contact'),
            value.docs[i].get('isApproved'),
            value.docs[i].get('postId'),
            value.docs[i].get('userid'),
            value.docs[i].get('long'),
            value.docs[i].get('lat'),
            value.docs[i].get('location'),
            value.docs[i].get('breed'),
            value.docs[i].get('applicantEffort')));
      }
    });
    getUsersApplication();
  }

  getUsersApplication() async {
    usersApplication.clear();
    for (int i = 0; i < allApplication.length; i++) {
      if (allApplication[i].userId == userController.uid.value) {
        usersApplication.add(ApplicationModel(
            allApplication[i].appId,
            allApplication[i].fullname,
            allApplication[i].effort,
            allApplication[i].desc,
            allApplication[i].person,
            allApplication[i].contact,
            allApplication[i].isApproved,
            allApplication[i].postId,
            allApplication[i].userId,
            allApplication[i].long,
            allApplication[i].lat,
            allApplication[i].location,
            allApplication[i].breed,
            allApplication[i].applicantEffort));
      }
    }
    getPendingApplication();
  }

  getPendingApplication() async {
    pendingApplication.clear();
    for (int i = 0; i < usersApplication.length; i++) {
      if (usersApplication[i].isApproved == false) {
        pendingApplication.add(ApplicationModel(
            usersApplication[i].appId,
            usersApplication[i].fullname,
            usersApplication[i].effort,
            usersApplication[i].desc,
            usersApplication[i].person,
            usersApplication[i].contact,
            usersApplication[i].isApproved,
            usersApplication[i].postId,
            usersApplication[i].userId,
            usersApplication[i].long,
            usersApplication[i].lat,
            usersApplication[i].location,
            usersApplication[i].breed,
            usersApplication[i].applicantEffort));
      }
    }
  }

  getReceivedApp() async {
    receivedApplication.clear();
    PostController postController = Get.find();
    List posts = postController.posts;
    for (int i = 0; i < allApplication.length; i++) {
      for (int j = 0; j < posts.length; j++) {
        if (allApplication[i].postId == posts[j].uid) {
          receivedApplication.add(ApplicationModel(
              allApplication[i].appId,
              allApplication[i].fullname,
              allApplication[i].effort,
              allApplication[i].desc,
              allApplication[i].person,
              allApplication[i].contact,
              allApplication[i].isApproved,
              allApplication[i].postId,
              allApplication[i].userId,
              allApplication[i].long,
              allApplication[i].lat,
              allApplication[i].location,
              allApplication[i].breed,
              allApplication[i].applicantEffort));
        } else {
          continue;
        }
      }
    }
    print('application Len');
    print(receivedApplication.length);
  }
}
