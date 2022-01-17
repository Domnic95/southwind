import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:southwind/Models/survey/individual_survey.dart';
import 'package:southwind/UI/components/common_appbar.dart';
import 'package:southwind/UI/components/common_button.dart';
import 'package:southwind/UI/home/career_tab/components/information_dialog.dart';
import 'package:southwind/UI/home/career_tab/page/congratsScreen.dart';
import 'package:southwind/UI/home/career_tab/page/summary_screen.dart';
import 'package:southwind/UI/surveys_tab/Page/summarypage.dart';
import 'package:southwind/UI/theme/apptheme.dart';
import 'package:southwind/routes/routes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:southwind/data/providers/providers.dart';

class Questions_Tab extends StatefulWidget {
  Questions_Tab({
    Key? key,
  }) : super(key: key);

  @override
  _Questions_TabState createState() => _Questions_TabState();
}

class _Questions_TabState extends State<Questions_Tab> {
  int currentQuestion = 0;
  IndividualSurvey? individualSurvey;
  bool loading = true;
  PageController _pageController = PageController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  @override
  animateToQuestion() {
    _pageController.jumpToPage(currentQuestion);
    // _pageController.animateToPage(currentQuestion,
    //     duration: Duration(milliseconds: 400), curve: Curves.linear);
  }

  loadData() async {
    await context.read(surveyNotifierProvider).individualSurvey();
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double radius = 20;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CommonAppbar(),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            // Card(
            //   color: Colors.transparent,
            //   margin: EdgeInsets.all(0),
            //   clipBehavior: Clip.antiAliasWithSaveLayer,
            //   elevation: 10,
            //   shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.only(
            //     bottomLeft: Radius.circular(radius),
            //     bottomRight: Radius.circular(radius),
            //   )),
            //   child: ClipRRect(
            //     borderRadius: BorderRadius.only(
            //       bottomLeft: Radius.circular(radius),
            //       bottomRight: Radius.circular(radius),
            //     ),
            //     child: Container(
            //       width: size.width,
            //       decoration: BoxDecoration(
            //           color: Colors.white,
            //           borderRadius: BorderRadius.only(
            //             bottomLeft: Radius.circular(radius),
            //             bottomRight: Radius.circular(radius),
            //           )),
            //       child: Column(
            //         mainAxisSize: MainAxisSize.min,
            //         children: [
            //           SizedBox(
            //             height: 10,
            //           ),
            //           Padding(
            //             padding: const EdgeInsets.symmetric(horizontal: 18),
            //             child: Text(
            //               "Being Exceptional at Accountabilty",
            //               style: TextStyle(
            //                   color: primarySwatch[700],
            //                   fontWeight: FontWeight.bold,
            //                   fontSize: 16),
            //               maxLines: 2,
            //             ),
            //           ),
            //           SizedBox(
            //             height: 10,
            //           ),
            //           // Container(
            //           //   height: 60,
            //           //   child: QuestionsTab(
            //           //     totalQuestion: Questions.length,
            //           //     currentQuestion: currentQuestion,
            //           //     onTap: (a) {
            //           //       this.currentQuestion = a;
            //           //
            //           //       setState(() {});
            //           //       animateToQuestion();
            //           //     },
            //           //   ),
            //           // ),
            //           SizedBox(
            //             height: 10,
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 20,
            ),
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: primarySwatch.shade300),
                  height: 20,
                ),
                Container(
                  width: currentQuestion / Questions.length * size.width,
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: primarySwatch.shade900),
                  height: 20,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Question : ${currentQuestion + 1} / ${Questions.length}",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: primarySwatch.shade900),
                ),
              ),
            ),
            Expanded(
                child: PageView(
              controller: _pageController,
              children: [
                for (int i = 0; i < Questions.length; i++)
                  QuestionAnswerWidget(
                    i: i,
                  ),
              ],
              onPageChanged: (a) {
                currentQuestion = a;

                setState(() {});
              },
            )),
            // Spacer(),
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
                child: CommonButton(
                  isExpanded: true,
                  lable: "Answer it",
                  isLeading: true,
                  ontap: () {
                    setState(() {
                      if (currentQuestion < Questions.length) {
                        currentQuestion++;
                      }

                      animateToQuestion();
                      if (currentQuestion == Questions.length) {
                        Navigator.pushNamed(context, Routes.question_summary);
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context) {
                        //   return SummaryTab(
                        //     totalquestion: Questions.length,
                        //   );
                        // }));
                      }
                    });
                    // animateToQuestion();
                  },
                ),
                // Row(
                //   children: [
                //     CommonButton(
                //       isExpanded: true,
                //       lable: "Answer it",
                //       isLeading: true,
                //       ontap: () {
                //         if (currentQuestion != 0) currentQuestion++;
                //
                //         setState(() {});
                //         animateToQuestion();
                //       },
                //     ),
                //     // CommonButton(
                //     //   isExpanded: true,
                //     //   lable: "Next",
                //     //   ontap: () {
                //     //     setState(() {
                //     //       currentQuestion++;
                //     //       animateToQuestion();
                //     //     });
                //     //     // animateToQuestion();
                //     //     if (currentQuestion == Questions.length) {
                //     //       Navigator.push(context,
                //     //           MaterialPageRoute(builder: (context) {
                //     //         return SummaryScreen(
                //     //           totalquestion: Questions.length,
                //     //         );
                //     //       }));
                //     //     }
                //     //   },
                //     //   isLeading: false,
                //     //   icon: Padding(
                //     //     padding: const EdgeInsets.only(right: 8),
                //     //     child: Icon(
                //     //       Icons.east,
                //     //       size: 25,
                //     //       color: primarySwatch[900],
                //     //     ),
                //     //   ),
                //     // ),
                //   ],
                // ),
              ),
            ),
            const SizedBox(
              height: 2,
            ),
          ],
        ),
      ),
    );
  }
}

