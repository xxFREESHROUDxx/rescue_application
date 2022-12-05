import 'package:flutter/material.dart';
import 'package:rescue_pet/widgets/drawer/RescureList/RescueCenterModel.dart';

class RescueCenterDetails extends StatelessWidget {
  int index;
  RescueCenterDetails(this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(rescueCenters[index].name),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(rescueCenters[index].name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
              Image.network(rescueCenters[index].img_url, height: 200, fit: BoxFit.contain,),
              Text('Location ${rescueCenters[index].location}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
              Text('Contact ${rescueCenters[index].contact}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
              const Text('Description', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
              Text(rescueCenters[index].description)
            ],
          ),
        ),
      ),
    );
  }
}
