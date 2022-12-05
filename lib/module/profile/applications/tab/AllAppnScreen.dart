import 'package:flutter/material.dart';
import 'package:rescue_pet/model/Application/ApplicationController.dart';
import 'package:rescue_pet/model/Application/application_lookup.dart';

class AllAppScreen extends StatefulWidget {
  const AllAppScreen({Key? key}) : super(key: key);

  @override
  State<AllAppScreen> createState() => _AllAppScreenState();
}

class _AllAppScreenState extends State<AllAppScreen> {
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
                itemCount: applicationController.usersApplication.isNotEmpty
                    ? applicationController.usersApplication.length
                    : 1,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, index) {
                  return applicationController.usersApplication.isEmpty
                      ? const ListTile(
                          leading: Icon(Icons.notes),
                          title: Text('No Applications found'),
                        )
                      : ListTile(
                          leading: const Icon(Icons.notes),
                          title: Text(
                              '${applicationController.usersApplication[index].person}'),
                          subtitle: applicationController
                                  .usersApplication[index].isApproved
                              ? const Text('Status: verified')
                              : const Text('Not Verified'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ApplicationLookup(
                                        applicationController
                                            .usersApplication[index])));
                          },
                        );
                }));
  }
}
