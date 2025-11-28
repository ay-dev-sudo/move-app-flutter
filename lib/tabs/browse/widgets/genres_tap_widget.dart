import 'package:flutter/material.dart';
import 'package:move/model/MoviesResponse.dart';

import '../../../utils/app_color.dart';
import 'package:move/utils/app_fonts.dart';

class GenresTapWidget extends StatelessWidget {
  final String genre;
  bool isSelected;
  GenresTapWidget({super.key, required this.genre,required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color:isSelected?AppColor.transparentColor :AppColor.yellow, width: 3),
        color: isSelected? AppColor.yellow:AppColor.black
      ),
      child: Text(
        genre, style:isSelected? AppFonts.bold20black:AppFonts.bold20yellow
      ),
    );
  }
}
