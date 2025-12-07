import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move/utils/app_color.dart';
import 'package:move/utils/app_fonts.dart';

import '../../shared_helper/shared_helper.dart';
import '../../utils/app_routs.dart';
import '../../widget/custom_text_faild.dart';
import '../browse/widgets/card_movie.dart';
import 'search_cubit/search_states.dart';
import 'search_cubit/search_view_model.dart';

class SearchTap extends StatefulWidget {
  const SearchTap({super.key});

  @override
  State<SearchTap> createState() => _SearchTapState();
}

class _SearchTapState extends State<SearchTap> {
  late final SearchViewModel viewModel = SearchViewModel();
  TextEditingController searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    viewModel.loadMovies();
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return  Scaffold(
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
                    viewModel.loadMovies(searchByName: value);
                  },
                ),
                SizedBox(height: height * 0.02),
                Expanded(
                  child: BlocBuilder<SearchViewModel, SearchStates>(
                    bloc: viewModel,
                    builder: (context, state) {
                      if (state is SearchLoadingState) {
                        return  Center(
                          child: CircularProgressIndicator(color: AppColor.red,),
                        );
                      } else if (state is SearchErrorState) {
                        return Center(
                          child: Text(
                            state.errorMessage,
                            style: AppFonts.bold20white,
                          ),
                        );
                      }
                      final movieList = viewModel.movieList;
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
                            },
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
