import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wattsup/utils/models/bar_chart_model.dart';
import 'package:wattsup/utils/theme/colors.dart';

class CustomHistogram extends StatelessWidget {
  const CustomHistogram({
    super.key,
    required this.data,
  });

  final List<BarChartModel> data;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: TColors.secondary, // Pour mieux voir la zone
      child: Column(
        children: [
          const SizedBox(height: 70),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SizedBox(
              height: 400, 
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  barTouchData: BarTouchData(enabled: true),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        interval: 5,
                        getTitlesWidget: (value, _) {
                          return Text(
                            '${value.toInt()}',
                            style: GoogleFonts.poppins(
                                color: TColors.textWhite, fontSize: 15),
                          );
                        },
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, _) {
                          int index = value.toInt();
                          if (index < 0 || index >= data.length) {
                            return const SizedBox();
                          }
                          return Text(
                            data[index].axeY,
                            style: GoogleFonts.poppins(
                                color: TColors.textWhite, fontSize: 15),
                          );
                        },
                        reservedSize: 30,
                      ),
                    ),
                    topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: data
                      .asMap()
                      .map((index, bar) {
                        return MapEntry(
                          index,
                          BarChartGroupData(x: index, barRods: [
                            BarChartRodData(
                              toY: bar.consommation.toDouble(),
                              color: bar.color,
                              width: 20,
                              borderRadius: BorderRadius.circular(4),
                            )
                          ]),
                        );
                      })
                      .values
                      .toList(),
                  gridData: FlGridData(show: false),
                ),
              ),
            ),
          ),
          const Spacer(), // Remplit l'espace restant sans étirer le graphe
        ],
      ),
    );
  }
}
