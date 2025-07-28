import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Login to your',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
                color: Colors.black,
                fontSize: 26,
              ),
            ),
            Text(
              'account.',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
                color: Colors.black,
                fontSize: 26,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Please sign in to your account',
              style: theme.textTheme.bodySmall?.copyWith(
                color: Colors.grey,
                fontSize: 10,
              ),
            ),
            const SizedBox(height: 18),
            Text(
              'Email Address',
              style: theme.textTheme.labelSmall?.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Password',
              style: theme.textTheme.labelSmall?.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Forgot password?',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: Colors.orange,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(26),
                  ),
                ),
                child: Text(
                  'Sign In',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: Row(
                children: [
                  Expanded(child: Divider(thickness: 0.5, color: Colors.grey)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'Or sign in with',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Expanded(child: Divider(thickness: 0.5, color: Colors.grey)),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/google_my_choice.png',
                  height: 40,
                  width: 40,
                ),
                const SizedBox(width: 10),
                // Image.asset(
                //   'assets/images/facebook.png',
                //   height: 40,
                //   width: 40,
                // ),
              ],
            ),

            const SizedBox(height: 10),
            Center(
              child: TextButton(
                onPressed: () {},
                child: Text.rich(
                  TextSpan(
                    text: "Don't have an account? ",
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                    children: [
                      TextSpan(
                        text: 'Register',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: Colors.orange,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
