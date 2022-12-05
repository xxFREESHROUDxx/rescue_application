import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rescue_pet/model/Application/ApplicationController.dart';
import 'package:rescue_pet/module/details/ApplicationDetail/ApplicationDetail.dart';

class RecApplicationScreen extends StatefulWidget {
  const RecApplicationScreen({Key? key}) : super(key: key);

  @override
  State<RecApplicationScreen> createState() => _RecApplicationScreenState();
}

class _RecApplicationScreenState extends State<RecApplicationScreen> {
  ApplicationController applicationController = Get.find();
  bool _isLoading = true;

  getData() async {
    await applicationController.getAllApplication();
    await applicationController.getReceivedApp();
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Received Application'),
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        width: double.infinity,
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: applicationController.receivedApplication.length,
                itemBuilder: (BuildContext context, index) {
                  return applicationController.receivedApplication.isEmpty
                      ? const Card(
                          child: ListTile(
                            leading: Icon(Icons.pets_rounded),
                            title: Text('No applications yet'),
                          ),
                        )
                      : Card(
                          child: ListTile(
                            leading: const Icon(Icons.notes),
                            title: Text(applicationController
                                .receivedApplication[index].person),
                            subtitle: applicationController
                                    .receivedApplication[index].isApproved
                                ? const Text('Status : Verified')
                                : const Text('Not Verified'),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ApplicationDetail(
                                          applicationController
                                              .receivedApplication[index]
                                              .appId)));
                            },
                          ),
                        );
                }),
      ),
    );
  }
}
