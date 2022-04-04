import 'dart:convert';

import 'package:mobile2you/app/data/datasources/search_similar_movies_datasource_interface.dart';
import 'package:mobile2you/app/data/endpoints/themoviedb_endpoint.dart';
import 'package:mobile2you/app/data/models/movie_model.dart';
import 'package:mobile2you/app/domain/errors/datasource_errors.dart';
import 'package:mobile2you/shared/constants/constants.dart';
import 'package:mobile2you/shared/http_client/http_client_interface.dart';

class SearchSimilarMoviesDatasource implements ISearchSimilarMoviesDatasource {
  final IHttpClient client;
  SearchSimilarMoviesDatasource(this.client);

  @override
  Future<List<MovieModel>> call(int movieId) async {
    String url = TheMovieDbEndpoint.url;
    url += "movie/$movieId/similar?api_key=$API_KEY&language=en-US";

    final result = await client.get(url);

    if (result.statusCode == 404) {
      throw NotFoundError();
    } else if (result.statusCode != 200) {
      throw InternalServerError();
    } else if (result.body == null || result.body.toString().isEmpty) {
      throw EmptyServerResultError();
    } else if (json.decode(result.body)["status_code"] == 7) {
      throw InvalidParamsRequestError();
    }

    List<MovieModel> models = [];
    for (var item in (json.decode(result.body) as List)) {
      models.add(MovieModel.fromJson(item));
    }

    return models;
  }
}