class QuestionAnswerWidget extends StatefulWidget {
  int i;
  QuestionAnswerWidget({Key? key, required this.i}) : super(key: key);

  @override
  State<QuestionAnswerWidget> createState() => _QuestionAnswerWidgetState();
}

class _QuestionAnswerWidgetState extends State<QuestionAnswerWidget> {
  Set selected = {};
  Set selected1 = {};
  int currentindex = -1;
  bool vlaue = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            "${Questions[widget.i]}",
            style: Theme.of(context).textTheme.bodyText1,
            textAlign: TextAlign.left,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Answer :",
            style: TextStyle(fontSize: 14, color: primarySwatch[700]),
          ),
          SizedBox(
            height: 2,
          ),
          if (widget.i == 0 || widget.i == 3)
            TextFormField(
              textInputAction: TextInputAction.done,
              maxLines: 6,
              style: TextStyle(
                fontSize: 16,
              ),
              decoration: InputDecoration(
                  hintText: "Enter Your Answer",
                  hintStyle: TextStyle(color: Colors.grey),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  isCollapsed: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide:
                          BorderSide(width: .5, color: primarySwatch[700]!)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide:
                          BorderSide(width: .5, color: primarySwatch[700]!)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(width: 1, color: primaryColor))),
            ),
          if (widget.i == 1 || widget.i == 4)
            Expanded(
              child: ListView.builder(
                itemCount: Chose.length,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: size.height * 0.005,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selected.contains(index)
                                    ? selected.remove(index)
                                    : selected.add(index);
                                currentindex = index;
                                currentindex = -1;
                              });
                            },
                            onDoubleTap: () {
                              if (selected.contains(index)) {
                                selected.remove(index);
                                print(selected.toString());
                                currentindex = -1;
                                setState(() {});
                              }
                            },
                            child: Card(
                              // elevation: currentindex == index ? 5 : 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: selected.contains(index)
                                          ? primarySwatch.shade900
                                          : Colors.white,
                                      width: 2),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Container(
                                    //   margin: EdgeInsets.only(left: 10),
                                    //   child: Text(
                                    //     "${Chose[index].char}",
                                    //     style: TextStyle(
                                    //       fontWeight: FontWeight.bold,
                                    //       fontSize: 30,
                                    //       color: selected.contains(index)
                                    //           ? primarySwatch.shade900
                                    //           : Colors.grey[700],
                                    //     ),
                                    //   ),
                                    // ),
                                    // SizedBox(
                                    //   width: size.width * 0.00,
                                    // ),
                                    Container(
                                        margin: EdgeInsets.only(left: 15),
                                        child: Text(
                                          "${Chose[index].Opstion}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: selected.contains(index)
                                                ? primarySwatch.shade900
                                                : Colors.grey[700],
                                          ),
                                        )),
                                    Checkbox(
                                      value: selected.contains(index),
                                      onChanged: (val) {
                                        setState(() {
                                          selected.contains(index)
                                              ? selected.remove(index)
                                              : selected.add(index);
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          if (widget.i == 2 || widget.i == 5)
            Expanded(
              child: ListView.builder(
                itemCount: Chose1.length,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: size.height * 0.005,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selected1.contains(index)
                                    ? selected1.remove(index)
                                    : selected1.add(index);
                                currentindex = -1;
                                currentindex = index;
                              });
                            },
                            child: Card(
                              // elevation: currentindex == index ? 5 : 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: currentindex == index
                                          ? primarySwatch.shade900
                                          : Colors.white,
                                      width: 2),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Container(
                                    //   margin: EdgeInsets.only(left: 10),
                                    //   child: Text(
                                    //     "${Chose1[index].char}",
                                    //     style: TextStyle(
                                    //       fontWeight: FontWeight.bold,
                                    //       fontSize: 30,
                                    //       color: selected1.contains(index)
                                    //           ? primarySwatch.shade900
                                    //           : Colors.grey[700],
                                    //     ),
                                    //   ),
                                    // ),
                                    // SizedBox(
                                    //   width: size.width * 0.05,
                                    // ),
                                    Container(
                                      margin: EdgeInsets.only(left: 15),
                                      child: Text(
                                        "${Chose1[index].Opstion}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: currentindex == index
                                              ? primarySwatch.shade900
                                              : Colors.grey[700],
                                        ),
                                      ),
                                    ),
                                    Radio(
                                      groupValue: index,
                                      value: currentindex,
                                      onChanged: (val) {
                                        setState(() {
                                          selected1.contains(index)
                                              ? selected1.remove(index)
                                              : selected1.add(index);
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

class QuestionsTab extends StatelessWidget {
  final int totalQuestion;
  final int currentQuestion;
  final Function(int) onTap;

  const QuestionsTab(
      {required this.totalQuestion,
      required this.currentQuestion,
      required this.onTap,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              onTap(index);
            },
            child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: currentQuestion == index
                      ? primarySwatch[900]
                      : Colors.white,
                  border: Border.all(color: primarySwatch[800]!)),
              height: 40,
              width: 40,
              child: Center(
                  child: Text(
                "${index + 1}",
                style: TextStyle(
                    color: currentQuestion == index
                        ? Colors.white
                        : primarySwatch[900],
                    fontWeight: FontWeight.bold),
              )),
            ),
          ),
        );
      },
      scrollDirection: Axis.horizontal,
      itemCount: totalQuestion,
      padding: EdgeInsets.symmetric(horizontal: 10),
    );
  }
}

List Questions = [
  "What is Accountability?",
  "Why is it important to be fair and consistent when holding people accountable?",
  "How can personal accountability affect the way others perceive you as a leader?",
  "Give me three examples of situation that inaction can discredit your accountability",
  "Give me three examples of situation that inaction can discredit your accountability",
  "Why is it important to address a situation immediately after it occurs rather than later?",
];

class chose {
  String char;
  String Opstion;
  chose({required this.char, required this.Opstion});
}

List<chose> Chose = [
  chose(char: "A", Opstion: "Give me three examples of "),
  chose(char: "B", Opstion: "Give me three examples of "),
  chose(char: "C", Opstion: "Give me three examples of "),
  chose(char: "D", Opstion: "Give me three examples of "),
];

class chose1 {
  int char;
  String Opstion;
  chose1({required this.char, required this.Opstion});
}

List<chose1> Chose1 = [
  chose1(char: 1, Opstion: "Why is it important to address?"),
  chose1(char: 2, Opstion: "Give me three examples of "),
  chose1(char: 3, Opstion: "Why is it important to address?"),
  chose1(char: 4, Opstion: "Give me three examples of "),
];
