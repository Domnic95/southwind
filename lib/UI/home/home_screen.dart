import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:southwind/UI/home/career_tab/career_tab.dart';
import 'package:southwind/UI/home/chat_tab/all_chat_list.dart';
import 'package:southwind/UI/home/clock_in_out/clock_in_out.dart';
import 'package:southwind/UI/home/clock_in_out/work_history.dart';
import 'package:southwind/UI/home/news_tab/news_screen.dart';
import 'package:southwind/UI/home/schedule_tab/schedule.dart';
import 'package:southwind/UI/profile/profile_tab.dart';
import 'package:southwind/UI/theme/apptheme.dart';
import 'package:southwind/component/bottom_navigation.dart';
import 'package:southwind/component/drawe_controller.dart';
import 'package:southwind/component/navigationtheme.dart';

class HomeScreen extends StatefulWidget {
  final Function(int) onindexChange;
  final Function(DrawerIndex) onDrawerIndex;
  int? parentIndex;
  HomeScreen(
      {required this.onindexChange,
      required this.onDrawerIndex,
      this.parentIndex = 0,
      Key? key})
      : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}
late int selectedIndex;
class _HomeScreenState extends State<HomeScreen> {
  
  @override
  void initState() {
    super.initState();
    selectedIndex = widget.parentIndex!;
    notification();
  }

  notification() async {
    String? token = await FirebaseMessaging.instance.getToken();

    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   RemoteNotification? notification = message.notificati
    //   AndroidNotification? android = message.notification?.android;
    //   log('A new onMessageOpenedApp = ${message.data}');
    // });

    

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log('areaa' + message.data.toString());
      if (message.data['area'] == 'survey') {
        log('survey' + message.data.toString());
        widget.onDrawerIndex(DrawerIndex.Surveys);
      } else if (message.data['area'] == 'communication') {
        widget.onDrawerIndex(DrawerIndex.Home);
        widget.onindexChange(0);
        selectedIndex = 0;
      } else if (message.data['area'] == 'schedule') {
        widget.onDrawerIndex(DrawerIndex.Home);
        widget.onindexChange(1);
        selectedIndex = 1;
      } else {
        //  widget.onindexChange(2);
      }
    });



    // FirebaseMessaging.onBackgroundMessage((message) async {
    //   log('A new onMessageOpenedApp = ${message.data}');
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 60),
            child: getBody,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: FFNavigationBar(
              theme: FFNavigationBarTheme(
                barBackgroundColor: Colors.white,
                selectedItemBackgroundColor: primarySwatch[200]!,
                selectedItemIconColor: Colors.black,
                selectedItemLabelColor: Colors.black,
              ),
              selectedIndex: selectedIndex,
              onSelectTab: (index) {
                setState(() {
                  selectedIndex = index;
                });
                widget.onindexChange(index);
              },
              items: [
                FFNavigationBarItem(
                  iconData: Icons.feed_outlined,
                  label: 'News',
                ),
                FFNavigationBarItem(
                  iconData: Icons.schedule_outlined,
                  label: 'Schedule',
                ),
                FFNavigationBarItem(
                  iconData: Icons.school_outlined,
                  label: 'Career',
                ),
                FFNavigationBarItem(
                  iconData: Icons.groups_outlined,
                  label: 'Team',
                ),
                FFNavigationBarItem(
                  iconData: Icons.account_circle_outlined,
                  label: 'Settings',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget get getBody {
    switch (selectedIndex) {
      case 0:
        return NewsScreen();
      case 1:
        return Schedule();
      case 2:
        return CareerTab();
      case 3:
        return AllChatList();
      case 4:
        return Profile();
    }
    return Container();
  }
}
