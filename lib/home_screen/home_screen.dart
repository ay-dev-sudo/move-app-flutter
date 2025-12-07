import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move/home_screen/home_screen_cubit/home_screen_view_model.dart';
import 'package:move/tabs/home/home_cubit/home_states.dart';
import 'package:move/tabs/profile/profile_tab.dart';
import 'package:move/utils/app_color.dart';

import '../tabs/browse/browse_tap.dart';
import '../tabs/home/home_tap.dart';
import '../tabs/profile/update_profile/update_profile.dart';
import '../tabs/search/search_tap.dart';
import 'home_screen_cubit/home_screen_states.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

HomeScreenViewModel viewModel=HomeScreenViewModel();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return BlocBuilder<HomeScreenViewModel,HomeScreenStates>(
      bloc: viewModel,
      builder:(context, state) {
        return       Scaffold(
          backgroundColor: AppColor.transparentColor,
          body: viewModel.tabs[viewModel.selectedIndex],
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
                activeIndex: viewModel.selectedIndex,
                gapLocation: GapLocation.none,
                notchSmoothness: NotchSmoothness.verySmoothEdge,
                backgroundColor: AppColor.silver,
                activeColor: AppColor.yellow,
                splashColor: AppColor.red,
                inactiveColor: AppColor.white,
                onTap: (index) {
                  viewModel.changeSelectedIndex(index);
                },
              ),
            ),
          ),
        );

      } ,
    );
  }
}
