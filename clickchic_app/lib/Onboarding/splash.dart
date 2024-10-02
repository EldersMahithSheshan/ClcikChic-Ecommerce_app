import 'package:clickchic_app/Onboarding/onboarding_view.dart';
import 'package:flutter/material.dart';

class splash extends StatefulWidget {
  const splash({super.key});

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(Duration(milliseconds: 2000), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => OnboardingView()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Container(
          child: Image.asset(
              Theme.of(context).brightness == Brightness.dark
                  ? 'assets/darkmode.png'
                  : 'assets/lightmode.png',
              width: 200,
              height: 200),
        ),
      ),
    );
  }
}
