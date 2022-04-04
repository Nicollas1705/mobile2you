abstract class SearchMovieError implements Exception {}

class SearchMovieInvalidResult extends SearchMovieError {}

class SearchMovieInvalidMovieId extends SearchMovieError {}
