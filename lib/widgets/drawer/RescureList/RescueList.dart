import 'package:flutter/material.dart';
import 'package:rescue_pet/widgets/drawer/RescureList/RescueCenterModel.dart';
import 'package:rescue_pet/widgets/drawer/RescureList/rescue_center_detail.dart';

class RescueList extends StatelessWidget {
  const RescueList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rescue Centers'),
      ),
      body: SingleChildScrollView(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: rescueCenters.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(
                    leading: Image.network(rescueCenters[index].img_url),
                    title: Text(rescueCenters[index].name),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  RescueCenterDetails(index)));
                    },
                    subtitle: Container(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Location: ${rescueCenters[index].location}"),
                          Text("Contact: ${rescueCenters[index].contact}"),
                        ],
                      ),
                    ),
                  ),
                );
              })),
    );
  }
}
