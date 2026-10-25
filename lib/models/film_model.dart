class FilmModel {
  final int id;
  final String title;
  final String overview;
  final String posterUrl;
  final double rating;
  final String releaseDate;

  FilmModel({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterUrl,
    required this.rating,
    required this.releaseDate,
  });

  factory FilmModel.fromJson(Map<String, dynamic> json) {
    final poster = json['poster_path'];
    return FilmModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '-',
      overview: (json['overview'] ?? '').toString().isEmpty
          ? 'Tidak ada sinopsis.'
          : json['overview'],
      posterUrl: (poster != null && poster.toString().isNotEmpty)
          ? 'https://image.tmdb.org/t/p/w500$poster'
          : '',
      rating: ((json['vote_average'] ?? 0) as num).toDouble(),
      releaseDate: json['release_date'] ?? '-',
    );
  }
}