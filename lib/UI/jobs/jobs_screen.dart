import 'package:flutter/material.dart';
import 'package:southwind/UI/jobs/components/add_jobScreen.dart';
import 'package:southwind/UI/theme/apptheme.dart';
import 'package:southwind/routes/routes.dart';

class JobScreen extends StatefulWidget {
  JobScreen({Key? key}) : super(key: key);

  @override
  State<JobScreen> createState() => _JobScreenState();
}

class _JobScreenState extends State<JobScreen> {
  List<String> tabs = ["Today's Jobs", "Past Jobs"];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = 8.0;
    return Container(
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
                        onTap: () async {
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
                                textAlign: TextAlign.center,
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
            // Container(
            //   height: 50,
            //   child: ListView.builder(
            //       scrollDirection: Axis.horizontal,
            //       itemExtent: (size.width - padding) / 2,
            //       itemCount: titleList.length,
            //       itemBuilder: (context, index) {
            //         return Padding(
            //           padding: EdgeInsets.symmetric(horizontal: padding),
            //           child: InkWell(
            //             onTap: () {
            //               setState(() {
            //                 jobIndex = index;
            //               });
            //             },
            //             child: Container(
            //               width: (size.width - padding) / 2,
            //               decoration: BoxDecoration(
            //                   color: jobIndex == index
            //                       ? primarySwatch[700]
            //                       : Colors.transparent,
            //                   border: Border.all(color: primaryColor),
            //                   borderRadius: BorderRadius.circular(10)),
            //               child: Center(
            //                   child: Text(
            //                 titleList[index],
            //                 style: TextStyle(
            //                     color: jobIndex == index
            //                         ? Colors.white
            //                         : primarySwatch[700]),
            //               )),
            //             ),
            //           ),
            //         );
            //       }),
            // ),
          ],
        ),
      ),
    );
  }
}
