import 'package:mobile2you/app/domain/entities/movie_entity.dart';

abstract class ISearchMovieUsecase {
  Future<MovieEntity> call(int movieId);
}
