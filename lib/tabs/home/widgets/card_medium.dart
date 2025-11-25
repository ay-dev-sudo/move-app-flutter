import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:move/model/MoviesResponse.dart';
import 'package:move/utils/app_assets.dart';
import 'package:move/utils/app_color.dart';
import 'package:move/utils/app_fonts.dart';

class CardMedium extends StatelessWidget {
  const CardMedium({super.key, required this.movie});
  final Movies movie;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: CachedNetworkImage(
            imageUrl: movie.mediumCoverImage??"",
            placeholder: (context, url) =>
                Center(child: CircularProgressIndicator(color: AppColor.yellow)),
            errorWidget: (context, url, error) =>
                Icon(Icons.error, color: AppColor.red),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: width * 0.12,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColor.blackOp71,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  flex: 1,
                  child: Text(
                    "${movie.rating ?? ''}",
                    style: AppFonts.regular16white,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Image.asset(AppAssets.star),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
