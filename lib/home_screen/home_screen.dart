import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:move/tabs/profile/profile_tab.dart';
import 'package:move/utils/app_color.dart';

import '../tabs/browse/browse_tap.dart';
import '../tabs/home/home_tap.dart';
import '../tabs/profile/update_profile/update_profile.dart';
import '../tabs/search/search_tap.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  final List<Widget> tabs = [
    HomeTap(),
    SearchTap(),
    BrowseTap(),
    ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColor.transparentColor,
      body: tabs[selectedIndex],
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(right: width * 0.01,left: width * 0.01,bottom: height * 0.01,top: height * 0.01 ),
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColor.transparentColor
          ),
          child: AnimatedBottomNavigationBar(
            icons: [
              Icons.home,
              Icons.search,
              Icons.explore,
              Icons.person,
            ],
            height: height*0.04,
            iconSize: 35,
            activeIndex: selectedIndex,
            gapLocation: GapLocation.none,
            notchSmoothness: NotchSmoothness.verySmoothEdge,
            backgroundColor: AppColor.silver,
            activeColor: AppColor.yellow,
            splashColor: AppColor.red,
            inactiveColor: AppColor.white,
            onTap: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
