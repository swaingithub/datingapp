import 'package:datingapp/pages/landing_page.dart';
import 'package:datingapp/widgets/onboarding_page.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          PageView(
            controller: _controller,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            children: <Widget>[
              const OnboardingPage(
                imageAsset: 'assets/images/match.png',
                title: 'Find Your Match',
                description:
                    'Discover and connect with people who share your interests.',
              ),
              const OnboardingPage(
                imageAsset: 'assets/images/chat.png',
                title: 'Start Chatting',
                description: 'Send messages and get to know each other better.',
              ),
              OnboardingPage(
                imageAsset: 'assets/images/meet.png',
                title: 'Meet in Real Life',
                description: 'Arrange a date and enjoy a great time together!',
                showButton: true,
                onButtonPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LandingPage()));
                  // Navigate to the landing page or next screen
                },
              ),
            ],
          ),

          // Skip Button
          Positioned(
            top: 40,
            right: 20,
            child: TextButton(
              onPressed: () {
                // Skip to the last onboarding page or main content
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        LandingPage(), // Replace with your landing page widget
                  ),
                );
              },
              child: const Text(
                'Skip',
                style: TextStyle(
                  color: Colors.pink,
                  fontSize: 16,
                ),
              ),
            ),
          ),

          // Page Indicator Dots
          Positioned(
            bottom: 60,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) => buildDot(index, context)),
            ),
          ),

          // Forward Button
          if (_currentPage < 2)
            Positioned(
              bottom: 60,
              right: 20,
              child: FloatingActionButton(
                backgroundColor: Colors.pink,
                child: const Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
                onPressed: () {
                  _controller.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
              ),
            ),

          // Backward Button
          if (_currentPage > 0)
            Positioned(
              bottom: 60,
              left: 20,
              child: FloatingActionButton(
                backgroundColor: Colors.pink,
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  _controller.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  // Dot Indicator
  Widget buildDot(int index, BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      height: 12,
      width: _currentPage == index ? 24 : 12,
      decoration: BoxDecoration(
        color: _currentPage == index ? Colors.pink : Colors.grey,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}
