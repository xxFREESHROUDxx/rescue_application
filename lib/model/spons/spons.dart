import 'package:flutter/material.dart';

class Sponsfer extends StatefulWidget {
  const Sponsfer({super.key});

  @override
  State<Sponsfer> createState() => _SponsferState();
}

class _SponsferState extends State<Sponsfer> {
  final formGlobalKey = GlobalKey<FormState>();
  String fullname = '';
  String contact = '';
  String contribution = '';
  String meanspay = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sponser Form')),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Form(
            key: formGlobalKey,
            child: Column(
              children: [
                SizedBox(
                  height: 25,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter full name';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      fullname = value;
                    });
                  },
                  decoration: const InputDecoration(
                      hintText: 'Full Name', label: Text('Full Name')),
                ),
                //

                SizedBox(
                  height: 24,
                ),

                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter your Contact no';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      contact = value;
                    });
                  },
                  decoration: const InputDecoration(
                      hintText: 'Enter your Contact no',
                      label: Text('Contact no')),
                ),
                //

                SizedBox(
                  height: 24,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter your Contribution per month';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      contribution = value;
                    });
                  },
                  decoration: const InputDecoration(
                      hintText: 'Enter your Contribution per month',
                      label: Text('Contribution per month')),
                ),
                SizedBox(
                  height: 24,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter Means of Payment';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      meanspay = value;
                    });
                  },
                  decoration: const InputDecoration(
                      hintText: 'Enter Means of Payment',
                      label: Text('Means of Payment')),
                ),

                //
                //
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            if (formGlobalKey.currentState!.validate()) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Your Date is Submitted')));

              Navigator.pop(context);
            }
          },
          label: const Text(
            'Submit',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
          )),
    );
  }
}
