import 'package:mobile2you/app/data/models/movie_model.dart';

abstract class ISearchSimilarMoviesDatasource {
  Future<List<MovieModel>> call(int movieId);
}
