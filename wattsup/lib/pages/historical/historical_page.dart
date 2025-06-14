import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wattsup/pages/historical/screens/custom_histogram.dart';
import 'package:wattsup/pages/historical/screens/tab_bar.dart';
import 'package:wattsup/utils/models/bar_chart_model.dart';
import 'package:wattsup/utils/theme/colors.dart';

class HistoricalPage extends StatefulWidget {
  HistoricalPage({super.key});

  @override
  State<HistoricalPage> createState() => _HistoricalPageState();
}

class _HistoricalPageState extends State<HistoricalPage> {
  @override
  Widget build(BuildContext context) {

  final List<BarChartModel> dataMois = [
    BarChartModel(axeY: "Jan", consommation: 25, color: TColors.orange),
    BarChartModel(axeY: "Fév", consommation: 28, color: TColors.orange),
    BarChartModel(axeY: "Mar", consommation: 48, color: TColors.orange),
    BarChartModel(axeY: "Avr", consommation: 34, color: TColors.orange),
    BarChartModel(axeY: "Mai", consommation: 35, color: TColors.orange),
    BarChartModel(axeY: "Juin", consommation: 0, color: TColors.orange),
  ];

  final List<BarChartModel> dataSemaine = [
    BarChartModel(axeY: "Sem1", consommation: 25, color: TColors.orange),
    BarChartModel(axeY: "Sem2", consommation: 0, color: TColors.orange),
    BarChartModel(axeY: "Sem3", consommation: 0, color: TColors.orange),
    BarChartModel(axeY: "Sem4", consommation: 0, color: TColors.orange),
  ];

  final List<BarChartModel> dataJour = [
    BarChartModel(axeY: "Lun", consommation: 25, color: TColors.orange),
    BarChartModel(axeY: "Mar", consommation: 28, color: TColors.orange),
    BarChartModel(axeY: "Mer", consommation: 15, color: TColors.orange),
    BarChartModel(axeY: "Jeu", consommation: 34, color: TColors.orange),
    BarChartModel(axeY: "Ven", consommation: 35, color: TColors.orange),
    BarChartModel(axeY: "Sam", consommation: 0, color: TColors.orange),
    BarChartModel(axeY: "Dim", consommation: 0, color: TColors.orange),
  ];

  final List<BarChartModel> dataHeure = [
    BarChartModel(axeY: "11H", consommation: 25, color: TColors.orange),
    BarChartModel(axeY: "12H", consommation: 28, color: TColors.orange),
    BarChartModel(axeY: "13H", consommation: 15, color: TColors.orange),
    BarChartModel(axeY: "14H", consommation: 34, color: TColors.orange),
    BarChartModel(axeY: "15H", consommation: 35, color: TColors.orange),
    BarChartModel(axeY: "16H", consommation: 19, color: TColors.orange),
  ];
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: TColors.secondary,
        body: NestedScrollView(
          headerSliverBuilder: (_, innerBoxScroolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                floating: true,
                backgroundColor: TColors.secondary,
                expandedHeight: 160,

                flexibleSpace: FlexibleSpaceBar(
                  background: Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Historique",
                              style: GoogleFonts.poppins(
                                color: TColors.orange,
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                "Prévisions",
                                style: GoogleFonts.poppins(
                                  color: TColors.textWhite,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        TTabBar(
                          tabs: [
                            Tab(
                              child: Text(
                                "Mois",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Tab(
                              child: Text(
                                "Semaine",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Tab(
                              child: Text(
                                "Jour",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Tab(
                              child: Text(
                                "Heure",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              CustomHistogram(data: dataMois),
              CustomHistogram(data: dataSemaine),
              CustomHistogram(data: dataJour),
              CustomHistogram(data: dataHeure),
            ],
          ),
        ),
      ),
    );
  }
}
