import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:move/model/GetProfile.dart';
import 'package:move/utils/app_color.dart';
import 'package:move/utils/app_fonts.dart';
import 'package:move/utils/app_routs.dart';

import '../../api/api_service .dart';
import '../../model/GetAllFavoritesMovies.dart';
import '../../shared_helper/shared_helper.dart';
import '../../utils/app_assets.dart';
import '../../widget/custom_bottom.dart';
import 'package:auto_size_text/auto_size_text.dart';
class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  List<Map<String, dynamic>> savedMovies = [];

  @override
  void initState() {
    super.initState();
    loadSavedMovies();
  }

  Future<void> loadSavedMovies() async {
    savedMovies = await SharedHelper.getSavedMovies();
    setState(() {});
  }


  String getAvatarFromId(int id) {
    switch (id) {
      case 1: return AppAssets.A1;
      case 2: return AppAssets.A2;
      case 3: return AppAssets.A3;
      case 4: return AppAssets.A4;
      case 5: return AppAssets.A5;
      case 6: return AppAssets.A6;
      case 7: return AppAssets.A7;
      case 8: return AppAssets.A8;
      case 9: return AppAssets.A9;
      default: return AppAssets.A8;
    }
  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColor.black,
        appBar: AppBar(
          backgroundColor: AppColor.silver,
          toolbarHeight: 330,
          title: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      FutureBuilder<GetProfile?>(
                        future: ApiService().getProfile(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return  Center(
                              child: CircularProgressIndicator(color: AppColor.white),
                            );
                          }
                          if (snapshot.hasError || snapshot.data?.data == null) {
                            return errorWidget(message: "Something went wrong");
                          }

                          var name = snapshot.data!.data!.name;
                          int avatarId = snapshot.data!.data!.avaterId ?? 0;
                          var myAvatar = getAvatarFromId(avatarId);

                          return Column(
                            children: [
                              Image.asset(myAvatar, scale: 0.7),
                              SizedBox(height: height * 0.02),
                              Text(name!, style: AppFonts.bold20White),
                            ],
                          );
                        },
                      ),
                    ],
                  ),

                  Expanded(
                    child: Column(
                      children: [
                        FutureBuilder<GetAllFavoritesMovies>(
                          future: ApiService().getAllFavoritesMovies(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Text("...", style: AppFonts.bold20White);
                            }
                            if (snapshot.hasError || snapshot.data?.data == null) {
                              return Text("0", style: AppFonts.bold20White);
                            }
                            final count = snapshot.data!.data!.length;
                            return Text("$count", style: AppFonts.bold20White);
                          },
                        ),
                        Text("Wish List", style: AppFonts.bold20White),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Text("${savedMovies.length}", style: AppFonts.bold20White),
                      Text("History", style: AppFonts.bold20White),
                    ],
                  ),
                ],
              ),
              SizedBox(height: height * 0.02),
              Row(
                children: [
                  CustomButton(
                    width: width * 0.6,
                    height: height * 0.06,
                    color: AppColor.yellow,
                    textFont: AppFonts.inter16black,
                    text: "Edit Profile",
                    borderColor: AppColor.transparentColor,
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRouts.updateProfileRouteName);
                    },
                  ),
                  SizedBox(width: width * 0.02),
                  CustomButton(
                    width: 120,
                    height: height * 0.06,
                    color: AppColor.red,
                    textFont: AppFonts.regular16white,
                    text: "Exit",
                    borderColor: AppColor.transparentColor,
                    suffixIcon: Icon(Icons.logout, color: AppColor.white),
                    onTap: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        AppRouts.loginRouteName,
                            (route) => false,
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: height * 0.03),
              TabBar(
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(color: AppColor.yellow, width: 5),
                  insets: EdgeInsets.symmetric(horizontal: width * 0.30),
                ),
                labelColor: AppColor.yellow,
                unselectedLabelColor: AppColor.white,
                tabs: [
                  Column(
                    children: [
                      Icon(Icons.list, color: AppColor.yellow, size: 40),
                      SizedBox(height: height*0.001),
                      Text("Watch List"),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(Icons.folder, color: AppColor.yellow, size: 40),
                      SizedBox(height: height*0.001),
                      Text("History"),
                    ],
                  ),

                ],
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            FutureBuilder<GetAllFavoritesMovies>(
              future: ApiService().getAllFavoritesMovies(),
              builder: (context, asyncSnapshot) {
                if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator(color: AppColor.white));
                }
                if (asyncSnapshot.hasError || asyncSnapshot.data?.data == null) {
                  return Center(child: Text("No watch list movies", style: AppFonts.bold20White));
                }
                var movies = asyncSnapshot.data!.data!;
                return gridView(movies.map((movie) => {
                  "id": movie.movieId,
                  "title": movie.name,
                  "image": movie.imageURL,
                  "rating": movie.rating,
                  "year": movie.year,
                }).toList());
              },
            ),
            gridView(savedMovies),
          ],
        ),
      ),
    );
  }
  Widget errorWidget({required String message}){
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(message, style: AppFonts.bold20White),
        SizedBox(height: 10),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: AppColor.white),
          onPressed: () {},
          child:  Text("Try Again"),
        ),
      ],
    );
}
  Widget gridView(List<Map<String, dynamic>> movies) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.45,
        mainAxisSpacing: width * 0.03,
        crossAxisSpacing: height * 0.02,
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return InkWell(
          onTap: () async {
            await Navigator.of(context).pushNamed(
              AppRouts.movieDetailsScreenRouteName,
              arguments: movie["id"],
            );
            setState(() {
              loadSavedMovies();
              ApiService().getAllFavoritesMovies();
            });
          },
          child: Padding(
            padding: EdgeInsets.only(top: height * 0.01),
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColor.silver,
              ),
              child: Column(
                children: [
                  CachedNetworkImage(
                    imageUrl: movie["image"] ?? "",
                    placeholder: (context, url) =>
                        Center(child: CircularProgressIndicator(color: AppColor.yellow)),
                    errorWidget: (context, url, error) =>
                        Icon(Icons.error, color: AppColor.red),
                  ),
                  SizedBox(height: height * 0.02),
                  AutoSizeText(
                    movie["title"] ?? "",
                    style: AppFonts.regular20white,
                    maxLines: 2,
                  ),
                  Text("Rating: ${movie["rating"] ?? 0}", style: AppFonts.regular14white),
                  Text("Year: ${movie["year"] ?? 0}", style: AppFonts.regular14white),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

}
