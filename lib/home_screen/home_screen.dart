import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:move/tabs/explore/explore_tap.dart';
import 'package:move/utils/app_color.dart';

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
    ExploreTap(),
    UpdateProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColor.black,
      body: tabs[selectedIndex],
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.01, vertical: height * 0.01),
        child: Container(
          decoration: BoxDecoration(
            color: AppColor.silver,
            borderRadius: BorderRadius.circular(16),
          ),
          child: AnimatedBottomNavigationBar(
            icons: [
              Icons.home,
              Icons.search,
              Icons.explore,
              Icons.person,
            ],
            height: height*0.04,
            activeIndex: selectedIndex,
            gapLocation: GapLocation.none,
            notchSmoothness: NotchSmoothness.verySmoothEdge,
            backgroundColor: Colors.transparent,
            activeColor: AppColor.yellow,
            inactiveColor: AppColor.whait,
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
