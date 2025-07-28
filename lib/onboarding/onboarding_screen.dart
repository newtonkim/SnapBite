import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
    this.titleStyle,
    this.descriptionStyle,
    this.imageHeightFactor = 0.4,
    this.spacing = 20.0,
  });

  final String title;
  final String description;
  final String imagePath;
  final TextStyle? titleStyle;
  final TextStyle? descriptionStyle;
  final double imageHeightFactor; // Fraction of screen height for image
  final double spacing; // Vertical spacing between elements

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image with error handling and proper sizing
          _buildImage(context),
          SizedBox(height: spacing),
          // Title with default style fallback
          _buildTitle(context),
          SizedBox(height: spacing / 2),
          // Description with default style fallback
          _buildDescription(context),
          SizedBox(height: spacing),
          // Social login row with CircleAvatar and border
          _buildSocialLoginRow(),
        ],
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return SizedBox(
      height: size.height * imageHeightFactor,
      child: Image.asset(
        imagePath,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 48),
            const SizedBox(height: 8),
            Text('Image not found', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: titleStyle ?? _defaultTitleStyle(context),
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(
        description,
        textAlign: TextAlign.center,
        style: descriptionStyle ?? _defaultDescriptionStyle(context),
      ),
    );
  }

  Widget _buildSocialLoginRow() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 42, // 2 * radius + 2 * borderWidth (20*2 + 1*2)
            height: 42,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey, width: 1.0),
            ),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              child: Image.asset(
                'assets/images/google_my_choice.png',
                height: 40,
                width: 40,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Default title style
  TextStyle _defaultTitleStyle(BuildContext context) {
    return Theme.of(context).textTheme.titleLarge?.copyWith(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ) ??
        const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        );
  }

  // Default description style
  TextStyle _defaultDescriptionStyle(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Colors.grey,
          fontSize: 16,
        ) ??
        const TextStyle(
          fontSize: 16,
          color: Colors.grey,
        );
  }

}
