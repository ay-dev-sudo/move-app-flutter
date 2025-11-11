import 'package:flutter/material.dart';
import 'package:move/utils/app_color.dart';
import 'package:move/utils/app_assets.dart';

class BottomSheetAvatar {
  static  show({
    required BuildContext context,
    bool isSelected = false,
  }) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    final List<String> images = [
      AppAssets.A1,
      AppAssets.A2,
      AppAssets.A3,
      AppAssets.A4,
      AppAssets.A5,
      AppAssets.A6,
      AppAssets.A7,
      AppAssets.A8,
      AppAssets.A9,
    ];

    int? selectedIndex;

    return showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              height: height * 0.45,
              decoration: BoxDecoration(
                color: AppColor.black,
                borderRadius: BorderRadius.circular(24),
              ),
              padding: EdgeInsets.only(left: width * 0.02, right: width * 0.02,
                top: height * 0.02,
              ),
              margin: EdgeInsets.symmetric(
                horizontal: width * 0.02,
                vertical: height * 0.02,
              ),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemCount: images.length,
                itemBuilder: (context, index) {
                  final isSelected = selectedIndex == index;
                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                      Future.delayed(const Duration(milliseconds: 150), () {Navigator.pop(context, images[index]);
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected ? AppColor.yellowOp56 : AppColor.silver,
                        borderRadius: BorderRadius.circular(20), border: Border.all(
                          color: AppColor.yellow,
                          width: 2,
                        ),
                      ),
                      child: Image.asset(images[index], scale: 0.9,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
