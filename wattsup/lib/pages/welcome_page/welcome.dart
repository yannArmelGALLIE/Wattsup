import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wattsup/pages/welcome_page/screens/on_boarding_screen.dart';
import 'package:wattsup/utils/theme/colors.dart';
import 'package:wattsup/utils/theme/lottie.dart';

class WelcomePage extends StatefulWidget {
  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
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
      animation: TLottie.anim1,
      title: "Bienvenue sur",
      subtitle: "WattsUp",
    ),
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
                    )
                  ),
                  const Spacer(),
                  SizedBox(
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

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    Key? key,
    this.isActive = false,
  }) : super(key: key);

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: 15,
      width: 15,
      decoration: BoxDecoration(
        color: isActive ? TColors.orange : TColors.primary,
        borderRadius: BorderRadius.all(Radius.circular(12))
      ),
    );
  }
}
