import 'package:flutter/cupertino.dart';

import '../../../../utils/app_assets.dart';
import '../../../../utils/app_color.dart';
import '../../../../utils/app_fonts.dart';

class LikesOrTimeRatingContainer extends StatelessWidget {
   LikesOrTimeRatingContainer({super.key,required this.imageName,required this.textName});
  String textName;
  String imageName;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      width: width*0.3,
      height: height*0.06,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color:AppColor.silver,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(imageName),
          Text(textName,style: AppFonts.regular24white,)
        ],
      ),
    );

  }
}
