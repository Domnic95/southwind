// ignore_for_file: unused_import

import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:southwind/UI/home/home_screen.dart';
import 'package:southwind/UI/home/news_tab/news_screen.dart';
import 'package:southwind/UI/incentives/incentives.dart';
import 'package:southwind/UI/jobs/components/add_jobScreen.dart';
import 'package:southwind/UI/jobs/jobs_screen.dart';
import 'package:southwind/UI/leader_board/leader_board.dart';
import 'package:southwind/UI/learning/learning_screen.dart';
import 'package:southwind/UI/library/library.dart';
import 'package:southwind/UI/surveys_tab/surveys_tab.dart';
import 'package:southwind/UI/theme/apptheme.dart';
import 'package:southwind/UI/time_card/time_card.dart';
import 'package:southwind/component/bottom_navigation.dart';
import 'package:southwind/component/drawe_controller.dart';
import 'package:southwind/component/menu_widget.dart';
import 'package:southwind/component/navigationtheme.dart';
import 'package:southwind/component/sidemenu.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  Widget screenView = NewsScreen();
  DrawerIndex drawerIndex = DrawerIndex.Home;
  int currentBottomBarIndex = 0;

  // int selectedIndex = 0;
  GlobalKey<SliderMenuContainerState> _key =
      new GlobalKey<SliderMenuContainerState>();
  var type;

  late String title;
  @override
  void initState() {
    title = "Southwind";
    super.initState();
    loadData();
  }

  // Widget screenView = HomeScreen(onindexChange: onindexChange)
  loadData() async {
    String? fcm = await FirebaseMessaging.instance.getToken();
    print("fcmTokenss = ${fcm}");
    RemoteMessage? message =
        await FirebaseMessaging.instance.getInitialMessage();
    //currentBottomBarIndex = 1;
    log('jsonwww' + jsonEncode(message!.data).toString());

    if (message.data['area'] == 'survey') {
      changeIndex(DrawerIndex.Surveys);
      //  currentBottomBarIndex = 1;
    } else if (message.data['area'] == 'communication') {
      changeIndex(DrawerIndex.Home);
    } else if (message.data['area'] == 'schedule') {
      log('1111' + message.contentAvailable.toString());
      log('1111' + message.data.toString());
      log('1111' + message.notification.toString());
      changeIndex(DrawerIndex.Home);

      selectedIndex = 1;
    } else {
      //  widget.onindexChange(2);

    }
    // selectedIndex = 0;
    currentBottomBarIndex = 0;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print('currentBottomBarIndex = ${currentBottomBarIndex}');
    return Scaffold(
      floatingActionButton: drawerIndex == DrawerIndex.Jobs
          ? FloatingActionButton(
              backgroundColor: primarySwatch[700],
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (c) => AddJob()));
              },
              child: Icon(Icons.add),
            )
          : Container(),
      resizeToAvoidBottomInset: true,
      //  appBar: AppBar(
      //   title: Text(
      //     "Southwind".toUpper_Case(),
      //     style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
      //   ),
      //   leading: Icon(Icons.menu),
      //   centerTitle: true,
      // ),
      body: SafeArea(
        child: DrawerUserController(
          currentBottomBarIndex: currentBottomBarIndex,
          screenIndex: drawerIndex,
          drawerWidth: MediaQuery.of(context).size.width * 0.75,
          onDrawerCall: (DrawerIndex drawerIndexdata) {
            changeIndex(drawerIndexdata);
            //callback from drawer for replace screen as user need with passing DrawerIndex(Enum index)
          },
          // screenView: TimeCardScreen(),
          screenView: ScreenWidget,
          // screenView: HomeScreen(
          // onindexChange: (i) {
          //   currentBottomBarIndex = i;
          //   setState(() {});
          // },
          // ),
          drawerIsOpen: (bool) {},
          //we replace screen view as we need on navigate starting screens like MyHomePage, HelpScreen, FeedbackScreen, etc...
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      setState(() {});
    }
  }

  Widget get ScreenWidget {
    switch (drawerIndex) {
      case DrawerIndex.Home:
        return HomeScreen(
          parentIndex: currentBottomBarIndex,
          onindexChange: (i) {
            currentBottomBarIndex = i;
            setState(() {});
          },
          onDrawerIndex: (j) {
            changeIndex(j);
            setState(() {});
          },
        );

      case DrawerIndex.LeaderBoard:
        return LeaderBoard();
      // return HomeScreen(
      //   onindexChange: (i) {
      //     currentBottomBarIndex = i;
      //     setState(() {});
      //   },
      // );

      // case DrawerIndex.Incentives:
      //   return Incentives();
      case DrawerIndex.Library:
        return Library();
        break;
      case DrawerIndex.Surveys:
        return Surveys_Tab();
        break;
      // case DrawerIndex.Challenges:
      //   // TODO: Handle this case.
      //   break;
      // case DrawerIndex.Learning:
      //  return LearningScreen();
      //   // TODO: Handle this case.
      //   break;
      case DrawerIndex.CardTime:
        return TimeCardScreen();
        break;
      case DrawerIndex.Jobs:
        return JobScreen();
        break;

      // break;
      // case DrawerIndex.Goals:
      //   // TODO: Handle this case.
      //   break;
    }
    return HomeScreen(
      onindexChange: (i) {
        currentBottomBarIndex = i;
        setState(() {});
      },
      onDrawerIndex: (j) {
        changeIndex(j);
        setState(() {});
      },
    );
  }
}

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   int selectedIndex = 0;
//   GlobalKey<SliderMenuContainerState> _key =
//       new GlobalKey<SliderMenuContainerState>();
//   var type;

