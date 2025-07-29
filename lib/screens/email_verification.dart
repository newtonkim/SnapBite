import 'package:flutter/material.dart';
class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({super.key}); 

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Email Verification', 
          style: TextStyle(
            color: Colors.black, 
            fontSize: 20, 
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}