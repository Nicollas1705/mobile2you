import 'package:mobile2you/app/data/sepositories/search_similar_movies_repository_interface.dart';
import 'package:mobile2you/app/domain/entities/movie_entity.dart';
import 'package:mobile2you/app/domain/errors/datasource_errors.dart';
import 'package:mobile2you/app/domain/errors/repository_errors.dart';
import 'package:mobile2you/app/domain/errors/search_movie_error.dart';
import 'package:mobile2you/app/domain/usecases/search_similar_movies_usecase_interface.dart';

class SearchSimilarMoviesUsecase implements ISearchSimilarMoviesUsecase {
  final ISearchSimilarMoviesRepository repository;
  SearchSimilarMoviesUsecase(this.repository);

  @override
  Future<List<MovieEntity>> call(int movieId) async {
    if (movieId == 0) {
      throw SearchMovieInvalidMovieId();
    }

    late List<MovieEntity> moviesEntity;

    try {
      final result = await repository(movieId);
      moviesEntity = [];
      for (var item in result) {
        moviesEntity.add(item.toEntity());
      }
    } on DatasourceError {
      throw SearchMovieInvalidResult();
    } on UnknowRepositoryError {
      throw SearchMovieInvalidResult();
    }

    return moviesEntity;
  }
}
