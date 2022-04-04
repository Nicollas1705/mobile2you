import 'package:flutter_test/flutter_test.dart';
import 'package:mobile2you/app/data/datasources/search_movie_datasource_intreface.dart';
import 'package:mobile2you/app/data/models/movie_model.dart';
import 'package:mobile2you/app/data/sepositories/search_movie_repository.dart';
import 'package:mobile2you/app/domain/errors/datasource_errors.dart';
import 'package:mobile2you/app/domain/errors/repository_errors.dart';
import 'package:mobile2you/shared/constants/constants.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/the_martian_details_mock.dart';

class SearchMovieDatasourceMock extends Mock implements ISearchMovieDatasource {
}

void main() {
  late SearchMovieDatasourceMock datasource;
  late SearchMovieRepository repository;

  setUp(() {
    datasource = SearchMovieDatasourceMock();
    repository = SearchMovieRepository(datasource);
  });

  group("SearchMovieRepository |", () {
    test(
      "Should return 'MovieModel'",
      () async {
        when(() => datasource(any()))
            .thenAnswer((_) async => MovieModel.fromJson(theMartianJson));

        final result = await repository(0);

        expect(result, isA<MovieModel>());
        expect(result.id == MOVIE_ID, true);
      },
    );

    test(
      "Should throw 'DatasourceError'",
      () async {
        when(() => datasource(any())).thenThrow(InternalServerError());

        final result = repository(0);

        expect(() => result, throwsA(isA<DatasourceError>()));
      },
    );

    test(
      "Should throw 'UnknowRepositoryError'",
      () async {
        when(() => datasource(any())).thenThrow(Exception());

        final result = repository(0);

        expect(() => result, throwsA(isA<UnknowRepositoryError>()));
      },
    );
  });
}
