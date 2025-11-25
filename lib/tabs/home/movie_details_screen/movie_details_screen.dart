import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:move/tabs/home/widgets/card_medium.dart';
import 'package:move/tabs/home/movie_details_screen/widgets/likes_or_time_rating_container.dart';
import 'package:move/tabs/home/movie_details_screen/widgets/screen_shots_container.dart';
import 'package:move/utils/app_assets.dart';
import 'package:move/utils/app_routs.dart';
import '../../../api/api_service .dart';
import '../../../model/MovieDetailsResponse.dart';
import '../../../model/MovieSuggestionsResponse.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_fonts.dart';
import '../../../widget/custom_bottom.dart';
import 'widgets/cast_containar.dart';
import 'widgets/similar_movie_card.dart';
import 'package:url_launcher/url_launcher.dart';


class MovieDetailsScreen extends StatefulWidget {
  MovieDetailsScreen({super.key});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  Movie? movieDetails;
  List<Movies> movieSuggestions = [];

  bool isLoading = true;
  bool hasError = false;
  int? movieId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      movieId = ModalRoute.of(context)?.settings.arguments as int?;

      if (movieId == null) {
        setState(() {
          hasError = true;
          isLoading = false;
        });
        return;
      }

      loadMovieDetails();
      loadMovieSuggestions();
    });
  }

  Future<void> loadMovieDetails() async {
    print("Movie ID = $movieId");

    try {
      final response = await ApiService().getMovieDetails(movie_id: movieId!);
      print("Movie Details Response: ${response.data}");

      setState(() {
        movieDetails = response.data?.movie;
        hasError = movieDetails == null;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        hasError = true;
        isLoading = false;
      });
    }
  }

  Future<void> loadMovieSuggestions() async {
    if (movieId == null) return;

    try {
      final response = await ApiService().getMovieSuggestions(
        movie_id: movieId!,
      );
      setState(() {
        movieSuggestions = response.data?.movies ?? [];
      });
    } catch (e) {
      movieSuggestions = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    if (isLoading) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (hasError || movieDetails == null) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Text(
            "Failed to load movie details",
            style: TextStyle(color: Colors.white),
          ),
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
                      imageUrl: movieDetails!.largeCoverImage ?? "",
                      fit: BoxFit.fill,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(
                          color: AppColor.yellow,
                        ),
                      ),
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
                              AppColor.transparentColor,
                            ],
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(
                            Icons.arrow_back_ios_new_outlined,
                            size: 35,
                            color: AppColor.whait,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: width * 0.02,
                          ),
                          child: Image.asset(
                            AppAssets.watchListIcon,
                            height: 35,
                          ),
                        ),
                      ],
                    ),

                    Positioned(
                      left: 0,
                      right: 0,
                      top: 40,
                      child:
                      InkWell(
                        onTap: () async {

                          final Uri uri = Uri.tryParse(movieDetails!.url) ?? Uri();
                          if (await canLaunchUrl(uri)) {
                            await launchUrl(uri, mode: LaunchMode.inAppWebView);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Can't open this URL")),
                            );
                          }
                        },
                        child: Image.asset(AppAssets.watch),
                      ),                    ),
                    Positioned(
                      bottom: height * 0.04,
                      left: 0,
                      right: 0,
                      child: Column(
                        children: [
                          Text(
                            movieDetails!.titleLong ?? "",
                            textAlign: TextAlign.center,
                            style: AppFonts.regular24white,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "${movieDetails!.year}",
                            textAlign: TextAlign.center,
                            style: AppFonts.regular20white,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                CustomButton(
                  color: AppColor.red,
                  width: double.infinity,
                  height: height * 0.07,
                  text: "Watch",
                  borderColor: AppColor.transparentColor,
                  textFont: AppFonts.regular20bold,
                  onTap: () async {
                    final Uri uri = Uri.tryParse(movieDetails!.url) ?? Uri();
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri, mode: LaunchMode.inAppWebView);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Can't open this URL")),
                      );
                    }
                  },
                ),

                SizedBox(height: height * 0.02),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    LikesOrTimeRatingContainer(
                      imageName: AppAssets.loveYellow,
                      textName: "${movieDetails!.likeCount}",
                    ),
                    LikesOrTimeRatingContainer(
                      imageName: AppAssets.timeYellow,
                      textName: "${movieDetails!.runtime}",
                    ),
                    LikesOrTimeRatingContainer(
                      imageName: AppAssets.starYellow,
                      textName: "${movieDetails!.rating}",
                    ),
                  ],
                ),

                SizedBox(height: height * 0.02),

                Text("Screen Shots", style: AppFonts.regular24white),
                ScreenShotsContainer(
                  screenShotName: movieDetails!.backgroundImageOriginal ?? "",
                ),
                SizedBox(height: height * 0.02),
                ScreenShotsContainer(
                  screenShotName: movieDetails!.backgroundImageOriginal ?? "",
                ),
                SizedBox(height: height * 0.02),
                ScreenShotsContainer(
                  screenShotName: movieDetails!.mediumCoverImage ?? "",
                ),

                SizedBox(height: height * 0.03),

                // SIMILAR MOVIES
                Text("Similar", style: AppFonts.regular24white),
                SizedBox(height: height * 0.02),

                movieSuggestions.isNotEmpty
                    ? SizedBox(
                        width: width * 0.5,
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
                          itemCount: movieSuggestions.length > 4
                              ? 4
                              : movieSuggestions.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  AppRouts.movieDetailsScreenRouteName,
                                  arguments: movieSuggestions[index].id,
                                );
                              },
                              child: SimilarMovieCard(
                                movie: movieSuggestions[index],
                              ),
                            );
                          },
                        ),
                      )
                    : Text("No Similar Movies", style: AppFonts.regular16white),

                SizedBox(height: height * 0.03),

                // DESCRIPTION
                Text("Description", style: AppFonts.regular24white),
                SizedBox(height: height * 0.02),

                (movieDetails?.descriptionIntro ?? "").isEmpty
                    ? Text(
                        "No description available",
                        style: AppFonts.regular16white,
                      )
                    : Text(
                        movieDetails!.descriptionIntro!,
                        style: AppFonts.regular16white,
                      ),

                SizedBox(height: height * 0.03),

                // CAST (STATIC)
                Text("Cast", style: AppFonts.regular24white),
                SizedBox(height: height * 0.02),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => CastContainar(),
                  separatorBuilder: (context, index) =>
                      SizedBox(height: height * 0.02),
                  itemCount: 4,
                ),

                SizedBox(height: height * 0.03),

                // GENRES
                Text("Genres", style: AppFonts.regular24white),
                SizedBox(height: height * 0.02),

                movieDetails?.genres != null && movieDetails!.genres!.isNotEmpty
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
                                childAspectRatio: 3,
                              ),
                          itemCount: movieDetails!.genres!.length,
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
                                    AppRouts.exploreTapScreenRouteName,
                                    arguments: movieDetails!.genres![index],
                                  );
                                },
                                child: Text(
                                  movieDetails!.genres![index],
                                  style: AppFonts.regular16white,
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : Text(
                        "No genres available",
                        style: AppFonts.regular16white,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
