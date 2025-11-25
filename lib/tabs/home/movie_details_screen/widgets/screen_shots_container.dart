import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../utils/app_color.dart';

class ScreenShotsContainer extends StatelessWidget {
   ScreenShotsContainer({super.key,required this.screenShotName});
   String screenShotName;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: CachedNetworkImage(
        height: height * 0.2,
        width: double.infinity,
        imageUrl: screenShotName,
        fit: BoxFit.fill,
        placeholder: (context, url) =>
            Center(child: CircularProgressIndicator(color: AppColor.yellow)),
        errorWidget: (context, url, error) =>
            Icon(Icons.error, color: AppColor.red),
      ),
    );

  }
}
