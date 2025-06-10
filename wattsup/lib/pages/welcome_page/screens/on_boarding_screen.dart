import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:wattsup/utils/theme/colors.dart';

class onBoardingScreen extends StatelessWidget {
  const onBoardingScreen({
    super.key,
    required this.animation,
    required this.title,
    this.subtitle,
  });

  final String animation, title; 
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Lottie.asset(
          animation,
          width: 400,
          height: 400,
        ),
        Container(
          width: 300,
          child: Text(
            title,
            style: GoogleFonts.poppins(
              color: TColors.textWhite,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.visible,
          ),
        ),
        Text(
          subtitle ?? "",
          style: GoogleFonts.lato(
            color: TColors.orange,
            fontSize: 50,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
