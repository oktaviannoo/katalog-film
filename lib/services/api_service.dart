import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/film_model.dart';

class ApiService {
  static const String apiKey = 'd52274433406910705ecfb0db76400ac';
  static const String baseUrl = 'https://api.themoviedb.org/3';

  Future<List<FilmModel>> fetchFilms() {
    return _getFilms('$baseUrl/movie/top_rated?api_key=$apiKey');
  }

  Future<List<FilmModel>> searchFilms(String query) {
    final q = Uri.encodeQueryComponent(query);
    return _getFilms('$baseUrl/search/movie?api_key=$apiKey&query=$q');
  }

  Future<List<FilmModel>> _getFilms(String url) async {
    final response = await http
        .get(Uri.parse(url))
        .timeout(const Duration(seconds: 15));

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      final List list = decoded['results'];
      return list.map((e) => FilmModel.fromJson(e)).toList();
    } else {
      throw Exception('Gagal memuat data (kode ${response.statusCode})');
    }
  }
}