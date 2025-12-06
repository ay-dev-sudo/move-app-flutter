import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move/model/GetProfile.dart';
import 'package:move/tabs/profile/profile_cubit/profile_states.dart';
import 'package:move/tabs/profile/profile_cubit/profile_view_model.dart';
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

  final ProfileViewModel viewModel = ProfileViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.loadAllData();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width  = MediaQuery.of(context).size.width;
    return BlocBuilder<ProfileViewModel, ProfileStates>(
      bloc: viewModel,
      builder: (context, state) {

        if (state is ProfileLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ProfileErrorState) {
          return Center(child: Text(state.message, style: AppFonts.bold20White));
        }

        if (state is ProfileSuccessState) {
          final profileData = state.profile.data!;
          final avatar = viewModel.getAvatarFromId(profileData.avaterId ?? 0);
          final favoriteMovies = state.favoriteMovies;
          final historyMovies = state.savedMovies;
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
                            Image.asset(avatar, scale: 0.7),
                            SizedBox(height: height * 0.02),
                            Text(profileData.name ?? "",
                                style: AppFonts.bold20White),
                          ],
                        ),

                        Column(
                          children: [
                            Text("${favoriteMovies.length}",
                                style: AppFonts.bold20White),
                            Text("Wish List", style: AppFonts.bold20White),
                          ],
                        ),
                        Column(
                          children: [
                            Text("${historyMovies.length}",
                                style: AppFonts.bold20White),
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
                          onTap: () async {
                            await Navigator.pushNamed(context, AppRouts.updateProfileRouteName);
                            viewModel.loadAllData();
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
                          suffixIcon:
                          Icon(Icons.logout, color: AppColor.white),
                          onTap: () {
                            SharedHelper.removeToken(key: "token");
                            Navigator.pushNamedAndRemoveUntil(
                              context,
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
                        borderSide:
                        BorderSide(color: AppColor.yellow, width: 5),
                        insets:
                        EdgeInsets.symmetric(horizontal: width * 0.30),
                      ),
                      labelColor: AppColor.yellow,
                      unselectedLabelColor: AppColor.white,
                      tabs: [
                        Column(
                          children: [
                            Icon(Icons.list,
                                color: AppColor.yellow, size: 40),
                            Text("Watch List"),
                          ],
                        ),
                        Column(
                          children: [
                            Icon(Icons.folder,
                                color: AppColor.yellow, size: 40),
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
                  buildGrid(favoriteMovies),
                  buildGrid(historyMovies),
                ],
              ),
            ),
          );
        }

        return Container();
      },
    );
  }

  Widget buildGrid(List movies) {
    var height = MediaQuery.of(context).size.height;
    var width  = MediaQuery.of(context).size.width;

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.45,
        mainAxisSpacing: width * 0.03,
        crossAxisSpacing: height * 0.02,
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        var movie = movies[index];
        final image = movie is Data ? movie.imageURL : movie["image"];
        final title = movie is Data ? movie.name : movie["title"];
        final rating = movie is Data ? movie.rating : movie["rating"];
        final year = movie is Data ? movie.year : movie["year"];
        final id = movie is Data ? movie.movieId : movie["id"];
        return InkWell(
          onTap: () async {
            await Navigator.pushNamed(
              context,
              AppRouts.movieDetailsScreenRouteName,
              arguments: id as int,
            );
            viewModel.loadAllData();
          },
          child: Container(
            margin: EdgeInsets.only(top: 10),
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: AppColor.silver,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                CachedNetworkImage(
                  imageUrl: image ?? "",
                  placeholder: (c, url) => Center(
                      child: CircularProgressIndicator(
                          color: AppColor.yellow)),
                  errorWidget: (c, url, err) =>
                      Icon(Icons.error, color: AppColor.red),
                ),
                SizedBox(height: height * 0.015),
                Center(
                  child: AutoSizeText(
                    title ?? "",
                    maxLines: 2,
                    style: AppFonts.regular20white,
                  ),
                ),
                Text("Rating: $rating",
                    style: AppFonts.regular14white),
                Text("Year: $year",
                    style: AppFonts.regular14white),
              ],
            ),
          ),
        );
      },
    );
  }
}

