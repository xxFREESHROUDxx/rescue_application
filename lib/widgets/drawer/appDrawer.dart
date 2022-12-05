import 'package:flutter/material.dart';
import 'package:rescue_pet/module/location/LocationScreen.dart';
import 'package:rescue_pet/services/auth.dart';
import 'package:rescue_pet/widgets/drawer/RescureList/RescueList.dart';

class SideAppDrawer extends StatelessWidget {
  const SideAppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();

    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            height: 150,
            width: double.infinity,
            decoration: const BoxDecoration(color: Colors.blueAccent),
            child: const Text(
              'Rescue Dog',
              style: TextStyle(
                  fontSize: 28,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            ),
          ),
          TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const LocationScreen()));
              },
              child: const Text(
                'Locations',
                style: TextStyle(fontSize: 16),
              )),
          TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                        const RescueList()));
              },
              child: const Text(
                'Rescue Centers',
                style: TextStyle(fontSize: 16),
              )),
          TextButton(
              onPressed: () async {
                await _auth.signout();
              },
              child: const Text('Sign Out'))
        ],
      ),
    );
  }
}
