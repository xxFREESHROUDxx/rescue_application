import 'package:flutter/material.dart';

class SecScreenC extends StatelessWidget {
  const SecScreenC({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      child: Image.asset('assets/images/dogs2.jpeg', height: 300, width: double.infinity,),
    );
  }
}
