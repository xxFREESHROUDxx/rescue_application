import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../model/Application/ApplicationController.dart';

class PendingAppScreen extends StatefulWidget {
  const PendingAppScreen({Key? key}) : super(key: key);

  @override
  State<PendingAppScreen> createState() => _PendingAppScreenState();
}

class _PendingAppScreenState extends State<PendingAppScreen> {
  bool _isLoading = true;

  ApplicationController applicationController = ApplicationController();

  getData() async {
    await applicationController.getAllApplication();
    await applicationController.getUsersApplication();

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  deleteApplication(String postId) async {
    await FirebaseFirestore.instance
        .collection('Applications')
        .doc(postId)
        .delete();
    Future.delayed(const Duration(seconds: 1), () {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Deleting your application')));
    });
    getData();
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: applicationController.pendingApplication.isNotEmpty
                    ? applicationController.pendingApplication.length
                    : 1,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, index) {
                  return applicationController.pendingApplication.isEmpty
                      ? const ListTile(
                          leading: Icon(Icons.notes),
                          title: Text('No Applications found'),
                        )
                      : ListTile(
                          leading: const Icon(Icons.notes),
                          title: Text(
                              '${applicationController.pendingApplication[index].person}'),
                          subtitle: applicationController
                                  .pendingApplication[index].isApproved
                              ? const Text('Status: verified')
                              : const Text('Not Verified'),
                          trailing: TextButton(
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                color: Colors.redAccent,
                              ),
                            ),
                            onPressed: () {
                              deleteApplication(applicationController
                                  .pendingApplication[index].appId);
                            },
                          ),
                        );
                }));
  }
}
