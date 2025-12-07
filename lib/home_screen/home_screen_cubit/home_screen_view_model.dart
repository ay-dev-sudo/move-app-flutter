import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../tabs/browse/browse_tap.dart';
import '../../tabs/home/home_tap.dart';
import '../../tabs/profile/profile_tab.dart';
import '../../tabs/search/search_tap.dart';
import 'home_screen_states.dart';

class HomeScreenViewModel extends Cubit<HomeScreenStates>{
  HomeScreenViewModel() : super(HomeScreenInitialState());

  int selectedIndex = 0;
  final List<Widget> tabs = [
    HomeTap(),
    SearchTap(),
    BrowseTap(),
    ProfileTab(),
  ];
  void changeSelectedIndex(int index){
    selectedIndex=index;
    emit(ChangeSelectIndexState());
  }


}