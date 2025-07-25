import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
    this.titleStyle,
    this.descriptionStyle,
  });

  final String title;
  final String description;
  final String imagePath;
  final TextStyle? titleStyle;
  final TextStyle? descriptionStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(imagePath),
        const SizedBox(height: 20),
        Text(
          title,
          style:
              titleStyle ??
              Theme.of(context).textTheme.labelMedium?.copyWith(
                fontSize: 24, 
                fontWeight: FontWeight.bold, 
              ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style:
                descriptionStyle ??
                const TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
