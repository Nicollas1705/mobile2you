import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:mobile2you/app/domain/entities/movie_entity.dart';

class MovieModel {
  final int id; // id
  final String title; // title
  final DateTime releaseDate; // year
  final List<String> genres; // genres
  final String backdropPath; // cover
  final bool adult; // check
  final double popularity; // popularity
  final int voteCount; // like

  MovieModel({
    required this.id,
    required this.title,
    required this.releaseDate,
    required this.genres,
    required this.backdropPath,
    required this.adult,
    required this.popularity,
    required this.voteCount,
  });

  MovieModel copyWith({
    int? id,
    String? title,
    DateTime? releaseDate,
    List<String>? genres,
    String? backdropPath,
    bool? adult,
    double? popularity,
    int? voteCount,
  }) {
    return MovieModel(
      id: id ?? this.id,
      title: title ?? this.title,
      releaseDate: releaseDate ?? this.releaseDate,
      genres: genres ?? this.genres,
      backdropPath: backdropPath ?? this.backdropPath,
      adult: adult ?? this.adult,
      popularity: popularity ?? this.popularity,
      voteCount: voteCount ?? this.voteCount,
    );
  }

  Map<String, dynamic> toMap() {
    final String year = "${releaseDate.year}";
    final String month = releaseDate.month.toString().padLeft(2, '0');
    final String day = releaseDate.day.toString().padLeft(2, '0');
    final String date = "$year-$month-$day";
    return {
      'id': id,
      'title': title,
      'release_date': date,
      'genres': genres,
      'backdrop_path': backdropPath,
      'adult': adult,
      'popularity': popularity,
      'vote_count': voteCount,
    };
  }

  factory MovieModel.fromMap(Map<String, dynamic> map) {
    final String dateString = map['release_date'];
    final List<String> dateNumbers = dateString.split("-");
    DateTime date = DateTime(0);
    if (dateNumbers.length > 2) {
      date = DateTime(
        int.parse(dateNumbers[0]),
        int.parse(dateNumbers[1]),
        int.parse(dateNumbers[2]),
      );
    }

    List<String> genres = [];
    if (map['genres'] is List) {
      for (var element in (map['genres'] as List)) {
        genres.add(element['name']);
      }
    }

    return MovieModel(
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      releaseDate: date,
      genres: genres,
      backdropPath: map['backdrop_path'] ?? '',
      adult: map['adult'] ?? false,
      popularity: map['popularity']?.toDouble() ?? 0.0,
      voteCount: map['vote_count']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory MovieModel.fromJson(String source) =>
      MovieModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MovieModel(id: $id, title: $title, releaseDate: $releaseDate, genres: $genres, backdropPath: $backdropPath, adult: $adult, popularity: $popularity, voteCount: $voteCount)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MovieModel &&
        other.id == id &&
        other.title == title &&
        other.releaseDate == releaseDate &&
        listEquals(other.genres, genres) &&
        other.backdropPath == backdropPath &&
        other.adult == adult &&
        other.popularity == popularity &&
        other.voteCount == voteCount;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        releaseDate.hashCode ^
        genres.hashCode ^
        backdropPath.hashCode ^
        adult.hashCode ^
        popularity.hashCode ^
        voteCount.hashCode;
  }

  factory MovieModel.fromEntity(MovieEntity entity) {
    return MovieModel(
      id: entity.id,
      title: entity.title,
      releaseDate: DateTime(entity.year),
      genres: entity.genres,
      backdropPath: entity.cover,
      adult: entity.check,
      popularity: entity.popularity,
      voteCount: entity.likes,
    );
  }

  MovieEntity toEntity() {
    return MovieEntity(
      id: id,
      title: title,
      year: releaseDate.year,
      genres: genres,
      cover: backdropPath,
      check: adult,
      popularity: popularity,
      likes: voteCount,
    );
  }
}
