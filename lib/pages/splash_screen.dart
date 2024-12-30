import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3 ), () {
      Navigator.pushReplacementNamed(context, '/');
    });

    return Scaffold(
      body:Stack(
        children: [
          Positioned(
            left: 74.w,
            top: 174.h,
            child: Image.asset('assets/images/Checklist-rafiki 1.png'),
          ),
          Positioned(
            left: 53.w,
            top: 411.h,
            child: const Text(
              'What do you want to do today?',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Positioned(
            left: 108.w,
            top: 451.h,
            child: const Text(
              'Tap + to add your tasks',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
