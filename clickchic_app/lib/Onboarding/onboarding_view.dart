import 'package:clickchic_app/Screen/loging.dart';
import 'package:flutter/material.dart';
import 'package:clickchic_app/Onboarding/onboarding_items.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final controller = OnboardingItems();
  final pageController = PageController();

  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      bottomSheet: Container(
        color: Theme.of(context).colorScheme.background,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: isLastPage
            ? getStarted()
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //skip button
                  TextButton(
                    onPressed: () =>
                        pageController.jumpToPage(controller.items.length - 1),
                    child: const Text("Skip"),
                  ),

                  //indicator
                  SmoothPageIndicator(
                      controller: pageController,
                      count: controller.items.length,
                      onDotClicked: (index) => pageController.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn),
                      effect: const WormEffect(
                        dotHeight: 12,
                        dotWidth: 12,
                        activeDotColor: Color.fromARGB(255, 1, 93, 50),
                      )),

                  //Next button

                  TextButton(
                    onPressed: () => pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn),
                    child: const Text("Next"),
                  ),
                ],
              ),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: PageView.builder(
              onPageChanged: (index) => setState(
                () => isLastPage = controller.items.length - 1 == index,
              ),
              itemCount: controller.items.length,
              controller: pageController,
              itemBuilder: (context, index) {
                return orientation == Orientation.portrait
                    ? _buildPortraitItem(context, index, isDarkMode)
                    : _buildLandscapeItem(context, index, isDarkMode);
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildPortraitItem(BuildContext context, int index, bool isDarkMode) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          isDarkMode
              ? controller.items[index].imageDark
              : controller.items[index].imageLight,
          height: MediaQuery.of(context).size.height * 0.4,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 20),
        Text(
          controller.items[index].title,
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            controller.items[index].description,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.grey, fontSize: 18),
          ),
        ),
      ],
    );
  }

  Widget _buildLandscapeItem(BuildContext context, int index, bool isDarkMode) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Image.asset(
            isDarkMode
                ? controller.items[index].imageDark
                : controller.items[index].imageLight,
            height: MediaQuery.of(context).size.height * 0.5,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                controller.items[index].title,
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  controller.items[index].description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.grey, fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget getStarted() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(10),
      ),
      width: MediaQuery.of(context).size.width * .9,
      height: 50,
      child: TextButton(
        onPressed: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const LoginScreen()));
        },
        child: const Text(
          "Get Started",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
