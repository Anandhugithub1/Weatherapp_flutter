import 'package:flutter/material.dart';
import 'package:weatherapp/Weather.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to home screen after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Weather()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // Full-screen splash screen
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: const Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.cloud,
            size: 30,
          ),
          SizedBox(
            height: 30,
            child: Text(
              'Weather app',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      )),
    );
  }
}
