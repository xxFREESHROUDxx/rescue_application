import 'package:flutter/material.dart';
import 'package:rescue_pet/model/Application/Application.dart';

class ApplicationLookup extends StatefulWidget {
  ApplicationModel applicationModel;
  ApplicationLookup(this.applicationModel, {Key? key}) : super(key: key);

  @override
  State<ApplicationLookup> createState() => _ApplicationLookupState();
}

class _ApplicationLookupState extends State<ApplicationLookup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Application Details'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Applicant: ${widget.applicationModel.fullname}',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Text(
                'Breed: ${widget.applicationModel.breed}',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Text(
                'applicant Effort: ${widget.applicationModel.applicantEffort}',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Text(
                'Contact: ${widget.applicationModel.contact}',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Text(
                'Effort: ${widget.applicationModel.effort}',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const Text(
                'Description of Dog: ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Text(widget.applicationModel.desc),
              const Divider(
                height: 5,
                thickness: 3,
                color: Colors.blue,
              ),
              const Text(
                'Description of Applicant: ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Text(widget.applicationModel.person),
              const Divider(
                height: 5,
                thickness: 3,
                color: Colors.blue,
              ),
              Text(
                'Location: ${widget.applicationModel.location}',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              // Text(
              //   'Reason: ${widget.applicationModel.reason}',
              //   style:
              //       const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              // ),
              Text(
                'Longitude: ${widget.applicationModel.long}',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Text(
                'Latitude: ${widget.applicationModel.lat}',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Text(
                'Verified: ${widget.applicationModel.isApproved ? "Approved" : "Not Approved"}',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
