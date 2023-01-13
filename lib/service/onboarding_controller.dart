import 'package:be_fit_app/model/onboarding_info.dart';
import 'package:be_fit_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class OnboardingController extends GetxController {
  var selectedPageIndex = 0.obs;
  bool get isLastPage => selectedPageIndex.value == onboardingPages.length - 1;
  var pageController = PageController();

  forwardAction() {
    if (isLastPage) {
      //go to home page
      
      // Navigator.push(MaterialPageRoute(builder: (_)=>HomePage(email:"") ));
       Get.offAll(() => LoginPage());          
    } else{
      pageController.nextPage(duration: 300.milliseconds, curve: Curves.ease);
    }
  }

  List<OnboardingInfo> onboardingPages = [
    OnboardingInfo('assets/images/yoga-women.png', 'Start your morning with Yoga',
        'A refreshing beginning of the day'),
    OnboardingInfo('assets/images/Fitness-stats-pana.png', 'Track your progress',
        'Grow bit by bit'),
    OnboardingInfo('assets/images/Skipping-rope-amico.png', 'The future of healthy lifestyle',
        'Let\'s begin')
  ];
}
