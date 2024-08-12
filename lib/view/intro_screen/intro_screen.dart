import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: height * 0.2),
              Image.asset(
                'assets/images/maxresdefault-removebg-preview.png',
                height: 280,
                fit: BoxFit.cover,
              ), SizedBox(height: height * 0.1),
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
              const Text(
                'Small Steps, Big Changes.',
                style: TextStyle(color: Colors.black54, fontSize: 18),
              ),
              SizedBox(height: height * 0.02),
              Container(
                width: width * 0.6,
                height: height * 0.06,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xff4ef8e7),
                      Color(0xff0a0619),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
                  },
                  child: Text(
                    'Get Started',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: width * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.07),
            ],
          ),
        ),
      ),
    );
  }
}
