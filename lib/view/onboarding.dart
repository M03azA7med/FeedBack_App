import 'package:concentric_transition/page_view.dart';
import 'package:feedback/loginpage.dart';
import 'package:flutter/material.dart';

import '../model/onboarding_contents.dart';

import '../widget/mainPage_widget.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConcentricPageView(

        itemBuilder: (index) {
          final page = contents[index % contents.length];
          return SafeArea(child: MainPageWidget(page: page));
        },
        nextButtonBuilder: (context) => const Icon(
          Icons.arrow_forward,
          color: Colors.black,
        ),

        colors: const [
          Color.fromARGB(255, 200, 200, 200),
          Colors.amber,
          Colors.teal
        ],
      ),
    );
  }
}
