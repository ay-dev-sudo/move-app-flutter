import 'package:flutter/material.dart';
import 'package:move/tabs/explore/explore_tap.dart';
import 'package:move/utils/app_color.dart';


import '../tabs/home/home_tap.dart';
import '../tabs/profile/update_profile/update_profile.dart';
import '../tabs/search/search_tap.dart';
import '../utils/app_assets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex=0;
  List<Widget> tabs=[
    HomeTap(),
    SearchTap(),
    ExploreTap(),
    UpdateProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width ;
    var height=MediaQuery.of(context).size.height ;
    return Scaffold(
      backgroundColor: Colors.transparent,
        bottomNavigationBar:Padding(
          padding:  EdgeInsets.symmetric(horizontal: width*0.02,vertical: height*0.01),
          child: BottomNavigationBar(

            backgroundColor: AppColor.silver,
            type: BottomNavigationBarType.fixed,
            currentIndex: selectedIndex,
            showSelectedLabels: false,
            showUnselectedLabels: false,
              unselectedItemColor: AppColor.whait,
              selectedItemColor: AppColor.yellow,
              onTap:(index) {
                selectedIndex =index;
                setState(() {
                });
              },
            items: [
              BottomNavigationBarItem(
                icon: builtBottomNavItem(index: 0, iconName: AppAssets.homeIcon),
                  label: ""

              ),
              BottomNavigationBarItem(
                icon: builtBottomNavItem(index: 1, iconName: AppAssets.searchIcon),
                  label: ""

              ),
              BottomNavigationBarItem(
                  icon: builtBottomNavItem(index: 2, iconName: AppAssets.exploreIcon),
                  label: ""

              ),
              BottomNavigationBarItem(
                  icon: builtBottomNavItem(index: 3, iconName: AppAssets.profileIcon),
                  label: ""

              ),
            ],

          ),
        ),
      body: Container(
        child:tabs[selectedIndex],
      ),
    );
  }
  Widget builtBottomNavItem({required int index,required String iconName}){
    return selectedIndex==index ?
    Container(
       padding:  EdgeInsets.symmetric(horizontal: 20),
        child: ImageIcon(AssetImage( iconName,))):
    ImageIcon(AssetImage( iconName,),
    );

  }
}
