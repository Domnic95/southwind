import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:southwind/UI/theme/apptheme.dart';
import 'package:southwind/routes/routes.dart';

class CongratsScreen extends StatelessWidget {
  const CongratsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Color.lerp(Colors.black, primarySwatch[700], .8)!,
        child: SafeArea(
          child: Container(
            child: Stack(
              children: [
                Center(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        color: primarySwatch[100],
                        child: Padding(
                          padding: const EdgeInsets.only(top: 50, bottom: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                "assets/images/trophy.png",
                                height: 140,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: Text(
                                  "Congrats!",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(fontSize: 22),
                                ),
                              ),
                              // Center(
                              //   child: Text(
                              //     "90% Score",
                              //     style: Theme.of(context)
                              //         .textTheme
                              //         .bodyText1!
                              //         .copyWith(
                              //             fontSize: 24,
                              //             fontWeight: FontWeight.w700),
                              //   ),
                              // ),
                              SizedBox(
                                height: 10,
                              ),
                              Center(
                                child: Text(
                                  "Quiz completed sucessfully",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                              // Center(
                              //   child: RichText(
                              //       text: TextSpan(children: [
                              //     TextSpan(
                              //         text: "You attempted ",
                              //         style: Theme.of(context)
                              //             .textTheme
                              //             .bodyText1!
                              //             .copyWith(
                              //               color: Colors.black,
                              //               fontSize: 16,
                              //               fontWeight: FontWeight.normal,
                              //             )),
                              //     TextSpan(
                              //         text: "5 questions",
                              //         style: Theme.of(context)
                              //             .textTheme
                              //             .bodyText1!
                              //             .copyWith(
                              //               color: primarySwatch[900],
                              //               fontWeight: FontWeight.w100,
                              //             ))
                              //   ])),
                              // )
                            ],
                          ),
                        ),
                        // width: 50,
                      ),
                    ),
                  ),
                )),
                Positioned(
                  child: InkWell(
                    onTap: () {
                      Navigator.popUntil(context, (route) {
                      
                        return route.settings.name == Routes.splashScreen;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      child: Icon(
                        Icons.close,
                        size: 28,
                      ),
                    ),
                  ),
                  right: 10,
                  top: 10,
                ),
              ],
            ),
          ),
        ));
  }
}
