import 'dart:convert';

import 'package:mobile2you/app/data/datasources/search_movie_datasource_interface.dart';
import 'package:mobile2you/app/data/endpoints/themoviedb_endpoint.dart';
import 'package:mobile2you/app/data/models/movie_model.dart';
import 'package:mobile2you/app/domain/errors/datasource_errors.dart';
import 'package:mobile2you/shared/constants/constants.dart';
import 'package:mobile2you/shared/http_client/http_client_interface.dart';

class SearchMovieDatasource implements ISearchMovieDatasource {
  final IHttpClient client;
  SearchMovieDatasource(this.client);

  @override
  Future<MovieModel> call(int movieId) async {
    String url = TheMovieDbEndpoint.url;
    url += "movie/$movieId?api_key=$API_KEY&language=$API_LANG";

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

    final model = MovieModel.fromJson(result.body);
    return model;
  }
}
