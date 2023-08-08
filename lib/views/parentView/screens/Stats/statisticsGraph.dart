import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class StatisticsGraph extends StatefulWidget {
  const StatisticsGraph({Key? key, required this.subList}) : super(key: key);
  final List<Map<String, dynamic>> subList;

  @override
  State<StatisticsGraph> createState() => _StatisticsGraphState();
}

class _StatisticsGraphState extends State<StatisticsGraph> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
              show: true,
              drawHorizontalLine: true,
              drawVerticalLine: true,
              horizontalInterval: 10,
              verticalInterval: 1,
              getDrawingHorizontalLine: (value) {
                return FlLine(color: Colors.grey.shade400, strokeWidth: 1);
              },
              getDrawingVerticalLine: (value) {
                return FlLine(color: Colors.grey.shade400, strokeWidth: 1);
              },
              checkToShowHorizontalLine: (value) {
                return value % 10 == 0;
              }
          ),
          titlesData: FlTitlesData(
            topTitles: const AxisTitles(
                sideTitles: SideTitles(
                    showTitles: false
                )
            ),
            rightTitles: const AxisTitles(
                sideTitles: SideTitles(
                    showTitles: false
                )
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                  interval: 1,
                  showTitles: true,
                  getTitlesWidget: (double value, TitleMeta meta) {
                    const style = TextStyle(
                        color: Colors.black,
                        // fontWeight: FontWeight.bold,
                        fontSize: 3
                    );
                    String text = widget.subList[value.toInt()]['sub'];
                    return FittedBox(fit: BoxFit.fitWidth, child: Text(text, style: style, textAlign: TextAlign.center), );
                  }
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                interval: 10,
                showTitles: true,
                getTitlesWidget: (double value, TitleMeta meta) {
                  const style = TextStyle(
                      color: Colors.black,
                      // fontWeight: FontWeight.bold,
                      fontSize: 1
                  );
                  String text = value.toInt().toString();
                  return FittedBox(fit: BoxFit.fitWidth, child: Text(text, style: style, textAlign: TextAlign.center), );
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: true),
          minX: 0,
          maxX: widget.subList.length.toDouble() - 1,
          minY: 0,
          maxY: 110,
          lineBarsData: [
            LineChartBarData(
              spots: List.generate(
                widget.subList.length,
                    (index) => FlSpot(index.toDouble(), widget.subList[index]['marks'].toDouble()),
              ),
              isCurved: true,
              color: const Color(0xFFFF4D01),
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(show: false),
            ),
          ],
        ),
      ),
    );
  }
}
