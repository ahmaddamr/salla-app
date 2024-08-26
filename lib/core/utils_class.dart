import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnBoardingModel {
  final String image;
  final String title;
  final String body;

  OnBoardingModel(
      {required this.image, required this.title, required this.body});
}

class Styles {
  static List<OnBoardingModel> onboardingList = [
    OnBoardingModel(
        image: 'assets/images/1.jpg',
        title: 'Purchase Online',
        body: 'Pick up your order at the collection time \n'
            'on your receipt directly from the shop'),
    OnBoardingModel(
        image: 'assets/images/2.jpg',
        title: 'CHOOSE AND CHECKOUT',
        body: 'Order your mystery made of food A meal\n'
            ' on your plate.A gesture for the planet'),
    OnBoardingModel(
        image: 'assets/images/3.jpg',
        title: 'GET YOUR ORDER',
        body: 'No need to follow up for your own money.\n'
            'We process timely and smooth refunds'),
  ];
  static const TextStyle onboardingTitle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: Color(0xff4443C2),
  );
  static  TextStyle login = GoogleFonts.aBeeZee(
    fontSize: 28,
    color: secondColor
  );
  static  TextStyle onboardingSubTitle = GoogleFonts.actor(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: Colors.blue,
  );
  static const Color primaryColor = Color(0xffF2580B);
  static const Color secondColor = Color(0xff3195F7);

  // static const TextStyle onboardingSubTitle = GoogleFonts.abel()
}
