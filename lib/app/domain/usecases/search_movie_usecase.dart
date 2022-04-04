import 'package:mobile2you/app/data/sepositories/search_movie_repository_interface.dart';
import 'package:mobile2you/app/domain/entities/movie_entity.dart';
import 'package:mobile2you/app/domain/errors/datasource_errors.dart';
import 'package:mobile2you/app/domain/errors/repository_errors.dart';
import 'package:mobile2you/app/domain/errors/search_movie_error.dart';
import 'package:mobile2you/app/domain/usecases/search_movie_usecase_intreface.dart';

class SearchMovieUsecase implements ISearchMovieUsecase {
  final ISearchMovieRepository repository;
  SearchMovieUsecase(this.repository);

  @override
  Future<MovieEntity> call(int movieId) async {
    if (movieId == 0) {
      throw SearchMovieInvalidMovieId();
    }

    late MovieEntity movieEntity;

    try {
      final result = await repository(movieId);
      movieEntity = result.toEntity();
    } on DatasourceError {
      throw SearchMovieInvalidResult();
    } on UnknowRepositoryError {
      throw SearchMovieInvalidResult();
    }

    return movieEntity;
  }
}
