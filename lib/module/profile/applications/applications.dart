import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rescue_pet/model/Application/ApplicationController.dart';
import 'package:rescue_pet/module/profile/applications/tab/AllAppnScreen.dart';
import 'package:rescue_pet/module/profile/applications/tab/PendAppnScreen.dart';

class ApplicationScreen extends StatefulWidget {
  const ApplicationScreen({Key? key}) : super(key: key);

  @override
  State<ApplicationScreen> createState() => _ApplicationScreenState();
}

class _ApplicationScreenState extends State<ApplicationScreen> {
  ApplicationController applicationController = Get.find();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Applications'),
          bottom: TabBar(
            labelPadding: const EdgeInsets.only(bottom: 10, left: 20),
            tabs: [
              Row(
                children: const [
                  Icon(Icons.notes_rounded),
                  SizedBox(
                    width: 5,
                  ),
                  Text('All Applications')
                ],
              ),
              SingleChildScrollView(
                child: Row(
                  children: [
                    Icon(Icons.notes_rounded),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Text(
                        'Pending Applications',
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            AllAppScreen(),
            PendingAppScreen(),
          ],
        ),
      ),
    );
  }
}
