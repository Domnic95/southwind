import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/src/provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:southwind/Models/career/careerModel.dart';
import 'package:southwind/Models/learning/learning_notification.dart';
import 'package:southwind/UI/components/loadingWidget.dart';
import 'package:southwind/UI/theme/apptheme.dart';
import 'package:southwind/data/providers/providers.dart';
import 'package:southwind/routes/routes.dart';

class LearningScreen extends StatefulHookWidget {
  LearningScreen({Key? key}) : super(key: key);

  @override
  _LearningScreenState createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  List<String> tabs = ['Learning', 'Submitted', 'Completed'];
  int selectedIndex = 0;
  bool loading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() async {
    await context.read(learningProvider).getLearning();
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final careerProvider = context.read(learningProvider);
    return loading
        ? LoadingWidget()
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  for (int i = 0; i < tabs.length; i++)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 10),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(1000),
                          onTap: () {
                            setState(() {
                              selectedIndex = i;
                            });
                          },
                          child: Material(
                            color: Colors.transparent,
                            elevation: selectedIndex == i ? 10 : 0,
                            borderRadius: BorderRadius.circular(1000),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: selectedIndex == i
                                      ? primarySwatch[700]
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: primarySwatch[900]!, width: .5)),
                              child: Center(
                                  child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                child: Text(
                                  tabs[i],
                                  maxLines: 1,
                                  overflow: TextOverflow.visible,
                                  style: selectedIndex != i
                                      ? TextStyle(
                                          color: primarySwatch[900],
                                          fontWeight: FontWeight.bold)
                                      : TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                ),
                              )),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              Expanded(
                child: LeaningCategories(
                    learnings: careerProvider.learnings, pageIndex: 0),
              )
              // if (selectedIndex == 0)
              //   Expanded(
              //       child: LeaningCategories(
              //     achievement: careerProvider.newAchievement,
              //     pageIndex: selectedIndex,
              //   )),
              // if (selectedIndex == 1)
              //   Expanded(
              //       child: LeaningCategories(
              //     achievement: careerProvider.submittedAchievement,
              //     pageIndex: selectedIndex,
              //   )),
              // if (selectedIndex == 2)
              //   Expanded(
              //       child: LeaningCategories(
              //     achievement: careerProvider.completedAchievement,
              //     pageIndex: selectedIndex,
              //   )),
            ],
          );
  }
}

class LeaningCategories extends StatefulHookWidget {
  List<LearningNotification> learnings;
  int pageIndex;
  LeaningCategories(
      {required this.learnings, required this.pageIndex, Key? key})
      : super(key: key);

  @override
  _LeaningCategoriesState createState() => _LeaningCategoriesState();
}

