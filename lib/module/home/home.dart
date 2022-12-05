import 'package:flutter/material.dart';
import 'package:rescue_pet/module/home/component/awaiting.dart';
import 'package:rescue_pet/widgets/carousel/carouselContainer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 5,
              ),
              Row(
                children: const [
                  Text(
                    "Don't shop, ",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    "Adopt!",
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Colors.blueAccent),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              const Divider(
                height: 5,
                color: Colors.black38,
              ),
              const SizedBox(
                height: 5,
              ),
              const CarouselSliderCon(),
              const SizedBox(
                height: 5,
              ),
              const Divider(
                height: 9,
                color: Colors.black54,
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(5),
                child: const Text(
                  "Awaiting your adoption!",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.blueAccent),
                  textAlign: TextAlign.center,
                ),
              ),
              const Divider(
                height: 5,
                color: Colors.black54,
              ),
              const SizedBox(
                height: 5,
              ),
              Awaiting()
            ],
          ),
        ),
      ),
    );
  }
}
