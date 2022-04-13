import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile2you/app/data/datasources/search_movie_datasource.dart';
import 'package:mobile2you/app/data/datasources/search_movie_datasource_interface.dart';
import 'package:mobile2you/app/data/datasources/search_similar_movies_datasource.dart';
import 'package:mobile2you/app/data/datasources/search_similar_movies_datasource_interface.dart';
import 'package:mobile2you/app/data/repositories/search_movie_repository.dart';
import 'package:mobile2you/app/data/repositories/search_movie_repository_interface.dart';
import 'package:mobile2you/app/data/repositories/search_similar_movies_repository.dart';
import 'package:mobile2you/app/data/repositories/search_similar_movies_repository_interface.dart';
import 'package:mobile2you/app/domain/usecases/search_movie_usecase.dart';
import 'package:mobile2you/app/domain/usecases/search_movie_usecase_interface.dart';
import 'package:mobile2you/app/domain/usecases/search_similar_movies_usecase.dart';
import 'package:mobile2you/app/domain/usecases/search_similar_movies_usecase_interface.dart';
import 'package:mobile2you/app/presenter/main_widget/main_widget.dart';
import 'package:mobile2you/shared/dio/dio_adapter.dart';
import 'package:mobile2you/shared/http_client/http_client_interface.dart';
import 'package:mobile2you/shared/utils/close_app.dart';
import 'package:get_it/get_it.dart';

abstract class AppDependencies {
  static void init() {
    CloseApp.onBackPressed = DateTime.now();

    GetIt locator = GetIt.I;
    locator.registerLazySingleton<ISearchMovieUsecase>(
        () => SearchMovieUsecase(locator()));
    locator.registerLazySingleton<ISearchMovieRepository>(
        () => SearchMovieRepository(locator()));
    locator.registerLazySingleton<ISearchMovieDatasource>(
        () => SearchMovieDatasource(locator()));

    locator.registerLazySingleton<ISearchSimilarMoviesUsecase>(
        () => SearchSimilarMoviesUsecase(locator()));
    locator.registerLazySingleton<ISearchSimilarMoviesRepository>(
        () => SearchSimilarMoviesRepository(locator()));
    locator.registerLazySingleton<ISearchSimilarMoviesDatasource>(
        () => SearchSimilarMoviesDatasource(locator()));

    locator.registerLazySingleton<IHttpClient>(() => DioAdapter(locator()));
    locator.registerLazySingleton<Dio>(() => Dio());

    runApp(const MainWidget());
  }
}
