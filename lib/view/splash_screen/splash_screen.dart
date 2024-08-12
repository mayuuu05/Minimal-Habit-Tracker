import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 4), () {
      Get.toNamed('/intro');
    });

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GradientText(
              'FocusFlow',
              style: GoogleFonts.eduTasBeginner(
                fontSize: width * 0.1,
                fontWeight: FontWeight.bold,
              ),
              gradientType: GradientType.linear,
              gradientDirection: GradientDirection.ttb,
              colors: const [
                Color(0xffe16df5),
                Color(0xff0a0619),
                Color(0xff4ef8e7),
              ],
            ),
            SizedBox(height: height * 0.01),
            GradientText(
              'Stay on Track, Stay in Flow.',
              style: GoogleFonts.eduTasBeginner(
                fontSize: width * 0.05,
                fontWeight: FontWeight.bold,
              ),
              gradientType: GradientType.linear,
              gradientDirection: GradientDirection.ttb,
              colors: const [
                Color(0xff4ef8e7),
                Color(0xff0a0619),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
