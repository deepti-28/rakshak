import 'package:flutter/material.dart';

void main() {
  runApp(const RakshakApp());
}

class RakshakApp extends StatelessWidget {
  const RakshakApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static const Color darkGreen = Color(0xFF145A32); // same as "Rakshak"
  static const Color logoBlue = Color(0xFF2052A6);  // sample blue from your logo

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/nature.png',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 48),
                // Logo
                Image.asset(
                  'assets/logo.png',
                  width: 130,
                  height: 130,
                ),
                const SizedBox(height: 24),
                // Welcome texts
                Column(
                  children: const [
                    Text(
                      "Welcome to",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: darkGreen, // Now same dark green
                        shadows: [
                          Shadow(
                            color: Colors.black26,
                            offset: Offset(1, 1),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 6),
                    Text(
                      "Rakshak",
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: darkGreen,
                        shadows: [
                          Shadow(
                            color: Colors.black26,
                            offset: Offset(1, 1),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Tagline in blue
                const Text(
                  "Your Adventure, Our Compass",
                  style: TextStyle(
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                    color: logoBlue, // Blue as in logo
                    shadows: [
                      Shadow(
                        color: Colors.black38,
                        offset: Offset(1, 1),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 18, right: 18, bottom: 60),
                  child: SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF267442),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32),
                        ),
                      ),
                      child: const Text(
                        'Get started',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        ),
                      ),
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
