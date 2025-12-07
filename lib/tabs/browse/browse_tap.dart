import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move/utils/app_color.dart';
import '../../shared_helper/shared_helper.dart';
import '../../utils/app_routs.dart';
import '../../utils/app_fonts.dart';
import 'browse_cubit/browse_states.dart';
import 'browse_cubit/browse_view_model.dart';
import 'widgets/card_movie.dart';
import 'widgets/genres_tap_widget.dart';

class BrowseTap extends StatefulWidget {
  const BrowseTap({super.key});

  @override
  State<BrowseTap> createState() => _BrowseTapState();
}

class _BrowseTapState extends State<BrowseTap> {
  BrowseViewModel viewModel = BrowseViewModel();
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final genreFromArgs = ModalRoute.of(context)?.settings.arguments as String?;
      if (genreFromArgs != null) {
        viewModel.genreFromArgs = genreFromArgs;
      }

      viewModel.loadMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColor.blackOp71,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: width * 0.02, right: width * 0.02, top: height * 0.02),
          child: Column(
            children: [
              BlocBuilder<BrowseViewModel, BrowseStates>(
                bloc: viewModel,
                builder: (context, state) {
                  if (state is BrowseErrorState ) {
                    return Center(child: Text(state.errorMessage));
                  }
                  return SizedBox(
                    height: 50,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: viewModel.genres.length,
                      separatorBuilder: (_, __) => SizedBox(width: width * 0.02),
                      itemBuilder: (context, index) => InkWell(
                        onTap: () => viewModel.loadMoviesByGenre(viewModel.genres[index]),
                        child: GenresTapWidget(
                          genre: viewModel.genres[index],
                          isSelected: viewModel.selectedIndex == index,
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: height * 0.02),
              Expanded(
                child: BlocBuilder<BrowseViewModel, BrowseStates>(
                  bloc: viewModel,
                  builder: (context, state) {
                    if (state is BrowseLoadingState) {
                      return  Center(child: CircularProgressIndicator(color: AppColor.red));
                    }
                    if (state is BrowseErrorState) {
                      return Center(child: Text(state.errorMessage, style: AppFonts.bold20White));
                    }
                    if (viewModel.moviesByGenre.isEmpty) {
                      return Center(child: Text("No movies", style: AppFonts.bold20White));
                    }
                    return GridView.builder(
                      itemCount: viewModel.moviesByGenre.length,
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
                              "id": viewModel.moviesByGenre[index].id,
                              "title": viewModel.moviesByGenre[index].title,
                              "image": viewModel.moviesByGenre[index].largeCoverImage,
                              "rating": viewModel.moviesByGenre[index].rating,
                              "year": viewModel.moviesByGenre[index].year,
                            });
                            Navigator.of(context).pushNamed(
                              AppRouts.movieDetailsScreenRouteName,
                              arguments: viewModel.moviesByGenre[index].id as int,
                            );
                          },
                          child: CardMovie(movie: viewModel.moviesByGenre[index]),
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
