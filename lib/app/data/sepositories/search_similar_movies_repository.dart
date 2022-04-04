import 'package:mobile2you/app/data/datasources/search_similar_movies_datasource_interface.dart';
import 'package:mobile2you/app/data/models/movie_model.dart';
import 'package:mobile2you/app/data/sepositories/search_similar_movies_repository_interface.dart';
import 'package:mobile2you/app/domain/errors/datasource_errors.dart';
import 'package:mobile2you/app/domain/errors/repository_errors.dart';

class SearchSimilarMoviesRepository implements ISearchSimilarMoviesRepository {
  final ISearchSimilarMoviesDatasource datasource;
  SearchSimilarMoviesRepository(this.datasource);

  @override
  Future<List<MovieModel>> call(int movieId) async {
    late List<MovieModel> moviesModel;
    try {
      moviesModel = await datasource(movieId);
    } on DatasourceError {
      rethrow;
    } catch (e) {
      throw UnknowRepositoryError();
    }

    return moviesModel;
  }
}
