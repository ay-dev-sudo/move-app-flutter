import 'package:flutter/material.dart';
import 'package:move/model/MoviesResponse.dart';
import 'package:move/tabs/browse/widgets/card_movie.dart';
import 'package:move/tabs/browse/widgets/genres_tap_widget.dart';
import 'package:move/utils/app_color.dart';
import 'package:move/utils/app_routs.dart';
import '../../api/api_service .dart';
import '../../shared_helper/shared_helper.dart';
import '../../utils/app_fonts.dart';

class BrowseTap extends StatefulWidget {
  const BrowseTap({super.key});

  @override
  State<BrowseTap> createState() => _BrowseTapState();
}

class _BrowseTapState extends State<BrowseTap> {
  Future<MoviesResponse>? moviesFuture;
  Future<MoviesResponse>? moviesByGenreFuture;

  int selectedIndex = 0;
  List<Movies> moviesList = [];
  List<String> uniqueGenres = [];
  String? genreFromArgs;

  @override
  void initState() {
    super.initState();
    moviesFuture = ApiService().getMovieList(limit: 50);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      genreFromArgs = ModalRoute.of(context)?.settings.arguments as String?;
    });
  }

  void loadMoviesByGenre(String genre) {
    moviesByGenreFuture = ApiService().getMovieList(genre: genre,limit: 50);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColor.blackOp71,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: width * 0.02,
            right: width * 0.02,
            top: height * 0.02,
          ),
          child: Column(
            children: [
              FutureBuilder<MoviesResponse>(
                future: moviesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(color: AppColor.white),
                    );
                  }
                  if (snapshot.hasError || snapshot.data?.status != "ok") {
                    return errorWidget(
                      message: snapshot.hasError
                          ? "Something went wrong"
                          : snapshot.data!.status ?? "",
                    );
                  }
                  moviesList = snapshot.data?.data?.movies ?? [];
                  final allGenres = moviesList
                      .expand((movie) => movie.genres ?? [])
                      .toList();
                  final uniqueGenres = allGenres.toSet().toList()..sort();

                  if (moviesByGenreFuture == null && uniqueGenres.isNotEmpty) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      setState(() {
                        if (genreFromArgs != null &&
                            uniqueGenres.contains(genreFromArgs)) {
                          selectedIndex = uniqueGenres.indexOf(genreFromArgs!);
                          loadMoviesByGenre(genreFromArgs!);
                        } else {
                          selectedIndex = 0;
                          loadMoviesByGenre(uniqueGenres[0]);
                        }
                      });
                    });
                  }
                  return SizedBox(
                    height: 50,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: uniqueGenres.length,
                      separatorBuilder: (context, index) =>
                          SizedBox(width: width * 0.02),
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                            loadMoviesByGenre(uniqueGenres[index]);
                          });
                        },
                        child: GenresTapWidget(
                          genre: uniqueGenres[index],
                          isSelected: selectedIndex == index,
                        ),
                      ),
                    ),
                  );
                },
              ),

              SizedBox(height: height * 0.02),
              Expanded(
                child: moviesByGenreFuture == null
                    ? const Center(
                        child: CircularProgressIndicator(color: AppColor.red),
                      )
                    : FutureBuilder<MoviesResponse>(
                        future: moviesByGenreFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: AppColor.white,
                              ),
                            );
                          }
                          if (!snapshot.hasData || snapshot.hasError) {
                            return Center(
                              child: Text(
                                "No movies",
                                style: AppFonts.bold20White,
                              ),
                            );
                          }

                          final moviesListByGenre =
                              snapshot.data!.data?.movies ?? [];
                          if (moviesListByGenre.isEmpty) {
                            return Center(
                              child: Text(
                                "No movies",
                                style: AppFonts.bold20White,
                              ),
                            );
                          }
                          return GridView.builder(
                            itemCount: moviesListByGenre.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: height * 0.01,
                                  mainAxisSpacing: width * 0.04,
                                  childAspectRatio: 0.7,
                                ),
                            itemBuilder: (context, index) {
                              final movie = moviesListByGenre[index];
                              return InkWell(

                                onTap: () async {
                                  await SharedHelper.saveMovie({
                                    "id": movie.id,
                                    "title": movie.title,
                                    "image": movie.largeCoverImage,
                                    "rating": movie.rating,
                                    "year": movie.year,
                                  });
                                  Navigator.of(context).pushNamed(
                                    AppRouts.movieDetailsScreenRouteName,
                                    arguments: movie.id,
                                  );
                                },

                                child: CardMovie(movie: movie),
                              );
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget errorWidget({required String message}) => Column(
    children: [
      Text(message, style: AppFonts.bold20White),
      const SizedBox(height: 10),
      ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: AppColor.white),
        onPressed: () =>
            setState(() => moviesFuture = ApiService().getMovieList()),
        child: const Text("Try Again"),
      ),
    ],
  );
}
