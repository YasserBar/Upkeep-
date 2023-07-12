import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:upkeep_plus/core/constants/keys.dart';
import '../../../auth/presentation/pages/login_screen.dart';
import '../widgets/onboarding_item.dart';
import '../widgets/onboarding_list.dart';
import '../../../../injection_countainer.dart' as di;

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _pageController;
  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    di.sl<SharedPreferences>().setBool(FIRST_TIME, false);
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: onboardList.length,
                  itemBuilder: (context, index) => OnBoardingItem(
                    img: onboardList[index].img,
                    title: onboardList[index].title,
                    descrebtion: onboardList[index].descrebtion,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Align(
              alignment: const Alignment(0, 0.9),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                        (Route<dynamic> route) => false,
                      );
                    },
                    child: const Text(
                      'دخول',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: 3,
                    effect: const SlideEffect(
                      spacing: 8,
                      dotWidth: 10,
                      dotHeight: 10,
                      activeDotColor: Color(0xFFFFBC00),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _pageController.nextPage(
                          duration: const Duration(milliseconds: 100),
                          curve: Curves.easeIn);
                      if (_pageController.page == 2.0) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
                          (Route<dynamic> route) => false,
                        );
                      }
                    },
                    child: const Text(
                      'تجاوز',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
