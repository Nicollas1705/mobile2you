import 'package:mobile2you/app/domain/entities/movie_entity.dart';

abstract class ISearchSimilarMoviesUsecase {
  Future<List<MovieEntity>> call(int movieId);
}
