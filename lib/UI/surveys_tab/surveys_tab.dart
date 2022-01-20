import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:southwind/Models/survey/basic_survey_details.dart';
import 'package:southwind/Models/survey/surveyModel.dart';
import 'package:southwind/UI/components/loadingWidget.dart';
import 'package:southwind/UI/theme/apptheme.dart';
import 'package:southwind/data/providers/providers.dart';
import 'package:southwind/routes/routes.dart';

class Surveys_Tab extends StatefulHookWidget {
  @override
  _Surveys_TabState createState() => _Surveys_TabState();
}

class _Surveys_TabState extends State<Surveys_Tab> {
  bool loading = true;
  @override
  void initState() {
    // TODO: implement initState
    loadData();
  }

  loadData() async {
    await context.read(surveyNotifierProvider).suveryNotification();
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _surveyNotifierProvider = useProvider(surveyNotifierProvider);

    return SafeArea(
      child: Scaffold(
        body: loading
            ? LoadingWidget()
            : Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "Interesting Surveys",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5),
                    ),
                    Text(
                      "${_surveyNotifierProvider.allSurvey.length} Surveys",
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _surveyNotifierProvider.allSurvey.length,
                        padding: const EdgeInsets.only(top: 0, bottom: 60),
                        itemBuilder: (context, index) {
                          // if (index == 0) {
                          //   return Column(
                          //     mainAxisSize: MainAxisSize.min,
                          //     children: [
                          //       Container(
                          //         decoration: BoxDecoration(
                          //             color: Color(0xFF53ac54),
                          //
                          //             // color: Color(0xFF25AA25),
                          //             borderRadius: BorderRadius.circular(10)),
                          //         child: Padding(
                          //           padding: const EdgeInsets.symmetric(vertical: 10),
                          //           child: Row(
                          //             mainAxisAlignment: MainAxisAlignment.start,
                          //             children: [
                          //               SizedBox(
                          //                 width: 20,
                          //               ),
                          //               Image.asset(
                          //                 "assets/images/premiumquality.png",
                          //                 height: 50,
                          //               ),
                          //               SizedBox(
                          //                 width: 20,
                          //               ),
                          //               SizedBox(
                          //                 width: .5,
                          //                 height: 55,
                          //                 child: Container(
                          //                   color: Colors.white,
                          //                 ),
                          //               ),
                          //               SizedBox(
                          //                 width: 10,
                          //               ),
                          //               Column(
                          //                 crossAxisAlignment: CrossAxisAlignment.start,
                          //                 children: [
                          //                   Text(
                          //                     "21 STEPS LEFT",
                          //                     style: TextStyle(
                          //                         fontSize: 18,
                          //                         color: Colors.white,
                          //                         fontWeight: FontWeight.bold),
                          //                     textAlign: TextAlign.center,
                          //                   ),
                          //                   Row(
                          //                     children: [
                          //                       Text(
                          //                         "Certified Sales Leader",
                          //                         style: TextStyle(color: Colors.white),
                          //                       ),
                          //                       Icon(
                          //                         Icons.arrow_drop_down,
                          //                         color: Colors.white,
                          //                       )
                          //                     ],
                          //                   ),
                          //                 ],
                          //               ),
                          //             ],
                          //           ),
                          //         ),
                          //       ),
                          //       SizedBox(
                          //         height: 10,
                          //       ),
                          //       SingleCollection(collections[index]),
                          //     ],
                          //   );
                          // }
                          return SingleCollection(
                              _surveyNotifierProvider.allSurvey[index]);
                        },
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

class SingleCollection extends HookWidget {
  final LibraryNotification collection;

  const SingleCollection(this.collection, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final surveyProvider = context.read(surveyNotifierProvider);
    const double radius = 12;
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: InkWell(
          onTap: () async {
            await surveyProvider.setSurveyId(collection.id!);
            // Navigator.push(context, MaterialPageRoute(builder: (_)=>Questions_Tab()));
            Navigator.pushNamed(context, Routes.question_tab);
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
                  leading: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.pink[200],
                    ),
                    child: const Icon(Icons.settings),
                  ),
                  title: Text(
                    collection.title!.toString(),
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
                    "${collection.questionCount} Question",
                    style: TextStyle(color: primarySwatch[500], fontSize: 12),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
