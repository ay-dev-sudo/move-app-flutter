import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import 'movie_details_screen_cubit/movie_details_screen_view_model.dart';
import 'movie_details_screen_cubit/movie_details_screen_states.dart';
import 'widgets/cast_containar.dart';
import 'widgets/likes_or_time_rating_container.dart';
import 'widgets/screen_shots_container.dart';
import 'widgets/similar_movie_card.dart';
import 'package:move/utils/app_color.dart';
import 'package:move/utils/app_fonts.dart';
import 'package:move/utils/app_assets.dart';
import 'package:move/utils/app_routs.dart';
import 'package:move/widget/custom_bottom.dart';
import 'package:move/widget/alert_dialog_utils.dart';

class MovieDetailsScreen extends StatefulWidget {
  const MovieDetailsScreen({super.key});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  final MovieDetailsScreenViewModel viewModel = MovieDetailsScreenViewModel();
   int? movieId;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
       movieId = ModalRoute.of(context)?.settings.arguments as int;
        viewModel.loadMovieDetails(movieId!);
        viewModel.loadMovieSuggestions(movieId!);
        viewModel.loadFavoriteStatus(movieId!);
    });
  }


  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return BlocBuilder<MovieDetailsScreenViewModel, MovieDetailsScreenStates>(
      bloc: viewModel,
      builder: (context, state) {
        if (state is MovieDetailsLoadingState || viewModel.movieDetails == null) {
          return const Center(child: CircularProgressIndicator(color: AppColor.white));
        }



        if (state is MovieDetailsErrorState ) {
          return  Center(
              child: Text(
                state.errorMessage,
                style: AppFonts.bold20white,
              ),

          );
        }
        return Scaffold(
          backgroundColor: AppColor.black,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Stack(
                      children: [
                        CachedNetworkImage(
                          height: height * 0.6,
                          width: double.infinity,
                          imageUrl:  viewModel.movieDetails!.largeCoverImage ?? "",
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(color: AppColor.yellow)),
                          errorWidget: (context, url, error) =>
                          const Icon(Icons.error, color: AppColor.red),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: height * 0.4,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  AppColor.black,
                                  AppColor.blackOp71,
                                  AppColor.transparentColor
                                ],
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () => Navigator.of(context).pop(),
                              icon: const Icon(Icons.arrow_back_ios_new_outlined,
                                  size: 35, color: AppColor.white),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                              child:
                              InkWell(
                                onTap: () async {
                                  try {
                                    if (viewModel.isFavorite == true) {
                                      await viewModel.removeFromFavorite();
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(backgroundColor: AppColor.red, content: Text("Removed from Favorites Successfully")),
                                      );
                                    } else {
                                      await viewModel.addToFavorite();
                                      ScaffoldMessenger.of(context).showSnackBar(
                                         SnackBar(backgroundColor: AppColor.green,content: Text("Added to Favorites Successfully")),
                                      );
                                    }
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(e.toString())),
                                    );
                                  }
                                },
                                child: Image.asset(
                                  viewModel.isFavorite == true
                                      ? AppAssets.watchListIcon
                                      : AppAssets.notWatchList,
                                  height: 35,
                                ),
                              ),

                            ),
                          ],
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          top: 40,
                          child: InkWell(
                            onTap: () async {
                              final Uri uri = Uri.tryParse( viewModel.movieDetails!.url) ?? Uri();
                              if (await canLaunchUrl(uri)) {
                                await launchUrl(uri,
                                    mode: LaunchMode.inAppWebView);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text("Can't open this URL")));
                              }
                            },
                            child: Image.asset(AppAssets.watch),
                          ),
                        ),
                        Positioned(
                          bottom: height * 0.04,
                          left: 0,
                          right: 0,
                          child: Column(
                            children: [
                              Text( viewModel.movieDetails!.titleLong ?? "",
                                  textAlign: TextAlign.center,
                                  style: AppFonts.regular24white),
                              SizedBox(height: height * 0.005),
                              Text("${ viewModel.movieDetails!.year}",
                                  textAlign: TextAlign.center,
                                  style: AppFonts.regular20white),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: height * 0.02),
                    CustomButton(
                      color: AppColor.red,
                      width: double.infinity,
                      height: height * 0.07,
                      text: "Watch",
                      borderColor: AppColor.transparentColor,
                      textFont: AppFonts.bold20white,
                      onTap: () async {
                        final Uri uri = Uri.tryParse( viewModel.movieDetails!.url) ?? Uri();
                        if (await canLaunchUrl(uri)) {
                          await launchUrl(uri, mode: LaunchMode.inAppWebView);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Can't open this URL")));
                        }
                      },
                    ),

                    SizedBox(height: height * 0.02),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        LikesOrTimeRatingContainer(
                            imageName: AppAssets.loveYellow,
                            textName: "${ viewModel.movieDetails!.likeCount}"),
                        LikesOrTimeRatingContainer(
                            imageName: AppAssets.timeYellow,
                            textName: "${ viewModel.movieDetails!.runtime}"),
                        LikesOrTimeRatingContainer(
                            imageName: AppAssets.starYellow,
                            textName: "${ viewModel.movieDetails!.rating}"),
                      ],
                    ),

                    SizedBox(height: height * 0.02),

                    Text("Screen Shots", style: AppFonts.regular24white),
                    ScreenShotsContainer(
                        screenShotName:  viewModel.movieDetails!.backgroundImageOriginal ?? ""),
                    ScreenShotsContainer(
                        screenShotName:  viewModel.movieDetails!.backgroundImageOriginal ?? ""),
                    ScreenShotsContainer(
                        screenShotName:  viewModel.movieDetails!.mediumCoverImage ?? ""),

                    SizedBox(height: height * 0.02),

                    Text("Similar", style: AppFonts.regular24white),
                    SizedBox(height: height * 0.01),
                    viewModel.suggestions.isNotEmpty
                        ? SizedBox(
                      width: width,
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          childAspectRatio: 0.7,
                        ),
                        itemCount: viewModel.suggestions.length > 4
                            ? 4
                            : viewModel.suggestions.length,
                        itemBuilder: (context, index) {
                          final sug = viewModel.suggestions[index];
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                AppRouts.movieDetailsScreenRouteName,
                                arguments: sug.id,
                              );
                            },
                            child: SimilarMovieCard(movie: sug),
                          );
                        },
                      ),
                    )
                        : Text("No Similar Movies", style: AppFonts.regular16white),

                    SizedBox(height: height * 0.02),

                    Text("Description", style: AppFonts.regular24white),
                    SizedBox(height: height * 0.01),
                    Text( viewModel.movieDetails!.descriptionIntro ?? "No description available",
                        style: AppFonts.regular16white),

                    SizedBox(height: height * 0.02),

                    Text("Cast", style: AppFonts.regular24white),
                    SizedBox(height: height * 0.01),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => CastContainar(),
                      separatorBuilder: (context, index) =>
                          SizedBox(height: height * 0.01),
                      itemCount: 4,
                    ),

                    SizedBox(height: height * 0.02),

                    Text("Genres", style: AppFonts.regular24white),
                    SizedBox(height: height * 0.01),
                    viewModel.movieDetails!.genres != null &&  viewModel.movieDetails!.genres.isNotEmpty
                        ? SizedBox(
                      height: height * 0.12,
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            childAspectRatio: 3),
                        itemCount:  viewModel.movieDetails!.genres.length,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                              color: AppColor.silver,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            alignment: Alignment.center,
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed(
                                    AppRouts.browseTapScreenRouteName,
                                    arguments:  viewModel.movieDetails!.genres[index]);
                              },
                              child: Text( viewModel.movieDetails!.genres[index],
                                  style: AppFonts.regular16white),
                            ),
                          );
                        },
                      ),
                    )
                        : Text("No genres available",
                        style: AppFonts.regular16white),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

