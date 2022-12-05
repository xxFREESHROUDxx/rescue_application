import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rescue_pet/module/home/home.dart';
import 'package:rescue_pet/module/post/post.dart';
import 'package:rescue_pet/module/profile/profile.dart';
import 'package:rescue_pet/module/search/searchScreen.dart';
import 'package:rescue_pet/widgets/TopAppBar/TopAppBar.dart';
import 'package:rescue_pet/widgets/drawer/appDrawer.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:location/location.dart';
import '../model/User/UserController.dart';
import '../services/database.dart';


class MainLayout extends StatefulWidget {
  const MainLayout({Key? key}) : super(key: key);

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;
  Location location = Location();
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  UserController userController = Get.find();


  _checkLocationService() async{
    _serviceEnabled = await location.serviceEnabled();
    if(!_serviceEnabled){
      _serviceEnabled = await location.requestService();
    }
    _permissionGranted = await location.hasPermission();
    if(_permissionGranted == PermissionStatus.denied){
      _permissionGranted = await location.requestPermission();
    }
  }

  @override
  void initState(){
    _checkLocationService();
    DatabaseService databaseService = DatabaseService(uid: userController.uid.value);
    databaseService.getUserDetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = const[
      HomeScreen(),
      SearchScreen(),
      PostScreen(),
      ProfileScreen(),
    ];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: TopAppBar('Rescue Dog'),
      ),
      drawer: SideAppDrawer(),
      body: screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(
              5.0,
              5.0,
            ),
            blurRadius: 10.0,
            spreadRadius: 2.0,
          ),
        ]),
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
        child: SalomonBottomBar(
          currentIndex: _currentIndex,
          onTap: (i) {
            setState(() {
              _currentIndex = i;
            });
          },
          items: [
            SalomonBottomBarItem(
                icon: const Icon(Icons.home),
                title: const Text(
                  'Home',
                  style: TextStyle(fontSize: 16),
                )),
            SalomonBottomBarItem(
                icon: const Icon(Icons.search),
                title: const Text(
                  'Search',
                  style: TextStyle(fontSize: 16),
                )),
            SalomonBottomBarItem(
                icon: const Icon(Icons.post_add_rounded),
                title: const Text(
                  'Post',
                  style: TextStyle(fontSize: 16),
                )),
            SalomonBottomBarItem(
                icon: const Icon(Icons.person),
                title: const Text(
                  'Profile',
                  style: TextStyle(fontSize: 16),
                )),
          ],
        ),
      ),
    );
  }
}
