import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import '/screens/login_page1.dart'; // Import LoginPage
import '/screens/signup_screen.dart'; // Import SignUpScreen

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Gojek Logo
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/plantguard_logo.png', // Replace with your logo path
                    height: 40,
                  ),
                  // Language Selector
                  ElevatedButton(
                    onPressed: () {
                      // Handle language change
                      print("Change language");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[300],
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.language, size: 16),
                        SizedBox(width: 4),
                        Text("English"),
                      ],
                    ),
                  ),
                ],
              ),

              // Spacer
              SizedBox(height: 80),

              // Illustration
              Image.asset(
                'assets/plantguard_logo.png', // Replace with your illustration path
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),

              // Spacer
              SizedBox(height: 32),

              // Welcome Message
              Text(
                "Welcome to TogetherSO!",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Your go-to app for hassle-free agricultural products.",
                style: TextStyle(fontSize: 16),
              ),

              // Dots Indicator
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green,
                    ),
                  ),
                  Container(
                    width: 8,
                    height: 8,
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    width: 8,
                    height: 8,
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),

              // Log In Button
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  // Navigate to login screen
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  "Log in",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),

              // Sign Up Button
              SizedBox(height: 16),
              OutlinedButton(
                onPressed: () {
                  // Navigate to sign-up screen
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpPage()),
                );
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.green),
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  "I'm new, sign me up",
                  style: TextStyle(color: Colors.green, fontSize: 18),
                ),
              ),

              // Terms and Privacy Policy
              SizedBox(height: 16),
              RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                  children: [
                    TextSpan(text: "By logging in or registering, you agree to our "),
                    TextSpan(
                      text: "Terms of service",
                      style: TextStyle(color: Colors.green),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Open terms of service
                          print("Open Terms of Service");
                        },
                    ),
                    TextSpan(text: " and "),
                    TextSpan(
                      text: "Privacy policy.",
                      style: TextStyle(color: Colors.green),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Open privacy policy
                          print("Open Privacy Policy");
                        },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}