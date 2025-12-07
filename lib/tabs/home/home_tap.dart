import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:move/utils/app_assets.dart';
import 'package:move/utils/app_color.dart';
import 'package:move/utils/app_fonts.dart';

import '../../shared_helper/shared_helper.dart';
import '../../utils/app_routs.dart';
import 'home_cubit/home_states.dart';
import 'home_cubit/home_view_model.dart';
import 'widgets/carousel_slider_card_large.dart';
import 'widgets/card_medium.dart';


class HomeTap extends StatefulWidget {
  const HomeTap({super.key});

  @override
  State<HomeTap> createState() => _HomeTapState();
}

class _HomeTapState extends State<HomeTap> {
  final HomeViewModel viewModel = HomeViewModel();
  final CarouselSliderController _carouselController = CarouselSliderController();

  @override
  void initState() {
    super.initState();
    viewModel.loadLatestMovies();
    viewModel.loadGenreMovies();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return BlocBuilder<HomeViewModel, HomeStates>(
      bloc: viewModel,
      builder: (context, state) {
        if (state is HomeLoadingState) {
          return Center(child: CircularProgressIndicator(color: AppColor.red));

        }
        if (state is GenreMoviesLoadingState) {
          return Center(child: CircularProgressIndicator(color: AppColor.red));
        }

        if (state is HomeErrorState) {
          return  Center(
              child: Text(state.errorMessage, style:AppFonts.bold20white));
        }

        if (viewModel.latestMoviesList.isEmpty) {
          return const Center(child: Text("No latest movies found"));
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
                          viewModel.latestMoviesList[viewModel.currentIndex].backgroundImageOriginal ?? '',
                        ),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.50),
                          BlendMode.darken,
                        ),
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
                              viewModel.changeIndex(index);
                            },
                          ),
                          items: viewModel.latestMoviesList.map((movie) {
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
                                  arguments: movie.id as int,
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
                    padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(viewModel.genre, style: AppFonts.regular20white),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              AppRouts.browseTapScreenRouteName,
                              arguments: viewModel.genre,
                            );
                          },
                          child: Row(
                            children: [
                              Text("See More", style: AppFonts.regular16Yellow),
                              const Icon(Icons.arrow_forward_ios,
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
                      itemCount: viewModel.genreMoviesList.length,
                      separatorBuilder: (_, __) => SizedBox(width: width * 0.05),
                      itemBuilder: (context, index) {
                        final movie = viewModel.genreMoviesList[index];
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
      },
    );
  }
}
