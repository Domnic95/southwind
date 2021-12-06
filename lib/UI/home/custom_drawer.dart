import 'package:flutter/material.dart';
import 'package:southwind/UI/home/home_screen.dart';
import 'package:southwind/UI/home/news_tab/news_screen.dart';
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
  DrawerIndex drawerIndex = DrawerIndex.HOME;
  int currentBottomBarIndex = 0;
  int selectedIndex = 0;
  GlobalKey<SliderMenuContainerState> _key =
      new GlobalKey<SliderMenuContainerState>();
  var type;

  late String title;
  @override
  void initState() {
    title = "Southwind";
    super.initState();
  }
  // Widget screenView = HomeScreen(onindexChange: onindexChange)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      //  appBar: AppBar(
      //   title: Text(
      //     "Southwind".toUpperCase(),
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
          screenView: TimeCardScreen(),
          // screenView: HomeScreen(
          //   onindexChange: (i) {
          //     currentBottomBarIndex = i;
          //     setState(() {});
          //   },
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

  // Widget get ScreenWidget {
  //   switch (drawerIndex) {
  //     case DrawerIndex.HOME:
  //       return HomeScreen(onindexChange: (onindexChange))
  //       break;
  //     case DrawerIndex.YourServices:
  //       // TODO: Handle this case.
  //       break;
  //     case DrawerIndex.Wallet:
  //       // TODO: Handle this case.
  //       break;
  //     case DrawerIndex.Settings:
  //       // TODO: Handle this case.
  //       break;
  //     case DrawerIndex.Help:
  //       // TODO: Handle this case.
  //       break;
  //     case DrawerIndex.Refer:
  //       // TODO: Handle this case.
  //       break;
  //     case DrawerIndex.CardTime:
  //       // TODO: Handle this case.
  //       break;
  //     case DrawerIndex.Account:
  //       // TODO: Handle this case.
  //       break;
  //   }
  // }
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
