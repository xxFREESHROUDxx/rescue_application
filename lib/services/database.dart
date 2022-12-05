import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:rescue_pet/services/auth.dart';
import '../model/User/UserController.dart';

class DatabaseService {
  final String? uid;

  DatabaseService({required this.uid});

  //for storing the data in varaible
  RxString address = ''.obs;
  RxString contact = ''.obs;
  RxString fullname = ''.obs;
  RxString email = ''.obs;
  RxInt score = 0.obs;

  Location locationObj = Location();
  AuthService authService = AuthService();
  UserController userController = Get.find();

  final CollectionReference userRef =
      FirebaseFirestore.instance.collection('User'); //UserDetails Ref

  Future updateUserData(String fullName, String contact, String address) async {
    return await userRef.doc(uid).set({
      'FullName': fullName,
      'contact': contact,
      'address': address,
    });
  }

  Future getUserDetail() async {
    //setting data
    FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    String? tempEmail = user?.email.toString();
    var result = await userRef.doc(user?.uid).get();
    if (tempEmail != null) {
      email.value = tempEmail;
    } else {
      email.value = 'Couldn"t find email';
    }
    userController.email = email;
    address.value = result.get('address');
    userController.address = address;
    contact.value = result.get('contact');
    userController.contact = contact;
    fullname.value = result.get('FullName');
    userController.fullName = fullname;
    score.value = result.get('score');
    userController.score = score;
  }

  //Post Ref
  final CollectionReference postRef =
      FirebaseFirestore.instance.collection('Posts');
  //Firebase storage instance
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<void> uploadPost(String location, String breed, String reason,
      XFile img, String contact, String dropDownvalue) async {
    try {
      // image upload
      File file = File(img.path);
      var uploadfile = await storage.ref('images/${img.name}').putFile(file);
      //creating post in db
      await postRef.doc().set({
        'attention': dropDownvalue,
        'location': location,
        'breed': breed,
        'reason': reason,
        'contact': contact,
        'postBy': userController.uid.value,
        'imgUrl': await uploadfile.ref.getDownloadURL()
      });
    } catch (e) {
      print(e);
      return null;
    }
  }

  //Application form
  CollectionReference appRef =
      FirebaseFirestore.instance.collection('Applications');
  Future<void> postApplication(
      String postId,
      String breed,
      String reason,
      String effort,
      String fullName,
      String person,
      String contact,
      String location,
      String result) async {
    PermissionStatus permission = await locationObj.hasPermission();
    if (permission == PermissionStatus.granted ||
        permission == PermissionStatus.grantedLimited) {
      var position = await locationObj.getLocation();
      try {
        await appRef.doc().set({
          'postId': postId,
          'breed': breed,
          'desc': reason,
          'effort': effort,
          'fullname': fullName,
          'person': person,
          'contact': contact,
          'location': location,
          'applicantEffort': result,
          'long': position.longitude,
          'lat': position.latitude,
          'userid': userController.uid.value,
          'isApproved': false,
        });
      } catch (e) {
        print(e);
        return;
      }
    }
  }

  //update application form
  // CollectionReference appRefe =
  //     FirebaseFirestore.instance.collection('Applications');
  // Future updateApplication(String applicantEffort) async {
  //   try {
  //     return await appRefe.doc('ICRQ8ect0gjAvaVZoE3O').update({
  //       'applicantEffort': applicantEffort,
  //     });
  //   } catch (e) {
  //     print(e);
  //     print(uid);
  //   }
  // }

  //Post Ref
  final CollectionReference locationRef =
      FirebaseFirestore.instance.collection('Locations');

  Future<void> pushLocation() async {
    Location location = Location();
    PermissionStatus permission = await location.hasPermission();
    if (permission == PermissionStatus.granted ||
        permission == PermissionStatus.grantedLimited) {
      var position = await location.getLocation();
      try {
        await locationRef
            .doc()
            .set({'lat': position.latitude, 'long': position.longitude});
      } catch (e) {
        print(e);
        return;
      }
    }
  }
}
