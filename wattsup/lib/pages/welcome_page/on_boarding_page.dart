import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wattsup/pages/authentication/login/login_page.dart';
import 'package:wattsup/pages/welcome_page/screens/dot_indicator.dart';
import 'package:wattsup/pages/welcome_page/screens/on_boarding_screen.dart';
import 'package:wattsup/utils/theme/colors.dart';
import 'package:wattsup/utils/theme/lottie.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  late PageController _pageController;
  int _pageIndex = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final List<onBoardingScreen> onBoardingList = [
    onBoardingScreen(
      animation: TLottie.anim2,
      title: "Suivis et prediction de la consommation d'energie",
    ),
    onBoardingScreen(
      animation: TLottie.anim3,
      title: "Historique de la consommation",
    ),
    onBoardingScreen(
      animation: TLottie.anim4,
      title: "Conseil et amélioration de la consommation d'énergie",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.secondary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: onBoardingList.length,
                  onPageChanged: (index) {
                    setState(() {
                      _pageIndex = index;
                    });
                  },
                  itemBuilder:
                      (context, index) => onBoardingScreen(
                        animation: onBoardingList[index].animation,
                        title: onBoardingList[index].title,
                        subtitle: onBoardingList[index].subtitle,
                      ),
                ),
              ),
              Row(
                children: [
                  ...List.generate(
                    onBoardingList.length,
                    (index) => Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: DotIndicator(isActive: index == _pageIndex),
                    ),
                  ),
                  const Spacer(),
                  _pageIndex == onBoardingList.length - 1
                      ? ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: TColors.orange,
                          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        ),
                        child: Row(
                          children: [
                            Text(
                              "Se connecter",
                              style: GoogleFonts.poppins(
                                color: TColors.textWhite,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      )
                      : SizedBox(
                        height: 40,
                        width: 40,
                        child: ElevatedButton(
                          onPressed: () {
                            _pageController.nextPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.ease,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: TColors.orange,
                            shape: CircleBorder(),
                            padding: EdgeInsets.zero,
                          ),
                          child: Icon(
                            Icons.navigate_next,
                            color: TColors.primary,
                            size: 40,
                          ),
                        ),
                      ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
