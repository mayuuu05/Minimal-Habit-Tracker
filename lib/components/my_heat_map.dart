import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class MyHeatMap extends StatelessWidget {
  final DateTime startDate;
  final Map<DateTime, int> datasets;

  const MyHeatMap({super.key, required this.startDate, required this.datasets});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return HeatMap(
      startDate: startDate.subtract(Duration(days: 8)),
      endDate: DateTime.now(),
      datasets: datasets,
      defaultColor: Colors.grey.shade500,
      textColor: Colors.white60,
      showColorTip: false,
      showText: true,
      scrollable: true,
      size: width * 0.1,
      fontSize: width * 0.04,
      margin: EdgeInsets.all(width * 0.01),
      colorsets: {
        1: Colors.green.shade600,
        2: Colors.green.shade300,
        3: Colors.green.shade400,
        4: Colors.green.shade500,
        5: Colors.green.shade600,
      },
      borderRadius: 8,

    );
  }
}
