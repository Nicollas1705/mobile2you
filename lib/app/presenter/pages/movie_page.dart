import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobile2you/app/domain/entities/movie_request_result_entity.dart';
import 'package:mobile2you/app/domain/usecases/search_movie_usecase_interface.dart';
import 'package:mobile2you/app/domain/usecases/search_similar_movies_usecase_interface.dart';
import 'package:mobile2you/app/presenter/components/movie_cover.dart';
import 'package:mobile2you/app/presenter/components/movie_list_tile.dart';
import 'package:mobile2you/app/presenter/controllers/movie_page_controller.dart';

class MoviePage extends StatelessWidget {
  MoviePage({
    Key? key,
    required this.movieId,
  }) : super(key: key);
  final int movieId;

  final MoviePageController controller = MoviePageController(
    searchMovieUsecase: GetIt.I.get<ISearchMovieUsecase>(),
    searchSimilarMoviesUsecase: GetIt.I.get<ISearchSimilarMoviesUsecase>(),
  );

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        controller.doubleTapToExit(context);
        return false;
      },
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        floatingActionButton: Container(
          padding: const EdgeInsets.only(top: 10),
          width: 32,
          child: FloatingActionButton(
            backgroundColor: Colors.black,
            child: const Icon(
              Icons.arrow_back_ios_outlined,
              color: Colors.white,
            ),
            onPressed: () => controller.doubleTapToExit(context),
          ),
        ),
        body: FutureBuilder(
          future: controller.getAllMovies(movieId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.data == null) {
              return const Center(
                child: Text(
                  "Error connection",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            } else {
              final data = snapshot.data as MovieRequestResultEntity;
              final mainMovie = data.mainMovie;
              final similarMovies = data.similarMovies;

              return CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  MovieCover(movie: mainMovie),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return MovieListTile(
                          movie: similarMovies[index],
                        );
                      },
                      childCount: 15,
                    ),
                  ),
                  const SliverPadding(padding: EdgeInsets.only(bottom: 16)),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
