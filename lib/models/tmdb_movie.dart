class TmdbMovie {
  final String title;
  final double rating;
  final String overview;
  final String year;

  TmdbMovie(this.title, this.rating, this.overview, this.year);

  factory TmdbMovie.fromJson(Map<String, dynamic> json) {
    return TmdbMovie(
      json['title'],
      double.parse(json['vote_average'].toString()),
      json['overview'],
      json['release_date'].substring(0, 4),
    );
  }
}
