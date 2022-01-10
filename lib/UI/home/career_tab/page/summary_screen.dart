import 'package:flutter/material.dart';
import 'package:southwind/UI/components/common_appbar.dart';
import 'package:southwind/UI/components/common_button.dart';
import 'package:southwind/UI/home/career_tab/components/chart.dart';
import 'package:southwind/UI/home/career_tab/page/congratsScreen.dart';
import 'package:southwind/UI/theme/apptheme.dart';
import 'package:southwind/utils/helpers.dart';

class SummaryScreen extends StatelessWidget {
  int totalquestion;
  List<int> unAnsweredQuestion;
  SummaryScreen(
      {Key? key, required this.totalquestion, required this.unAnsweredQuestion})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    int answeredQuestion = totalquestion - unAnsweredQuestion.length;
    final double radius = 20;
    return Scaffold(
      appBar: CommonAppbar(),
      body: WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    child: Row(
                      children: [
                        SingleChart(
                          per: (answeredQuestion * 100 / totalquestion)
                              .round()
                              .toDouble(),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Summary",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontSize: 20),
                            ),
                            Text(
                              "Total Questions : ${totalquestion}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontSize: 14),
                            ),
                            Text(
                              "Answered Questions : ${answeredQuestion}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontSize: 14),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Text(
                data,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: Colors.black),
                textAlign: TextAlign.justify,
              ),
            ),
            Spacer(),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0, -1),
                        blurRadius: 10,
                        spreadRadius: 0)
                  ],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(radius),
                    topRight: Radius.circular(radius),
                  )),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 18),
                child: Row(
                  children: [
                    CommonButton(
                      isExpanded: true,
                      ontap: () {
                        if (unAnsweredQuestion.length == 0) {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return CongratsScreen();
                          }));
                        } else {
                          showToast('Some questions are not answered');
                        }
                      },
                      lable: "Submit",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final data =
    '''You have no view on the whole life cycle of your application, only on the value of a variable at a given time or the assurance or not that your code is following its logical flow. It often happens that console.log are forgotten in several places in the code, which besides a hypothetical loss of performance (tiny, but whose size varies according to the data called through the log method), is not very clean.''';
