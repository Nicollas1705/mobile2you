import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mobile2you/app/data/models/movie_model.dart';
import 'package:mobile2you/app/domain/entities/movie_entity.dart';
import 'package:mobile2you/shared/constants/constants.dart';

import '../../../mocks/the_martian_details_mock.dart';

void main() {
  group("MovieModel |", () {
    test(
      "(fromJson) Should convert from json correcty",
      () {
        final model = MovieModel.fromJson(theMartianJson);
        final map = json.decode(theMartianJson);
        final genres = ["Drama", "Adventure", "Science Fiction"];
        final mapYear = map["release_date"].toString().split("-")[0];

        expect(model.id, MOVIE_ID);
        expect(model.adult, false);
        expect(model.backdropPath, map["backdrop_path"]);
        expect(model.genres, genres);
        expect(model.popularity, map["popularity"]);
        expect(model.releaseDate.year.toString(), mapYear);
        expect(model.title, map["title"]);
        expect(model.voteCount, map["vote_count"]);
      },
    );

    test(
      "(toEntity) Should be equals: 'MovieModel' and 'MovieEntity'",
      () {
        final model = MovieModel.fromJson(theMartianJson);
        final entity = model.toEntity();

        expect(model.id, entity.id);
        expect(model.adult, entity.check);
        expect(model.backdropPath, entity.cover);
        expect(model.genres, equals(entity.genres));
        expect(model.popularity, entity.popularity);
        expect(model.releaseDate.year, entity.year);
        expect(model.title, entity.title);
        expect(model.voteCount, entity.likes);
      },
    );

    test(
      "(fromEntity) Should be equals: 'MovieModel' and 'MovieEntity'",
      () {
        final entity = MovieEntity(
          check: true,
          cover: "cover",
          genres: [""],
          id: 1,
          likes: 12,
          popularity: 123,
          title: "title",
          year: 1234,
        );
        final model = MovieModel.fromEntity(entity);

        expect(model.id, entity.id);
        expect(model.adult, entity.check);
        expect(model.backdropPath, entity.cover);
        expect(model.genres, equals(entity.genres));
        expect(model.popularity, entity.popularity);
        expect(model.releaseDate.year, entity.year);
        expect(model.title, entity.title);
        expect(model.voteCount, entity.likes);
      },
    );
  });
}
