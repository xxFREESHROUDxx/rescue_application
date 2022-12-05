import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:rescue_pet/widgets/carousel/carousel_Item/firstSlideC.dart';
import 'package:rescue_pet/widgets/carousel/carousel_Item/secSlideC.dart';
import 'package:rescue_pet/widgets/carousel/carousel_Item/thirdSlideC.dart';

class CarouselSliderCon extends StatelessWidget {
  const CarouselSliderCon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CarouselController carouselController = CarouselController();
    return CarouselSlider(items:const [
      FirstScreenC(),
      SecScreenC(),
      ThirdScreenC(),
    ], carouselController: carouselController, options:
      CarouselOptions(
        autoPlay: true,
        initialPage: 1
      ),);
  }
}
