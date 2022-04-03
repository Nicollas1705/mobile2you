import 'package:mobile2you/app/data/models/movie_model.dart';
import 'package:mobile2you/app/domain/entities/movie_entity.dart';

abstract class ISearchMovieRepository {
  Future<MovieModel> call(MovieEntity movieEntity);
}
