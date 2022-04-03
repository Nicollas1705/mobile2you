class MovieEntity {
  final int id;
  final String title;
  final int year;
  final List<String> genres;
  final String cover;
  final bool check;
  final double popularity;
  final int likes;

  MovieEntity({
    required this.id,
    required this.title,
    required this.year,
    required this.genres,
    required this.cover,
    required this.check,
    required this.popularity,
    required this.likes,
  });
}