//   late String title;
//   @override
//   void initState() {
//     // TODO: implement initState
//     title = "Southwind";
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       /* appBar: AppBar(
//         title: Text(
//           "Southwind".toUpperCase(),
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
//         ),
//         leading: Icon(Icons.menu),
//         centerTitle: true,
//       ),*/
//       body: SafeArea(
//         child: SliderMenuContainer(
//           appBarColor: Colors.transparent,
//           appBarHeight: 40,
//           key: _key,
//           shadowColor: Colors.grey,
//           sliderMenuOpenSize: 250,
//           // title: Text(
//           //   title.toUpperCase(),
//           //   style: TextStyle(
//           //       color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
//           // ),
//           // isTitleCenter: tr,
//           drawerIcon: Image.asset(
//             'assets/images/navigation.png',
//             height: 30,
//           ),
// title: Container(
//   // color: Colors.teal,
//   height: 30,
//   child: Image.asset("assets/images/southwind_logo.png"),
// ),
//           sliderMenu: MenuWidget(
//             onItemClick: (title) {
//               _key.currentState!.closeDrawer();
//               setState(() {
//                 this.title = title;
//               });
//             },
//           ),
//           sliderMain: NewsScreen(),
//         ),
//       ),
//       bottomNavigationBar: FFNavigationBar(
//         theme: FFNavigationBarTheme(
//           barBackgroundColor: Colors.white,
//           selectedItemBackgroundColor: primarySwatch[50]!,
//           selectedItemIconColor: Colors.black,
//           selectedItemLabelColor: Colors.black,
//         ),
//         selectedIndex: selectedIndex,
//         onSelectTab: (index) {
//           setState(() {
//             selectedIndex = index;
//           });
//         },
//         items: [
//           FFNavigationBarItem(
//             iconData: Icons.feed_outlined,
//             label: 'News',
//           ),
//           FFNavigationBarItem(
//             iconData: Icons.schedule_outlined,
//             label: 'Schedule',
//           ),
//           FFNavigationBarItem(
//             iconData: Icons.school_outlined,
//             label: 'Career',
//           ),
//           FFNavigationBarItem(
//             iconData: Icons.groups_outlined,
//             label: 'Team',
//           ),
//           FFNavigationBarItem(
//             iconData: Icons.account_circle_outlined,
//             label: 'Settings',
//           ),
//         ],
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
