import 'package:flutter/material.dart';
import 'package:moneytracker/chart_class/chart_data.dart';
import 'package:moneytracker/pages/view_expense.dart';
import 'package:moneytracker/globals.dart' as globals;
import 'package:syncfusion_flutter_charts/charts.dart';

import '../bar_graph/bar_graph.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late List<PieChartData> _pieChartData;
  late List<BarChartData> _barChartData;
  late TooltipBehavior _tooltip;
  List<double> monthlySummary = [
    50.0,
    10.0,
    40.0,
    12.0,
    76.0,
    185.0,
    72.0,
    100.0,
    90.0,
    45.0,
    32.0,
    55.0,
  ];

  @override
  void initState() {
    // TODO: implement initState
    _pieChartData = getPieChartData();
    _barChartData = getBarChartData();
    _tooltip = TooltipBehavior(enable: true, duration: 1000);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.fromLTRB(18,18,18,85),
      children: [
        Container(
            height: 150,
            decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                      spreadRadius: -10,
                      blurRadius: 17,
                      offset: Offset(-5, -5),
                      color: Colors.white),
                  BoxShadow(
                      spreadRadius: -2,
                      blurRadius: 10,
                      offset: Offset(7, 7),
                      color: Color.fromRGBO(166, 146, 216, 1.0)),
                ],
                color: Color.fromRGBO(198, 193, 233, 1.0),
                borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Expense",
                        style: TextStyle(
                            fontFamily: "Nunito",
                            fontSize: 20,
                            color: globals.textTheme),
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: Text(
                        "${homeController.currency.value} ${homeController.totalExpense.value}",
                        style: TextStyle(
                            fontFamily: "Nunito",
                            fontSize: 50,
                            color: globals.textTheme),
                      ),
                    ),
                  )
                ],
              ),
            )),
        const SizedBox(
          height: 20,
        ),
        Container(
            height: 300,
            decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                      spreadRadius: -10,
                      blurRadius: 17,
                      offset: Offset(-5, -5),
                      color: Colors.white),
                  BoxShadow(
                      spreadRadius: -2,
                      blurRadius: 10,
                      offset: Offset(7, 7),
                      color: Color.fromRGBO(166, 146, 216, 1.0)),
                ],
                color: Color.fromRGBO(198, 193, 233, 1.0),
                borderRadius: BorderRadius.circular(20)),
            child: SfCircularChart(
              title: ChartTitle(
                text: "Expense Pie Chart (in ${homeController.currency.value})",
                textStyle: TextStyle(
                    fontFamily: "Nunito",
                    fontSize: 17,
                    color: globals.textTheme),
              ),
              legend: Legend(
                  textStyle:
                      TextStyle(fontFamily: "Nunito", color: globals.textTheme),
                  isVisible: true,
                  overflowMode: LegendItemOverflowMode.wrap),
              tooltipBehavior: _tooltip,
              series: <CircularSeries>[
                PieSeries<PieChartData, String>(
                  dataSource: _pieChartData,
                  xValueMapper: (PieChartData data, _) => data.category,
                  yValueMapper: (PieChartData data, _) => data.expense,
                  enableTooltip: true,
                  dataLabelSettings: DataLabelSettings(
                    textStyle: TextStyle(
                      fontFamily: "Nunito",
                    ),
                    isVisible: true,
                  ),
                ),
              ],
            )),
        const SizedBox(
          height: 20,
        ),
        Container(
            height: 300,
            padding: EdgeInsets.only(top: 18,bottom: 18),
            decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                      spreadRadius: -10,
                      blurRadius: 17,
                      offset: Offset(-5, -5),
                      color: Colors.white),
                  BoxShadow(
                      spreadRadius: -2,
                      blurRadius: 10,
                      offset: Offset(7, 7),
                      color: Color.fromRGBO(166, 146, 216, 1.0)),
                ],
                color: Color.fromRGBO(198, 193, 233, 1.0),
                borderRadius: BorderRadius.circular(20)),
            child: MyBarGraph(monthlySummary: monthlySummary,)),
      ],
    );
  }

  List<PieChartData> getPieChartData() {
    final List<PieChartData> chartData = [
      PieChartData(200, "Food"),
      PieChartData(100, "Shopping"),
      PieChartData(500, "Entertainment"),
      PieChartData(800, "Other"),
    ];
    return chartData;
  }

  List<BarChartData> getBarChartData() {
    final List<BarChartData> chartData = [
      BarChartData(100, "Jan"),
      BarChartData(100, "Feb"),
      BarChartData(100, "Mar"),
      BarChartData(100, "Apr"),
      BarChartData(100, "May"),
      BarChartData(100, "Jun"),
      BarChartData(100, "Jul"),
      BarChartData(100, "Aug"),
      BarChartData(100, "Sep"),
      BarChartData(100, "Oct"),
      BarChartData(100, "Nov"),
      BarChartData(100, "Dec"),
    ];
    return chartData;
  }
}
