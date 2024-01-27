import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:vidhaalay_app/widgets/appTheme.dart';

class PieChartSample1 extends StatefulWidget {
  const PieChartSample1({super.key});

  @override
  State<StatefulWidget> createState() => PieChartSample1State();
}

class PieChartSample1State extends State {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 28,
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: <Widget>[
          //     Indicator(
          //       color: AppThemes.contentColorBlue,
          //       text: 'One',
          //       isSquare: false,
          //       size: touchedIndex == 0 ? 18 : 16,
          //       textColor: touchedIndex == 0
          //           ? AppThemes.mainTextColor1
          //           : AppThemes.mainTextColor3,
          //     ),
          //     Indicator(
          //       color: AppThemes.contentColorYellow,
          //       text: 'Two',
          //       isSquare: false,
          //       size: touchedIndex == 1 ? 18 : 16,
          //       textColor: touchedIndex == 1
          //           ? AppThemes.mainTextColor1
          //           : AppThemes.mainTextColor3,
          //     ),
          //     Indicator(
          //       color: AppThemes.contentColorPink,
          //       text: 'Three',
          //       isSquare: false,
          //       size: touchedIndex == 2 ? 18 : 16,
          //       textColor: touchedIndex == 2
          //           ? AppThemes.mainTextColor1
          //           : AppThemes.mainTextColor3,
          //     ),
          //     Indicator(
          //       color: AppThemes.contentColorGreen,
          //       text: 'Four',
          //       isSquare: false,
          //       size: touchedIndex == 3 ? 18 : 16,
          //       textColor: touchedIndex == 3
          //           ? AppThemes.mainTextColor1
          //           : AppThemes.mainTextColor3,
          //     ),
          //   ],
          // ),
          const SizedBox(
            height: 18,
          ),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                  startDegreeOffset: 180,
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 1,
                  centerSpaceRadius: 0,
                  sections: showingSections(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(
      3,
          (i) {
        final isTouched = i == touchedIndex;
        const color0 = AppThemes.textGray;
        const color1 = AppThemes.white;
        const color2 = AppThemes.red;
        // const color3 = AppThemes.white;

        switch (i) {
          case 0:
            return PieChartSectionData(
              color: color0,
              value: 25,
              title: '',
              // radius: 80,
              titlePositionPercentageOffset: 0.55,
              borderSide: isTouched
                  ? const BorderSide(
                  color: AppThemes.white, width: 6)
                  : BorderSide(
                  color: AppThemes.white.withOpacity(0)),
            );
          case 1:
            return PieChartSectionData(
              color: color1,
              value: 25,
              title: '',
              radius: 45,
              titlePositionPercentageOffset: 0.55,
              borderSide: isTouched
                  ? const BorderSide(
                  color: AppThemes.white, width: 6)
                  : BorderSide(
                  color: AppThemes.white.withOpacity(0)),
            );
          case 2:
            return PieChartSectionData(
              color: color2,
              value: 25,
              title: '',
              // radius: 60,
              titlePositionPercentageOffset: 0.6,
              borderSide: isTouched
                  ? const BorderSide(
                  color: AppThemes.white, width: 6)
                  : BorderSide(
                  color: AppThemes.white.withOpacity(0)),
            );
          // case 3:
          //   return PieChartSectionData(
          //     color: color3,
          //     value: 25,
          //     title: '',
          //     radius: 70,
          //     titlePositionPercentageOffset: 0.55,
          //     borderSide: isTouched
          //         ? const BorderSide(
          //         color: AppThemes.white, width: 6)
          //         : BorderSide(
          //         color: AppThemes.white.withOpacity(0)),
          //   );
          default:
            throw Error();
        }
      },
    );
  }
}