import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:wattsup/pages/welcome_page/on_boarding_page.dart';
import 'package:wattsup/utils/theme/colors.dart';
import 'package:wattsup/utils/theme/lottie.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.secondary, // ou ton background défini
      body: SafeArea(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 40), // petit espace top
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Bienvenue sur",
                  style: GoogleFonts.poppins(
                    color:
                        TColors
                            .textWhite, // textWhite ne se voit pas sur fond blanc
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "WattsUp",
                  style: GoogleFonts.lato(
                    color: TColors.orange,
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Lottie.asset(
                  TLottie.anim1,
                  width: 550,
                  height: 500,
                  fit: BoxFit.contain,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OnBoardingPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: TColors.orange,
                        padding: EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Continuer",
                            style: GoogleFonts.poppins(
                              color: TColors.primary,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            Icons.arrow_right_alt,
                            color: TColors.primary,
                            size: 30,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
