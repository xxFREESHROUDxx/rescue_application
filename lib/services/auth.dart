import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rescue_pet/model/User/User.dart';
import 'package:rescue_pet/model/User/UserController.dart';
import 'package:rescue_pet/services/database.dart';

class AuthService {
  //firebase auth instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // get x controller
  UserController userController = Get.find();

  setUserData(
      String email, String name, String contact, String address) {
    userController.fullName = name as RxString;
    userController.email = email as RxString;
    userController.contact = contact as RxString;
    userController.address = address as RxString;
   
  }

  //create custom user object
  CustomUser? _userFromFirebaseUser(User? user) {
    return user != null ? CustomUser(uid: user.uid) : null;
  }

  //auth changes
  Stream<CustomUser?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  //sign in with email and password
  Future signInWithEmailandPassword(
      String email, String password, BuildContext context) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      //store uid
      RxString uid = ''.obs;
      uid.value = user!.uid;
      userController.uid = uid;
      //email store
      RxString storeemail = ''.obs;
      storeemail.value = email;
      userController.email = storeemail;
      return _userFromFirebaseUser(user);
    } catch (e) {
      return ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email or Password incorrect')));
    }
  }

  //sign up with email and password
  Future signUpWithEmailandPassword(String email, String password, String name,
      String contact, String address, BuildContext context) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      await DatabaseService(uid: user?.uid)
          .updateUserData(name, contact, address);
      setUserData(email, name, contact, address);
      return _userFromFirebaseUser(user!);
    } catch (e) {
      return ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Email already in used!'),
        behavior: SnackBarBehavior.floating,
      ));
    }
  }

  // signout user
  Future signout() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
