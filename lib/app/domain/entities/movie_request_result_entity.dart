import 'package:mobile2you/app/domain/entities/movie_entity.dart';

class MovieRequestResultEntity {
  final MovieEntity mainMovie;
  final List<MovieEntity> similarMovies;

  MovieRequestResultEntity({
    required this.mainMovie,
    required this.similarMovies,
  });
}
