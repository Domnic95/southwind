import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:southwind/Models/career/careerModel.dart';
import 'package:southwind/UI/components/loadingWidget.dart';
import 'package:southwind/UI/home/career_tab/components/career_sub_tabs.dart';
import 'package:southwind/UI/theme/apptheme.dart';
import 'package:southwind/data/providers/providers.dart';
import 'package:southwind/routes/routes.dart';

class CareerTab extends StatelessWidget {
  const CareerTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CareerSubTab(),
        Expanded(child: CareerPath()),
      ],
    );
  }
}

class CareerPath extends StatefulHookWidget {
  CareerPath({Key? key}) : super(key: key);

  @override
  _CareerPathState createState() => _CareerPathState();
}

class _CareerPathState extends State<CareerPath> {
  bool loading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() async {
    await context.read(carerNotifierProvider).getCareerQuestion();
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final careerProvider = useProvider(carerNotifierProvider);
    final size = MediaQuery.of(context).size;
    return loading
        ? LoadingWidget()
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                // SizedBox(
                //   height: 10,
                // ),
                // SizedBox(
                //   height: 10,
                // ),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.only(top: 0, bottom: 60),
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              onTap: () {
                                
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Color(0xFF53ac54),

                                    // color: Color(0xFF25AA25),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Image.asset(
                                        "assets/images/premiumquality.png",
                                        height: 50,
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      SizedBox(
                                        width: .5,
                                        height: 55,
                                        child: Container(
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "21 STEPS LEFT",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Certified Sales Leader",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              Icon(
                                                Icons.arrow_drop_down,
                                                color: Colors.white,
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SingleCollection(
                              careerModel: careerProvider.careerModel,
                              index: index,
                            ),
                          ],
                        );
                      }
                      return SingleCollection(
                        careerModel: careerProvider.careerModel,
                        index: index,
                      );
                    },
                    itemCount: careerProvider.careerModel.careerPath!.length,
                  ),
                )
              ],
            ),
          );
  }
}

class SingleCollection extends StatelessWidget {
  CareerModel careerModel;
  int index;
  SingleCollection({required this.careerModel, required this.index});

  @override
  Widget build(BuildContext context) {
    final double radius = 12;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: () {
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
                  "demo",
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
                  "0 Question",
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
