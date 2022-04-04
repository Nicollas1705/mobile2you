import 'package:flutter_test/flutter_test.dart';
import 'package:mobile2you/app/data/models/movie_model.dart';
import 'package:mobile2you/app/data/sepositories/search_movie_repository_interface.dart';
import 'package:mobile2you/app/domain/entities/movie_entity.dart';
import 'package:mobile2you/app/domain/errors/repository_errors.dart';
import 'package:mobile2you/app/domain/errors/search_movie_error.dart';
import 'package:mobile2you/app/domain/usecases/search_movie_usecase.dart';
import 'package:mobile2you/shared/constants/constants.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/the_martian_details_mock.dart';

class SearchMovieRepositoryMock extends Mock implements ISearchMovieRepository {
}

void main() {
  late SearchMovieRepositoryMock repository;
  late SearchMovieUsecase usecase;

  setUp(() {
    repository = SearchMovieRepositoryMock();
    usecase = SearchMovieUsecase(repository);
  });

  test(
    "Should return 'MovieEntity'",
    () async {
      when(() => repository(any()))
          .thenAnswer((_) async => MovieModel.fromJson(theMartianJson));

      final result = await usecase(1);

      expect(result, isA<MovieEntity>());
      expect(result.id == MOVIE_ID, true);
    },
  );

  test(
    "Should throw 'SearchMovieInvalidMovieId'",
    () async {
      final result = usecase(0);
      expect(() => result, throwsA(isA<SearchMovieInvalidMovieId>()));
    },
  );

  test(
    "Should throw 'SearchMovieInvalidResult'",
    () async {
      when(() => repository(any())).thenThrow(UnknowRepositoryError());

      final result = usecase(1);

      expect(() => result, throwsA(isA<SearchMovieInvalidResult>()));
    },
  );
}
