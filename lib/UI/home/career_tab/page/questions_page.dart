import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:southwind/UI/components/common_appbar.dart';
import 'package:southwind/UI/components/common_button.dart';
import 'package:southwind/UI/home/career_tab/components/information_dialog.dart';
import 'package:southwind/UI/home/career_tab/page/congratsScreen.dart';
import 'package:southwind/UI/home/career_tab/page/summary_screen.dart';
import 'package:southwind/UI/theme/apptheme.dart';
import 'package:southwind/data/providers/providers.dart';

class QuestionsPage extends StatefulHookWidget {
  const QuestionsPage({Key? key}) : super(key: key);

  @override
  _QuestionsPageState createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  int currentQuestion = 0;
  PageController _pageController = PageController();
  List<int> unAnsweredQuestion = [];
  int questionLength = 0;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      showInformationDialog(context);
      loadData();
    });
  }

  loadData() async {
    final _careerProvider = context.read(carerNotifierProvider);
    setState(() {
      if (_careerProvider.careerModel
          .questions![_careerProvider.selectedCareerPath.id.toString()]!
          .containsKey(_careerProvider.selectedAchievement.id.toString())) {
        questionLength = _careerProvider
            .careerModel
            .questions![_careerProvider.selectedCareerPath.id.toString()]![
                _careerProvider.selectedAchievement.id.toString()]!
            .length;
        for (int i = 0; i < questionLength; i++) {
          unAnsweredQuestion.add(i + 1);
        }
      }
    });
  }

  animateToQuestion() {
    _pageController.jumpToPage(currentQuestion);
    // _pageController.animateToPage(currentQuestion,
    //     duration: Duration(milliseconds: 400), curve: Curves.linear);
  }

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final careerProvider = useProvider(carerNotifierProvider);

    if (careerProvider.careerModel
        .questions![careerProvider.selectedCareerPath.id.toString()]!
        .containsKey(careerProvider.selectedAchievement.id.toString())) {
      questionLength = careerProvider
          .careerModel
          .questions![careerProvider.selectedCareerPath.id.toString()]![
              careerProvider.selectedAchievement.id.toString()]!
          .length;
    }

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
            Card(
              color: Colors.transparent,
              margin: EdgeInsets.all(0),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(radius),
                bottomRight: Radius.circular(radius),
              )),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(radius),
                  bottomRight: Radius.circular(radius),
                ),
                child: Container(
                  width: size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(radius),
                        bottomRight: Radius.circular(radius),
                      )),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Text(
                          "Being Exceptional at Accountabilty",
                          style: TextStyle(
                              color: primarySwatch[700],
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                          maxLines: 2,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 60,
                        child: QuestionsTab(
                          totalQuestion: questionLength,
                          currentQuestion: currentQuestion,
                          onTap: (a) {
                            this.currentQuestion = a;

                            setState(() {});
                            animateToQuestion();
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
                child: PageView(
              controller: _pageController,
              children: [
                for (int i = 0; i < questionLength; i++)
                  QuestionAnswerWidget(
                    onchnage: (c) {
                      controller.text = c;
                      setState(() {});
                    },
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
                child: Row(
                  children: [
                    CommonButton(
                      isExpanded: true,
                      lable: "Previous",
                      isLeading: true,
                      ontap: () {
                        if (currentQuestion != 0) currentQuestion--;

                        setState(() {});
                        animateToQuestion();
                      },
                      icon: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Icon(
                          Icons.west,
                          size: 25,
                          color: primarySwatch[900],
                        ),
                      ),
                    ),
                    CommonButton(
                      isExpanded: true,
                      lable: "Next",
                      ontap: () async {
                        if (controller.text.isNotEmpty) {
                          await careerProvider.updateAnswer(
                              currentQuestion, controller.text);
                          controller.clear();
                          unAnsweredQuestion.remove(currentQuestion + 1);
                        }
                        print(unAnsweredQuestion);
                        setState(() {
                          currentQuestion++;
                          animateToQuestion();
                        });

                        // animateToQuestion();
                        if (currentQuestion == questionLength) {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return SummaryScreen(
                              unAnsweredQuestion: unAnsweredQuestion,
                              totalquestion: questionLength,
                            );
                          }));
                        }
                      },
                      isLeading: false,
                      icon: Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Icon(
                          Icons.east,
                          size: 25,
                          color: primarySwatch[900],
                        ),
                      ),
                    ),
                  ],
                ),
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

class QuestionAnswerWidget extends StatefulHookWidget {
  int i;
  ValueChanged<String> onchnage;
  QuestionAnswerWidget({Key? key, required this.i, required this.onchnage})
      : super(key: key);

  @override
  _QuestionAnswerWidgetState createState() => _QuestionAnswerWidgetState();
}

class _QuestionAnswerWidgetState extends State<QuestionAnswerWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final careerProvider = useProvider(carerNotifierProvider);

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
            careerProvider
                .careerModel
                .questions![careerProvider.selectedCareerPath.id.toString()]![
                    careerProvider.selectedAchievement.id.toString()]![widget.i]
                .question
                .toString(),
            style: Theme.of(context).textTheme.bodyText1,
            textAlign: TextAlign.center,
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
          TextFormField(
            initialValue: careerProvider
                .careerModel
                .questions![careerProvider.selectedCareerPath.id.toString()]![
                    careerProvider.selectedAchievement.id.toString()]![widget.i]
                .answer
                .toString(),
            maxLines: 6,
            onChanged: widget.onchnage,
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
          )
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
