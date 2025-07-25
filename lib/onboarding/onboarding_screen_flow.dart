import '../screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

class OnboardingScreenFlow extends StatefulWidget {
  const OnboardingScreenFlow({super.key});

  @override
  State<OnboardingScreenFlow> createState() => _OnboardingScreenFlowState();
}


class _OnboardingScreenFlowState extends State<OnboardingScreenFlow> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  bool _isFirstPageLoading = true;
  Timer? _loadingTimer;

  final List<Map<String, String>> _onboardingData = [
    {
      'title': '',
      'description': '',
      'imagePath': "assets/images/snapbit_updated_logo.png",
    },
    {
      'title': 'We serve incomparable delicacies',
      'description':
          'All the best restaurants with their top menu waiting for you, they can\'t wait for your order!!',
      'imagePath': "assets/images/onboarding11.png",
    },
    {
      'title': 'Stay Connected',
      'description': 'Connect with friends and family easily.',
      'imagePath': "assets/images/onboarding4.png",
    },
    {
      'title': 'Get Started',
      'description': 'Sign up now to enjoy all the benefits.',
      'imagePath': "assets/images/onboarding3.png",
    },
  ];

  @override
  void initState() {
    super.initState();
    if (_currentPage == 0) {
      _loadingTimer = Timer(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            _isFirstPageLoading = false;
          });
          // Move to the first onboarding screen after loading
          _pageController.nextPage(
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeIn,
          );
        }
      });
    }
  }

      void _onNextPressed() {
        if (_currentPage < _onboardingData.length - 1) {
          _pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeIn,
          );
          if (_currentPage == 0) {
            setState(() {
              _isFirstPageLoading = true;
            });
            _loadingTimer?.cancel();
            _loadingTimer = Timer(const Duration(seconds: 2), () {
              if (mounted) {
                setState(() {
                  _isFirstPageLoading = false;
                });
              }
            });
          }
        } else {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => const LoginScreen()));
        }
      }

  void _markOnboardingComplete() {
    // Placeholder for onboarding completion logic, e.g., saving to shared preferences
  }

  @override
  void dispose() {
    _loadingTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: PageView.builder(
              controller: _pageController,
              itemCount: _onboardingData.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                  if (_currentPage == 0) {
                    _isFirstPageLoading = true;
                    _loadingTimer?.cancel();
                    _loadingTimer = Timer(const Duration(seconds: 2), () {
                      if (mounted) {
                        setState(() {
                          _isFirstPageLoading = false;
                        });
                      }
                    });
                  } else {
                    _isFirstPageLoading = false;
                  }
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
          if (_currentPage != 0)
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.06,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.6,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFE8C00),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        _onboardingData[_currentPage]['title']!,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
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
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          _onboardingData.length,
                          (index) => Container(
                            width: 15,
                            height: 15,
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: index == _currentPage
                                  ? Colors.white
                                  : Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {
                              _markOnboardingComplete();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                              );
                            },
                            child: Text(
                              "Skip",
                              style: GoogleFonts.openSans(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: _onNextPressed,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  _currentPage == _onboardingData.length - 1
                                      ? 'Get Started'
                                      : 'Next',
                                  style: GoogleFonts.openSans(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          else if (_isFirstPageLoading)
            const Center(child: CircularProgressIndicator())
          else
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.width * 0.5,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: ClipOval(
                  child: Image.asset(
                    _onboardingData[0]['imagePath']!,
                    fit: BoxFit.contain,
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.width * 0.4,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
