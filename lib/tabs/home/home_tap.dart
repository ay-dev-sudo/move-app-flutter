import 'dart:math';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:move/utils/app_assets.dart';
import 'package:move/utils/app_color.dart';
import 'package:move/utils/app_fonts.dart';
import '../../api/api_service .dart';
import '../../model/MoviesResponse.dart';
import '../../shared_helper/shared_helper.dart';
import '../../utils/app_routs.dart';
import 'widgets/carousel_slider_card_large.dart';
import 'widgets/card_medium.dart';

class HomeTap extends StatefulWidget {
  const HomeTap({super.key});

  @override
  State<HomeTap> createState() => _HomeTapState();
}

class _HomeTapState extends State<HomeTap> {
  String genre = '';

  List<Movies> latestMoviesList = [];
  List<Movies> genreMoviesList = [];

  int currentIndex = 0;

  bool isLatestLoading = true;
  bool isGenreLoading = true;

  final CarouselSliderController _carouselController = CarouselSliderController();

  @override
  void initState() {
    super.initState();
    loadLatestMovies();
    loadGenreMovies();
  }
  Future<void> loadLatestMovies() async {
    try {
      final response = await ApiService().getMovieList(sort_by: "date_added");

      setState(() {
        latestMoviesList = response.data?.movies ?? [];
        isLatestLoading = false;
      });
    } catch (e) {
      setState(() {
        isLatestLoading = false;
      });
    }
  }

  Future<void> loadGenreMovies() async {
    try {
      final response = await ApiService().getMovieList();
      final allMovies = response.data?.movies ?? [];

      if (allMovies.isEmpty) {
        setState(() {
          isGenreLoading = false;
        });
        return;
      }
      final allGenres = allMovies.expand((movie) => movie.genres ?? []).toList();
      if (allGenres.isEmpty) {
        setState(() {
          isGenreLoading = false;
        });
        return;
      }
      final randomGenre = allGenres[Random().nextInt(allGenres.length)];
      final genreResponse = await ApiService().getMovieList(genre: randomGenre);
      setState(() {
        genre = randomGenre;
        genreMoviesList = genreResponse.data?.movies ?? [];
        isGenreLoading = false;
      });
    } catch (e) {
      setState(() {
        isGenreLoading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    if (isLatestLoading || isGenreLoading) {
      return const Scaffold(
        backgroundColor: AppColor.silver,
        body: Center(child: CircularProgressIndicator(color: AppColor.red,)),
      );
    }
    if (latestMoviesList.isEmpty) {
      return const Center(child: Text("No latest movies found"));
    }
    if (genreMoviesList.isEmpty) {
      return const Center(child: Text("No movies found for this genre"));
    }

    return Scaffold(
      backgroundColor: AppColor.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      latestMoviesList[currentIndex].backgroundImageOriginal ?? '',
                    ),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.50), BlendMode.darken),
                  ),
                ),
                child: Column(
                  children: [
                    Image.asset(AppAssets.availableNow),
                    SizedBox(height: height * 0.01),
                    CarouselSlider(
                      carouselController: _carouselController,
                      options: CarouselOptions(
                        height: height * 0.40,
                        viewportFraction: 0.62,
                        enlargeCenterPage: true,
                        onPageChanged: (index, reason) {
                          setState(() {
                            currentIndex = index;
                          });
                        },
                      ),
                      items: latestMoviesList.map((movie) {
                        return InkWell(
                          onTap: () async {
                            await SharedHelper.saveMovie({
                              "id": movie.id,
                              "title": movie.title,
                              "image": movie.largeCoverImage,
                              "rating": movie.rating,
                              "year": movie.year,
                            });
                            Navigator.pushNamed(
                              context,
                              AppRouts.movieDetailsScreenRouteName,
                              arguments: movie.id,
                            );
                          },

                          child: CarouselSliderCardLarge(movie: movie),
                        );
                      }).toList(),
                    ),

                    SizedBox(height: height * 0.01),
                    Image.asset(AppAssets.watchNow),
                  ],
                ),
              ),
              SizedBox(height: height * 0.015),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: width*0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(genre, style: AppFonts.regular20white),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(AppRouts.browseTapScreenRouteName,
                        arguments: genre
                        );
                      },
                      child: Row(
                        children: [
                          Text("See More", style: AppFonts.regular16Yellow),
                          Icon(Icons.arrow_forward_ios,
                              size: 15, color: AppColor.yellow),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.02),
              SizedBox(
                height: height * 0.20,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: genreMoviesList.length,
                  separatorBuilder: (context, index) =>
                      SizedBox(width: width * 0.05),
                  itemBuilder: (context, index) {
                    final movie = genreMoviesList[index];
                    return InkWell(
                      onTap: () async {
                        await SharedHelper.saveMovie({
                          "id": movie.id,
                          "title": movie.title,
                          "image": movie.largeCoverImage,
                          "rating": movie.rating,
                          "year": movie.year,
                        });
                        Navigator.pushNamed(
                          context,
                          AppRouts.movieDetailsScreenRouteName,
                          arguments: movie.id,
                        );
                      },
                      child: CardMedium(movie: movie),
                    );
                  },
                ),
              ),

              SizedBox(height: height * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}
