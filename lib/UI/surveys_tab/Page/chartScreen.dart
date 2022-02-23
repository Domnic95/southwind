import 'package:southwind/routes/routes.dart';
import 'package:pie_chart/pie_chart.dart' as chart;
import 'package:southwind/Models/survey/individual_survey.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:southwind/data/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:pie_chart/pie_chart.dart';

class ChartScreen extends StatefulHookWidget {
  ChartScreen({Key? key}) : super(key: key);

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  // List<charts.Series<SurveyNotificationOption, String>> series = [

  //   ];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final res = context.read(surveyNotifierProvider);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Survey result',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.popUntil(context, (route) {
                  return route.settings.name == Routes.splashScreen;
                });
              },
              icon: Icon(Icons.cancel)),
        ],
      ),
      body: SafeArea(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     const SizedBox(),
            //     const Center(
            //         child: Text(
            //       'Survey result',
            //       style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            //     )),
            //     IconButton(
            //         onPressed: () {
            //           Navigator.popUntil(context, (route) {
            //             return route.settings.name == Routes.splashScreen;
            //           });
            //         },
            //         icon: Icon(Icons.cancel)),
            //   ],
            // ),
            Expanded(
              child: MasonryGridView.count(
                  crossAxisCount: 2,
               
                  // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //   childAspectRatio: size.width/size.height,
                  //   mainAxisExtent: size.height,
                  // crossAxisCount: 2),
                  itemCount:
                      res.selectedSurvey!.surveyNotificationQuestion!.length,
                  itemBuilder: (context, index) {
                    Map<String, double> dataMap = {};

                    for (int i = 0;
                        i <
                            res
                                .selectedSurvey!
                                .surveyNotificationQuestion![index]
                                .surveyNotificationOption!
                                .length;
                        i++) {
                      SurveyNotificationOption loc = res
                          .selectedSurvey!
                          .surveyNotificationQuestion![index]
                          .surveyNotificationOption![i];
                      dataMap[loc.optionName!] = loc.answerCount!.toDouble();
                    }

                    return Container(
                      // decoration:
                      //     BoxDecoration(border: Border.all(color: Colors.red)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                   (index + 1).toString() + ". ",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                Expanded(
                                  child: Text(
                                    res
                                        .selectedSurvey!
                                        .surveyNotificationQuestion![index]
                                        .question!,
                                    style: TextStyle(
                                      fontSize: 16,
                                      // fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          chart.PieChart(
                            dataMap: dataMap,
                            // chartRadius: 20,

                            animationDuration: Duration(milliseconds: 800),
                            // chartLegendSpacing: 16,
                            //  colorList: colorList,

                            // chartRadius:  20,
                            // centerText: "HYBRID",
                            legendOptions: LegendOptions(
                              showLegendsInRow: true,
                              legendPosition: LegendPosition.bottom,
                              showLegends: true,
                              // legendShape: _BoxShape.circle,
                              legendTextStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis),
                            ),
                            chartValuesOptions: ChartValuesOptions(
                              showChartValueBackground: true,
                              showChartValues: true,
                              showChartValuesInPercentage: false,
                              showChartValuesOutside: false,
                              decimalPlaces: 0,
                            ),
                          ),
                          // Divider()
                        ],
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
