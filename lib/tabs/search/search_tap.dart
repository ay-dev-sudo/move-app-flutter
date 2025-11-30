import 'package:flutter/material.dart';
import 'package:move/utils/app_color.dart';

import '../../api/api_service .dart';
import '../../model/MoviesResponse.dart';
import '../../shared_helper/shared_helper.dart';
import '../../utils/app_routs.dart';
import '../../widget/custom_text_faild.dart';
import '../browse/widgets/card_movie.dart';

class SearchTap extends StatefulWidget {
  const SearchTap({super.key});

  @override
  State<SearchTap> createState() => _SearchTapState();
}

class _SearchTapState extends State<SearchTap> {
  TextEditingController searchCtrl = TextEditingController();
  Future<MoviesResponse>? futureMovies;

  @override
  void initState() {
    super.initState();
    futureMovies = ApiService().getMovieList(limit: 50);
  }

  void searchMovies(String query) {
    setState(() {
      futureMovies = ApiService().getMovieList(searchByName: query,limit: 50);
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColor.black,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.02),
          child: Column(
            children: [
              SizedBox(height: height * 0.02),
              CustomTextField(
                controller: searchCtrl,
                hint: "Search",
                icon: Icon(Icons.search, color: AppColor.white, size: 35),
                isPassword: false,
                onChanged: (value) {
                  searchMovies(value);
                },
              ),
              SizedBox(height: height * 0.02),
              Expanded(
                child: FutureBuilder<MoviesResponse?>(
                  future: futureMovies,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          "Error: ${snapshot.error}",
                          style: TextStyle(color: AppColor.white),
                        ),
                      );
                    }
                    var movieList = snapshot.data?.data?.movies ?? [];
                    if (movieList.isEmpty) {
                      return Center(
                        child: Text(
                          "No movies found",
                          style: TextStyle(color: AppColor.white),
                        ),
                      );
                    }
                    return GridView.builder(
                      itemCount: movieList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: height * 0.01,
                        mainAxisSpacing: width * 0.04,
                        childAspectRatio: 0.7,
                      ),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () async {
                            await SharedHelper.saveMovie({
                              "id": movieList[index].id,
                              "title": movieList[index].title,
                              "image": movieList[index].largeCoverImage,
                              "rating": movieList[index].rating,
                              "year": movieList[index].year,
                            });
                            Navigator.of(context).pushNamed(
                              AppRouts.movieDetailsScreenRouteName,
                              arguments: movieList[index].id,
                            );

                          } ,
                          child: CardMovie(movie: movieList[index]),
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
}
