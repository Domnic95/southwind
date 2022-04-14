import 'dart:ui';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:southwind/UI/auth_wrapper.dart';
import 'package:southwind/UI/feedback_screen/feedbackScreen.dart';
import 'package:southwind/UI/home/home_screen.dart';
import 'package:southwind/component/drawe_controller.dart';

import 'package:southwind/data/providers/providers.dart';

class SplashScrren extends StatefulHookWidget {
  SplashScrren({Key? key}) : super(key: key);

  @override
  _SplashScrrenState createState() => _SplashScrrenState();
}

class _SplashScrrenState extends State<SplashScrren> {
  bool nextScreen = false;
  DrawerIndex drawerIndex = DrawerIndex.Home;
  int currentBottomBarIndex = 0;
  int selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    load();
  }

  load() async {
    final res = await FirebaseMessaging.instance.getInitialMessage();
    print("intital messge from notification" + (res?.data).toString());
    // if (res != null) {
    //   if (res.data["career_path_user_achivement_id"] != null) {
    //     print(res.data.toString());
    //     Navigator.push(
    //       context,
    //       MaterialPageRoute(builder: (context) {
    //         return FeedBackScreen(
    //           notificationData: res.data,
    //         );
    //       }),
    //     );
    //   }
    // }
    FirebaseMessaging.onMessage.listen((event) {
      print("Stream for message" + event.data.toString());
    });

    // FirebaseMessaging.onMessageOpenedApp.listen((event) {
    //   print("App opened" + event.data.toString());
    //   if (event.data['area'] == 'survey') {
    //     // changeIndex(DrawerIndex.Surveys);
    //   Navigator.push(
    //       context,
    //       MaterialPageRoute(builder: (context) {
    //         return HomeScreen(onindexChange:(i){
    //           currentBottomBarIndex = 0;
    //         setState(() {});
    //         }, onDrawerIndex: (j){changeIndex(j);
    //         setState(() {});});
    //       }),
    //     );
    // } else if (event.data['area'] == 'communication') {
    //    Navigator.push(
    //       context,
    //       MaterialPageRoute(builder: (context) {
    //         return HomeScreen(onindexChange:(i){
    //           currentBottomBarIndex = 0;
    //         setState(() {});
    //         }, onDrawerIndex: (j){changeIndex(j);
    //         setState(() {});});
    //       }),
    //     );

    // } else if (event.data['area'] == 'schedule') {
    //   Navigator.push(
    //       context,
    //       MaterialPageRoute(builder: (context) {
    //         return HomeScreen(onindexChange:(i){
    //           currentBottomBarIndex = 2;
    //         setState(() {});
    //         }, onDrawerIndex: (j){changeIndex(j);
    //         setState(() {});});
    //       }),
    //     );
    // } else {
    //   //  widget.onindexChange(2);
    // }

    // });
    Future.delayed(
        Duration(
          seconds: 5,
        ), () {
      setState(() {
        nextScreen = true;
      });
    });
  }

  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final authNotifier = useProvider(authProvider);
    final size = MediaQuery.of(context).size;
    return nextScreen
        ? AuthWrapper()
        : Scaffold(
            body: Center(
              child: Image.asset(
                'assets/images/splash.png',
                height: size.height,
                width: size.width,
                fit: BoxFit.cover,
              ),
            ),
          );
  }
}
