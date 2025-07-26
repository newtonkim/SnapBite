import 'dart:async';
import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../models/onboarding_data.dart';
import '../screens/login_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingScreenFlow extends StatefulWidget {
  const OnboardingScreenFlow({super.key});

  @override
  State<OnboardingScreenFlow> createState() => _OnboardingScreenFlowState();
}

class _OnboardingScreenFlowState extends State<OnboardingScreenFlow> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _loadingTimer;

  final List<OnboardingData> _onboardingData = [
    OnboardingData(
      title: '',
      description: '',
      imagePath: "assets/images/snapbit_updated_logo.png",
    ),
    OnboardingData(
      title: 'We serve incomparable delicacies',
      description: 'All the best restaurants with their top menu waiting for you to make your order',
      imagePath: "assets/images/delicious-burger-with-fresh-ingredients.jpg",
    ),
    OnboardingData(
      title: 'Stay Connected',
      description: 'Connect with friends and family easily.',
      imagePath: "assets/images/family_time.png",
    ),
    OnboardingData(
      title: 'Get Started',
      description: 'Sign up now to enjoy all the benefits.',
      imagePath: "assets/images/onboarding3.png",
    ),
  ];

  @override
  void initState() {
    super.initState();
    _handleFirstPageLoading();
  }

  void _handleFirstPageLoading() {
    if (_currentPage == 0) {
      _loadingTimer = Timer(AppConstants.loadingDuration, _goToNextPage);
    }
  }

  /// Goes to the next page by animating the page controller to the next page.
  void _goToNextPage() {
    if (!mounted) return;
    int nextPage = _currentPage + 1;
    if (nextPage < _onboardingData.length) {
      _pageController.animateToPage(
        nextPage,
        duration: AppConstants.pageTransitionDuration,
        curve: Curves.easeIn,
      );
      setState(() {
        _currentPage = nextPage;
      });
      if (nextPage == 0) {
        _handleFirstPageLoading();
      } else {
        _loadingTimer?.cancel();
      }
    } else {
      _navigateToLogin();
    }
  }

  void _navigateToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  void _onPageChanged(int index) {
    setState(() => _currentPage = index);
    if (index == 0) {
      _handleFirstPageLoading();
    } else {
      _loadingTimer?.cancel();
    }
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
          _buildPageView(),
          if (_currentPage != 0) _buildOnboardingContent(),
          if (_currentPage == 0) _buildLoadingIndicator(),
        ],
      ),
    );
  }

  Widget _buildPageView() {
    return PageView.builder(
      controller: _pageController,
      itemCount: _onboardingData.length,
      onPageChanged: _onPageChanged,
      itemBuilder: (context, index) {
        return Image.asset(
          _onboardingData[index].imagePath,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => const Center(
            child: Icon(Icons.error_outline, color: Colors.red),
          ),
        );
      },
    );
  }

  Widget _buildTitle(String title) {
    return Text(
      title,
      style: textFont.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildDescription(String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(
        description,
        textAlign: TextAlign.center,
        style: textFont.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.w200,
            ),
      ),
    );
  }

  Widget _buildPageIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _onboardingData.length,
        (index) => Container(
          width: 20,
          height: 15,
          margin: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index == _currentPage ? Colors.white : Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: _navigateToLogin,
          child: Text(
            "Skip",
            style: GoogleFonts.openSans(
              fontSize: 13,
              color: Colors.white,
              fontWeight: FontWeight.w200,
            ),
          ),
        ),
        _buildNextButton(),
      ],
    );
  }

  Widget _buildNextButton() {
    return GestureDetector(
      onTap: _goToNextPage,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _currentPage == _onboardingData.length - 1 ? 'Get Started' : 'Next',
            style: GoogleFonts.openSans(
              fontSize: 13,
              color: Colors.white,
              fontWeight: FontWeight.w200,
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.arrow_forward, color: Colors.white, size: 13),
        ],
      ),
    );
  }

  Widget _buildOnboardingContent() {
    final currentData = _onboardingData[_currentPage];
    final size = MediaQuery.of(context).size;

    return Positioned(
      bottom: size.height * 0.06,
      left: 0,
      right: 0,
      child: Center(
        child: Container(
          width: size.width * 0.65,
          height: size.height * 0.65,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFFFE8C00),
            borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildTitle(currentData.title),
              _buildDescription(currentData.description),
              _buildPageIndicators(),
              _buildNavigationButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    final size = MediaQuery.of(context).size;

    return Center(
      child: Container(
        width: size.width * 0.5,
        height: size.width * 0.5,
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
            _onboardingData[0].imagePath,
            fit: BoxFit.contain,
            width: size.width * 0.4,
            height: size.width * 0.4,
            errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}

