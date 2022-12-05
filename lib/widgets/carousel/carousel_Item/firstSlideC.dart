import 'package:flutter/material.dart';

class FirstScreenC extends StatelessWidget {
  const FirstScreenC({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      child: Image.asset('assets/images/adopt1.jpg', height: 300, width: double.infinity,),
    );
  }
}
