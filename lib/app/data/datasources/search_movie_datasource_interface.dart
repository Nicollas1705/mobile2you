import 'package:mobile2you/app/data/models/movie_model.dart';

abstract class ISearchMovieDatasource {
  Future<MovieModel> call(int movieId);
}
