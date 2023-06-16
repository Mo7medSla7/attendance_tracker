import 'package:attendance_tracker/helpers/cache_helper.dart';
import 'package:attendance_tracker/modules/login_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// ignore: must_be_immutable
class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({super.key});

  final pageController = PageController();
  bool isLastPage = false;

  final Map<String, String> images = {
    'scan': 'assets/svg/scan.svg',
    'interactions': 'assets/svg/interactions.svg',
    'material': 'assets/svg/material.svg',
    'manager': 'assets/svg/manager.svg',
  };
  final Map<String, String> titles = {
    'scan': 'Scan for your attendance within the lecture',
    'interactions': 'Interact with other students and instructors',
    'material': 'Get references for lectures and materials',
    'manager': 'Track your attendance and progress',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              goToLogin(context);
            },
            child: const Text(
              'Skip',
              style: TextStyle(fontSize: 18),
            ),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: PageView(
                onPageChanged: (index) {
                  isLastPage = index == 3;
                },
                physics: const BouncingScrollPhysics(),
                controller: pageController,
                children: [
                  buildOnBoardingPage(
                    images['scan']!,
                    titles['scan']!,
                  ),
                  buildOnBoardingPage(
                    images['interactions']!,
                    titles['interactions']!,
                  ),
                  buildOnBoardingPage(
                    images['material']!,
                    titles['material']!,
                  ),
                  buildOnBoardingPage(
                    images['manager']!,
                    titles['manager']!,
                  ),
                ],
              ),
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: pageController,
                  count: 4,
                  effect: const ScrollingDotsEffect(
                    activeDotScale: 1.4,
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    if (isLastPage) {
                      goToLogin(context);
                    } else {
                      pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.linearToEaseOut,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(10.0),
                  ),
                  child: const Icon(
                    Icons.arrow_forward_rounded,
                    size: 28,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildOnBoardingPage(String image, String text) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(
              image,
              height: 250,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      );

  void goToLogin(context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) {
          CacheHelper.putData(key: 'isOnboardingFinished', value: true);
          return const LoginScreen();
        },
      ),
    );
  }
}
