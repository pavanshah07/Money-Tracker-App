import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:moneytracker/bar_graph/bar_data.dart';
import 'package:moneytracker/globals.dart' as globals;

class MyBarGraph extends StatelessWidget {
  final List<double> monthlySummary;

  const MyBarGraph({super.key, required this.monthlySummary});

  @override
  Widget build(BuildContext context) {
    BarData myBarData = BarData(
        janAmount: monthlySummary[0],
        febAmount: monthlySummary[1],
        marAmount: monthlySummary[2],
        aprAmount: monthlySummary[3],
        mayAmount: monthlySummary[4],
        junAmount: monthlySummary[5],
        julAmount: monthlySummary[6],
        augAmount: monthlySummary[7],
        sepAmount: monthlySummary[8],
        octAmount: monthlySummary[9],
        novAmount: monthlySummary[10],
        decAmount: monthlySummary[11]);
    myBarData.initializeBarData();

    return BarChart(BarChartData(
        maxY: 200,
        minY: 0,
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          show: true,
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true,getTitlesWidget: getBottomTitles)),
        ),
        barGroups: myBarData.barData
            .map((data) => BarChartGroupData(x: data.x, barRods: [
                  BarChartRodData(
                      color: globals.mainTheme,
                      borderRadius: BorderRadius.circular(1),
                      backDrawRodData: BackgroundBarChartRodData(show: true,toY: 200,color: Colors.white12),
                      toY: data.y)
                ]))
            .toList()));
  }

  Widget getBottomTitles(double value,TitleMeta meta){
    final style = TextStyle(
      color: globals.textTheme,
      fontWeight: FontWeight.bold,
      fontFamily: "Nunito"
    );

    Widget text;

    switch(value.toInt()){
      case 0:
        text =  Text('Jan',style: style,);
        break;
      case 1:
        text =  Text('Feb',style: style,);
        break;
      case 2:
        text =  Text('Mar',style: style,);
        break;
      case 3:
        text =  Text('Apr',style: style,);
        break;
      case 4:
        text =  Text('May',style: style,);
        break;
      case 5:
        text =  Text('Jun',style: style,);
        break;
      case 6:
        text =  Text('Jul',style: style,);
        break;
      case 7:
        text =  Text('Aug',style: style,);
        break;
      case 8:
        text =  Text('Sep',style: style,);
        break;
      case 9:
        text =  Text('Oct',style: style,);
        break;
      case 10:
        text =  Text('Nov',style: style,);
        break;
      case 11:
        text =  Text('Dec',style: style,);
        break;
      default:
        text = Text('',style: style,);
        break;
    }
    
    return SideTitleWidget(child: text, axisSide: meta.axisSide);
  }
}
