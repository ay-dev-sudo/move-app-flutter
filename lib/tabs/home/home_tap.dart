import 'dart:math';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:move/utils/app_assets.dart';
import 'package:move/utils/app_color.dart';
import 'package:move/utils/app_fonts.dart';
import '../../api/api_service .dart';
import '../../model/MoviesResponse.dart';
import 'carousel_slider_card_large.dart';
import 'carousel_slider_card_medium.dart';
class HomeTap extends StatefulWidget {
  const HomeTap({super.key});

  @override
  State<HomeTap> createState() => _HomeTapState();
}

class _HomeTapState extends State<HomeTap> {
  String genre = '';
  late Future<MoviesResponse> futureMovies;
  int currentIndex = 0;
  final CarouselSliderController _carouselController = CarouselSliderController();

  @override
  void initState() {
    super.initState();
    futureMovies = ApiService().getMovieList();
  }

  void setRandomGenre(List<Movies> moviesList) {
    final random = Random();
    final allGenres = moviesList.expand((movie) => movie.genres ?? []).toList();
    setState(() {
      genre = allGenres[random.nextInt(allGenres.length)];
      futureMovies = ApiService().getMovieList(genre: genre);
      currentIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColor.black,
      body: SafeArea(
        child: FutureBuilder<MoviesResponse>(
          future: futureMovies,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  "Failed to load movies: ${snapshot.error}",
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }

            final moviesList = snapshot.data?.data?.movies ?? [];
            if (moviesList.isEmpty) {
              return const Center(child: Text("No movies found"));
            }

            if (genre.isEmpty) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                setRandomGenre(moviesList);
              });
              return const Center(child: CircularProgressIndicator());
            }


            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(moviesList[currentIndex].backgroundImageOriginal ?? ''),
                        fit: BoxFit.fill,
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.8), BlendMode.darken),
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
                          items: moviesList
                              .map((movie) =>
                              CarouselSliderCardLarge(movie: movie))
                              .toList(),
                        ),
                        SizedBox(height: height * 0.01),
                        Image.asset(AppAssets.watchNow),
                      ],
                    ),
                  ),

                  SizedBox(height: height * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(genre, style: AppFonts.regular20white),
                      Row(
                        children: [
                          Text("See More", style: AppFonts.regular16Yellow),
                          Icon(Icons.arrow_forward_outlined,
                              size: 15, color: AppColor.yellow)
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.02),
                  SizedBox(
                    height: height * 0.20,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return CarouselSliderCardMedium(movie: moviesList[index]);
                      },
                      separatorBuilder: (context, index) =>
                          SizedBox(width: width * 0.06),
                      itemCount: moviesList.length,
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
