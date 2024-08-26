// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:salla_app/network/local/cache_helper.dart';
import 'package:salla_app/modules/user/shopLogin/screen/shop_login_screen.dart';
import 'package:salla_app/core/utils_class.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  // const OnBoardingScreen({super.key});
  var OnBoardingController = PageController();

  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                CacheHelper.saveData(key: 'OnBoardingScreen', value: true)
                    .then((value) {
                  if (value) {
                    // Navigator.pushReplacementNamed(context, 'LoginScreen');
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ShopLoginScreen()));
                  }
                });
              },
              child: const Text(
                'Skip',
                style: TextStyle(color: Styles.primaryColor),
              ))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              onPageChanged: (int index) {
                if (index == Styles.onboardingList.length - 1) {
                  setState(() {
                    isLast = true;
                  });
                  print('Last Page');
                } else {
                  isLast = false;
                  print('not Last Page');
                }
              },
              controller: OnBoardingController,
              physics: const BouncingScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Image.asset(Styles.onboardingList[index].image),
                    Text(
                      Styles.onboardingList[index].title,
                      style: Styles.onboardingTitle,
                    ),
                    Text(
                      Styles.onboardingList[index].body,
                      style: Styles.onboardingSubTitle,
                      textAlign: TextAlign.center,
                    )
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 35),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SmoothPageIndicator(
                  controller: OnBoardingController,
                  count: 3,
                  effect: const ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      dotHeight: 10,
                      expansionFactor: 4,
                      dotWidth: 10,
                      spacing: 5,
                      activeDotColor: Styles.primaryColor),
                ),
                FloatingActionButton(
                  backgroundColor: Styles.primaryColor,
                  onPressed: () {
                    if (isLast) {
                      CacheHelper.saveData(key: 'OnBoardingScreen', value: true)
                          .then((value) {
                        if (value) {
                          // Navigator.pushReplacementNamed(
                          //     context, 'LoginScreen');
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ShopLoginScreen()));
                        }
                      });
                    } else {
                      OnBoardingController.nextPage(
                          duration: const Duration(milliseconds: 750),
                          curve: Curves.easeOutQuint);
                    }
                  },
                  child: const Icon(Icons.arrow_forward_ios_outlined),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
