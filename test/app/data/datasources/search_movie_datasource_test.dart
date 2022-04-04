import 'package:flutter_test/flutter_test.dart';
import 'package:mobile2you/app/data/datasources/search_movie_datasource.dart';
import 'package:mobile2you/app/data/models/movie_model.dart';
import 'package:mobile2you/app/domain/errors/datasource_errors.dart';
import 'package:mobile2you/shared/http_client/http_client_interface.dart';
import 'package:mobile2you/shared/http_client/http_response.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/invalid_api_key_mock.dart';
import '../../../mocks/the_martian_details_mock.dart';

class HttpClientMock extends Mock implements IHttpClient {}

void main() {
  late HttpClientMock client;
  late SearchMovieDatasource datasource;

  setUp(() {
    client = HttpClientMock();
    datasource = SearchMovieDatasource(client);
  });

  group("SearchMovieDatasource |", () {
    test(
      "Should return the 'MovieModel'",
      () async {
        when(() => client.get(any())).thenAnswer((_) async => HttpResponse(
              statusCode: 200,
              body: theMartianJson,
            ));

        final result = await datasource(0);

        final movieModelResult = MovieModel.fromJson(theMartianJson);
        expect(result, movieModelResult);
      },
    );

    test(
      "Should throw 'InternalServerError'",
      () async {
        when(() => client.get(any())).thenAnswer((_) async => HttpResponse(
              statusCode: 0,
              body: "",
            ));

        final result = datasource(0);

        expect(() => result, throwsA(isA<InternalServerError>()));
      },
    );

    test(
      "Should throw 'NotFoundError'",
      () async {
        when(() => client.get(any())).thenAnswer((_) async => HttpResponse(
              statusCode: 404,
              body: "",
            ));

        final result = datasource(0);

        expect(() => result, throwsA(isA<NotFoundError>()));
      },
    );

    test(
      "Should throw 'EmptyServerResultError'",
      () async {
        when(() => client.get(any())).thenAnswer((_) async => HttpResponse(
              statusCode: 200,
              body: "",
            ));

        final result = datasource(0);

        expect(() => result, throwsA(isA<EmptyServerResultError>()));
      },
    );

    test(
      "Should throw 'InvalidParamsRequestError'",
      () async {
        when(() => client.get(any())).thenAnswer((_) async => HttpResponse(
              statusCode: 200,
              body: invalidApiKeyJson,
            ));

        final result = datasource(0);

        expect(() => result, throwsA(isA<InvalidParamsRequestError>()));
      },
    );
  });
}
