import 'package:flutter/material.dart';
import 'package:mobile2you/app/domain/entities/movie_entity.dart';
import 'package:mobile2you/app/domain/entities/movie_request_result_entity.dart';
import 'package:mobile2you/app/domain/usecases/search_movie_usecase_interface.dart';
import 'package:mobile2you/app/domain/usecases/search_similar_movies_usecase_interface.dart';
import 'package:mobile2you/shared/utils/close_app.dart';

class MoviePageController {
  final ISearchMovieUsecase searchMovieUsecase;
  final ISearchSimilarMoviesUsecase searchSimilarMoviesUsecase;

  MoviePageController({
    required this.searchMovieUsecase,
    required this.searchSimilarMoviesUsecase,
  });

  Future<MovieRequestResultEntity> getAllMovies(int movieId) async {
    final mainMovieConsult = _getSearchMovieUsecase(movieId);
    final similarMoviesConsult = _getSearchSimilarMoviesUsecase(movieId);
    final result = await Future.wait([mainMovieConsult, similarMoviesConsult]);

    return MovieRequestResultEntity(
      mainMovie: result[0] as MovieEntity,
      similarMovies: result[1] as List<MovieEntity>,
    );
  }

  Future<MovieEntity> _getSearchMovieUsecase(int movieId) async {
    final searchMovieResult = await searchMovieUsecase(movieId);

    return searchMovieResult;
  }

  Future<List<MovieEntity>> _getSearchSimilarMoviesUsecase(int movieId) async {
    final searchSimilarMoviesResult = await searchSimilarMoviesUsecase(movieId);

    return searchSimilarMoviesResult;
  }

  void doubleTapToExit(BuildContext context) {
    CloseApp.doubleBackToClose(
      notification: () => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.grey[800],
          duration: const Duration(seconds: 2),
          content: const Text(
            "Press back button again to close the app.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
