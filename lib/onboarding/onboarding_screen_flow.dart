import 'package:flutter/material.dart';
import '../screens/login_screen.dart';

class OnboardingScreenFlow extends StatefulWidget {
  const OnboardingScreenFlow({super.key});

  @override
  State<OnboardingScreenFlow> createState() => _OnboardingScreenFlowState();
}

class _OnboardingScreenFlowState extends State<OnboardingScreenFlow> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      'title': 'We serve incomparable delicacies',
      'description': 'All the best restaurants with their top menu waiting for you, they can\'t wait for your order!!',
      'imagePath': "assets/images/onboarding1.png",
    },
    {
      'title': 'Stay Connected',
      'description': 'Connect with friends and family easily.',
      'imagePath': "assets/images/onboarding2.png",
    },
    {
      'title': 'Get Started',
      'description': 'Sign up now to enjoy all the benefits.',
      'imagePath': "assets/images/onboarding3.png",
    },
  ];

  void _onNextPressed() {
    if (_currentPage < _onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      // Navigate to the main app screen or complete the onboarding
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    }
  }

  void _markOnboardingComplete() {
    // Placeholder for onboarding completion logic, e.g., saving to shared preferences
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Full-screen background image
          Positioned.fill(
            child: PageView.builder(
              controller: _pageController,
              itemCount: _onboardingData.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                return Image.asset(
                  _onboardingData[index]['imagePath']!,
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
          // Orange card with content
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9, // 90% of screen width
              height: MediaQuery.of(context).size.height * 0.6, // 60% of screen height
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    _onboardingData[_currentPage]['title']!,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      _onboardingData[_currentPage]['description']!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  // Pagination dots
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _onboardingData.length,
                      (index) => Container(
                        width: 10,
                        height: 10,
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: index == _currentPage ? Colors.white : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  // Buttons inside the card
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          _markOnboardingComplete();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginScreen()),
                          );
                        },
                        child: const Text(
                          "Skip",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: _onNextPressed,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          _currentPage == _onboardingData.length - 1 ? 'Get Started' : 'Next',
                          style: const TextStyle(
                            color: Colors.orange,
                          ),
                        ),
                      ),
                    ],
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