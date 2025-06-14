import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wattsup/constants/api.dart';
import 'package:wattsup/models/compteur.dart';
import 'package:wattsup/models/mesure.dart';
import 'package:wattsup/models/user.dart';
import 'package:wattsup/pages/bot/bot_page.dart';
import 'package:wattsup/pages/main/screens/circle_progress.dart';
import 'package:wattsup/pages/main/screens/conseil.dart';
import 'package:wattsup/providers/user_provider.dart';
import 'package:wattsup/providers/mesure_provider.dart';
import 'package:wattsup/utils/theme/colors.dart';
import 'package:http/http.dart' as http;

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  static const double maxProgress = 200.0;
  static const double prixUnitaireHT = 73.66;
  static const int redevance = 195;
  static const int taxes = 230;
  static const int taxesRTI = 2000;
  static const int timbre = 100;

  late int montantHT;
  late int montantTVA;
  late int sommeFinal;
  late List<Conseil> conseils = [];

  List<Compteur> myCompteurs = [];
  List<Mesure> myMeasures = [];

  Future<void> fetchUserCompteur(User? user) async {
    try {
      final response = await http.get(Uri.parse("$api/compteurs/"));
      final data = json.decode(response.body);

      myCompteurs =
          (data["results"] as List)
              .where((compteur) => compteur["utilisateur"] == user!.identifiant)
              .map(
                (compteur) => Compteur(
                  identifiant_compteur: compteur["identifiant_compteur"],
                  numero_compteur: compteur["numero_compteur"],
                  exploitation: compteur["exploitation"],
                  reference: compteur["reference"],
                  type_client: compteur["type_client"],
                  utilisateur: compteur["utilisateur"],
                ),
              )
              .toList();

      setState(() {});
    } catch (e) {
      print("Erreur lors du fetch du compteur: $e");
    }
  }

void fetchMeasuresForCompteur(int compteurId) async {
  try {
    final response = await http.get(Uri.parse("$api/mesures/"));
    final data = json.decode(response.body);

    myMeasures = (data["results"] as List)
        .where((mesure) => mesure["compteur"] == compteurId)
        .map(
          (mesure) => Mesure(
            tension: mesure["tension"],
            courant: mesure["courant"],
            puissance: mesure["puissance"],
            timestamp: DateTime.parse(mesure["timestamp"]),
            compteur: mesure["compteur"],
          ),
        )
        .toList();

    if (myMeasures.isNotEmpty) {
      final latestMesure = myMeasures.last;
      Provider.of<MesureProvider>(context, listen: false).setMesure(latestMesure);
    }

    setState(() {});
  } catch (e) {
    print("Erreur lors du fetch des mesures: $e");
  }
}


  int calculPrix(double puissance) {
    montantHT = ((puissance * prixUnitaireHT) + 3015).round();
    montantTVA = (montantHT * 0.18).round();
    sommeFinal = montantHT + montantTVA + redevance + taxes + taxesRTI + timbre;
    return sommeFinal;
  }

  Timer? _timer;

  @override
  void initState() {
    super.initState();

    final currentMesure = myMeasures.isNotEmpty ? myMeasures.last : null;
    final currentValue = currentMesure?.puissance ?? 0.0;

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
  void didChangeDependencies() {
    super.didChangeDependencies();

    final user = Provider.of<UserProvider>(context).user;
    fetchUserCompteur(user).then((_) {
      if (myCompteurs.isNotEmpty) {
        fetchMeasuresForCompteur(myCompteurs.first.identifiant_compteur);
        _timer = Timer.periodic(Duration(seconds: 1), (_) {
          fetchMeasuresForCompteur(myCompteurs.first.identifiant_compteur);
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentMesure = myMeasures.isNotEmpty ? myMeasures.last : null;
    final currentValue = currentMesure?.puissance ?? 0.0;
    final tension = currentMesure?.tension ?? 0.0;
    final courant = currentMesure?.courant ?? 0.0;
    print(currentMesure);
    print(currentValue);

    final sommeFinale = calculPrix(currentValue);

    final user = Provider.of<UserProvider>(context).user;
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
                      "Bonjour ${user!.nom}",
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
                        "WattsUp Bot",
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
                                "${currentValue.toStringAsFixed(1)} kW",
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
                        "Énergie seuil : ${maxProgress.toStringAsFixed(1)} kW",
                        style: GoogleFonts.poppins(
                          color: TColors.textWhite,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Puissance : ${currentValue.toStringAsFixed(1)} kW",
                        style: GoogleFonts.poppins(
                          color: TColors.textWhite,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Tension : ${tension.toStringAsFixed(1)} V",
                        style: GoogleFonts.poppins(
                          color: TColors.textWhite,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Courant : ${courant.toStringAsFixed(1)} A",
                        style: GoogleFonts.poppins(
                          color: TColors.textWhite,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Montant total à payer : ${sommeFinale.toStringAsFixed(1)} FCFA",
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
          height: 100,
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
                        fontSize: 15,
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
        elevation: 10,
      ),
    );
  }

  _warningMessage(BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 3),
        content: Container(
          padding: const EdgeInsets.all(8.0),
          height: 110,
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
                        fontSize: 15,
                        color: TColors.warning,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        behavior: SnackBarBehavior.floating,
        elevation: 10,
      ),
    );
  }

  _errorMessage(BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 3),
        content: Container(
          padding: const EdgeInsets.all(8.0),
          height: 110,
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
                        fontSize: 13,
                        color: TColors.error,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        behavior: SnackBarBehavior.floating,
        elevation: 10,
      ),
    );
  }
}