class _LeaningCategoriesState extends State<LeaningCategories> {
  @override
  Widget build(BuildContext context) {
    // final careerProvider = useProvider(carerNotifierProvider);
    // careerProvider.getAchievementWisely();
    // print('asd' +
    //     careerProvider.careerModel
    //         .careerAchievements![careerProvider.selectedCareerPath.id]!.length
    //         .toString());
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // InkWell(
              //   onTap: () {
              //     showModalBottomSheet(
              //         context: context,
              //         backgroundColor: Colors.transparent,
              //         builder: (context) => Text('Ui is not avalible')
              //         //CareerpathBottomSheet()
              //         );
              //   },
              //   child: Container(
              //     decoration: BoxDecoration(
              //         color: Color(0xFF53ac54),

              //         // color: Color(0xFF25AA25),
              //         borderRadius: BorderRadius.circular(10)),
              //     child: Padding(
              //       padding: const EdgeInsets.symmetric(vertical: 10),
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.start,
              //         children: [
              //           SizedBox(
              //             width: 20,
              //           ),
              //           Image.asset(
              //             "assets/images/premiumquality.png",
              //             height: 50,
              //           ),
              //           SizedBox(
              //             width: 20,
              //           ),
              //           SizedBox(
              //             width: .5,
              //             height: 55,
              //             child: Container(
              //               color: Colors.white,
              //             ),
              //           ),
              //           SizedBox(
              //             width: 10,
              //           ),
              //           Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               if (widget.pageIndex == 0)
              //                 Text(
              //                   "${careerProvider.newAchievement.length} STEPS LEFT",
              //                   style: TextStyle(
              //                       fontSize: 18,
              //                       color: Colors.white,
              //                       fontWeight: FontWeight.bold),
              //                   textAlign: TextAlign.center,
              //                 ),
              //               if (widget.pageIndex == 1)
              //                 Text(
              //                   "${careerProvider.submittedAchievement.length} / ${careerProvider.careerModel.careerAchievements![careerProvider.selectedCareerPath.id.toString()]!.length} Reviewd",
              //                   style: TextStyle(
              //                       fontSize: 18,
              //                       color: Colors.white,
              //                       fontWeight: FontWeight.bold),
              //                   textAlign: TextAlign.center,
              //                 ),
              //               if (widget.pageIndex == 2)
              //                 Text(
              //                   "${careerProvider.completedAchievement.length} / ${careerProvider.careerModel.careerAchievements![careerProvider.selectedCareerPath.id.toString()]!.length} Reviewd",
              //                   style: TextStyle(
              //                       fontSize: 18,
              //                       color: Colors.white,
              //                       fontWeight: FontWeight.bold),
              //                   textAlign: TextAlign.center,
              //                 ),
              //               Row(
              //                 children: [
              //                   Text(
              //                     careerProvider.selectedCareerPath.careerPath!,
              //                     style: TextStyle(color: Colors.white),
              //                   ),
              //                   Icon(
              //                     Icons.arrow_drop_down,
              //                     color: Colors.white,
              //                   )
              //                 ],
              //               ),
              //             ],
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),

              SizedBox(
                height: 10,
              ),
              // SingleCollection(
              //   careerModel: careerProvider.careerModel,
              //   index: index,
              // ),
            ],
          ),
          Expanded(
            child: widget.learnings.length > 0
                ? ListView.builder(
                    padding: EdgeInsets.only(top: 0, bottom: 60),
                    itemBuilder: (context, index) {
                      return LearningSingleCollection(
                        learning: widget.learnings[index],
                        index: index,
                      );
                    },
                    itemCount: widget.learnings.length,
                  )
                : Center(
                    child: Text('No data found'),
                  ),
          )
        ],
      ),
    );
  }
}

class LearningSingleCollection extends HookWidget {
  LearningNotification learning;
  int index;
  LearningSingleCollection({required this.learning, required this.index});

  @override
  Widget build(BuildContext context) {
    int length = 0;
    // final careerProvider = useProvider(carerNotifierProvider);
    // if (careerProvider.careerModel
    //     .questions![careerProvider.selectedCareerPath.id.toString()]!
    //     .containsKey(achievement.id.toString())) {
    //   length = careerProvider
    //       .careerModel
    //       .questions![careerProvider.selectedCareerPath.id.toString()]![
    //           achievement.id.toString()]!
    //       .length;
    // }
    // careerProvider.careerModel.questions![careerProvider.selectedCareerPath.id.toString()]![achievement.id.toString()]!.length
    final double radius = 12;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: () {
          // careerProvider.setAchievement(achievement);
          Navigator.pushNamed(
            context,
            Routes.QuestionPage,
          );
        },
        child: Material(
          elevation: 3,
          borderRadius: BorderRadius.circular(radius),
          child: Container(
            decoration: BoxDecoration(
                // color: primarySwatch[100],
                borderRadius: BorderRadius.circular(radius),
                border: Border.all(color: primaryColor, width: .5)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 0),
              child: ListTile(
                title: Text(
                  learning.title.toString(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    color: primarySwatch[900],
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: primarySwatch[900],
                ),
                subtitle: Text(
                  // careerModel
                  //         .questions![
                  //             careerModel.careerPath![index].id.toString()]!
                  //         .length
                  //         .toString() +
                  " ${length} Question",
                  style: TextStyle(color: primarySwatch[500]),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
