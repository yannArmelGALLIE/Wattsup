import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wattsup/pages/bot/bot_page.dart';
import 'package:wattsup/pages/main/screens/circle_progress.dart';
import 'package:wattsup/pages/main/screens/conseil.dart';
import 'package:wattsup/utils/theme/colors.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  static const double maxProgress = 10.0;
  static const double currentValue = 1.3;
  static const double prixUnitaireHT = 73.66;
  static const int redevance = 195;
  static const int taxes = 230;
  static const int taxesRTI = 2000;
  static const int timbre = 100;

  late int montantHT;
  late int montantTVA;
  late int sommeFinal;
  late List<Conseil> conseils = [];
  @override
  void initState() {
    super.initState();
    montantHT = ((currentValue * prixUnitaireHT) + 3015).round();
    montantTVA = (montantHT * 0.18).round();
    sommeFinal = montantHT + montantTVA + redevance + taxes + taxesRTI + timbre;
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000),
    );

    _animation = Tween<double>(
      begin: 0,
      end: (currentValue / maxProgress) * 100,
    ).animate(_animationController)..addListener(() {
      setState(() {});
    });

    _animationController.forward();

    if ((currentValue / maxProgress) < 0.5) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _successMessage(context);
      });
    } else if ((currentValue / maxProgress) >= 0.5 &&
        (currentValue / maxProgress) < 0.9) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _warningMessage(context);
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _errorMessage(context);
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: TColors.secondary,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Bonsoir GALLIE",
                      style: GoogleFonts.poppins(
                        color: TColors.orange,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(() => BotPage());
                      },
                      child: Text(
                        "Chat Bot AI",
                        style: GoogleFonts.poppins(
                          color: TColors.textWhite,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // --- Premier rectangle (Consommation + cercle)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 10,
                ),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: TColors.orange,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Consommation",
                        style: GoogleFonts.poppins(
                          color: TColors.textWhite,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: CustomPaint(
                          foregroundPainter: CircleProgress(_animation.value),
                          child: Container(
                            width: 250,
                            height: 250,
                            child: Center(
                              child: Text(
                                "${currentValue.toStringAsFixed(1)} kW/h",
                                style: GoogleFonts.poppins(
                                  color: TColors.textWhite,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // --- Deuxième rectangle (Infos prix et seuil)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 10,
                ),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: TColors.orange,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Détails",
                        style: GoogleFonts.poppins(
                          color: TColors.textWhite,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Énergie seuil : ${maxProgress.toStringAsFixed(1)} kW/h",
                        style: GoogleFonts.poppins(
                          color: TColors.textWhite,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Montant total à payer : ${sommeFinal.toStringAsFixed(1)} FCFA",
                        style: GoogleFonts.poppins(
                          color: TColors.textWhite,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _successMessage(BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 3),
        content: Container(
          padding: const EdgeInsets.all(8.0),
          height: 90,
          decoration: BoxDecoration(
            color: TColors.success.withOpacity(0.15),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Row(
            children: [
              Icon(Icons.check_circle, color: TColors.success, size: 40),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Vous utilisez efficacement l'électricité. Bon travail !",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        color: TColors.success,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        behavior: SnackBarBehavior.floating,
        elevation: 3,
      ),
    );
  }

  _warningMessage(BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 3),
        content: Container(
          padding: const EdgeInsets.all(8.0),
          height: 90,
          decoration: BoxDecoration(
            color: TColors.warning.withOpacity(0.15),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Row(
            children: [
              Icon(Icons.warning, color: TColors.warning, size: 40),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Votre consommation dépasse les 50% de la limite maximale. Pensez à identifier les appareils énergivores.",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        color: TColors.warning,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        behavior: SnackBarBehavior.floating,
        elevation: 3,
      ),
    );
  }

  _errorMessage(BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 3),
        content: Container(
          padding: const EdgeInsets.all(8.0),
          height: 90,
          decoration: BoxDecoration(
            color: TColors.error.withOpacity(0.15),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Row(
            children: [
              Icon(Icons.cancel, color: TColors.error, size: 40),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Vous êtes proche de votre pic de consommation habituel. Réduisez l'usage des équipements non essentiels.",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        color: TColors.error,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        behavior: SnackBarBehavior.floating,
        elevation: 3,
      ),
    );
  }
}
