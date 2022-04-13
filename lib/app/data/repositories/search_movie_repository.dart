import 'package:mobile2you/app/data/datasources/search_movie_datasource_interface.dart';
import 'package:mobile2you/app/data/models/movie_model.dart';
import 'package:mobile2you/app/data/repositories/search_movie_repository_interface.dart';
import 'package:mobile2you/app/domain/errors/datasource_errors.dart';
import 'package:mobile2you/app/domain/errors/repository_errors.dart';

class SearchMovieRepository implements ISearchMovieRepository {
  final ISearchMovieDatasource datasource;
  SearchMovieRepository(this.datasource);

  @override
  Future<MovieModel> call(int movieId) async {
    late MovieModel movieModel;
    try {
      movieModel = await datasource(movieId);
    } on DatasourceError {
      rethrow;
    } catch (e) {
      throw UnknowRepositoryError();
    }

    return movieModel;
  }
}
