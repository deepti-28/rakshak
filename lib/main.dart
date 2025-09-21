import 'package:flutter/material.dart';

void main() {
  runApp(const RakshakApp());
}

class RakshakApp extends StatelessWidget {
  const RakshakApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F5E9), // Very light green
      body: Stack(
        children: [
          // Environment background images (adjust asset names/positions as needed)
          Positioned(
            top: 60,
            left: 20,
            child: Opacity(
              opacity: 0.2,
              child: Image.asset(
                'assets/tree.png', // Example asset
                width: 70,
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            right: 18,
            child: Opacity(
              opacity: 0.16,
              child: Image.asset(
                'assets/mountains.png', // Example asset
                width: 95,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/logo.png',
                  width: 140,
                  height: 140,
                ),
                const SizedBox(height: 18),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF001F4D), // Navy blue
                    padding: const EdgeInsets.symmetric(horizontal: 44, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    elevation: 4,
                  ),
                  onPressed: () {
                    // Navigation logic here
                  },
                  child: const Text(
                    'Get Started',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
