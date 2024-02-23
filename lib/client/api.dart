import "dart:convert";

import "package:movie_app_example/constants/constants.dart";
import "package:movie_app_example/models/movie.dart";
import 'package:http/http.dart' as http;

class ApiService {
  static const trendingUrl =
      "https://api.themoviedb.org/3/trending/movie/day?api_key=${Constants.apiKey}";

  static const topUrl =
      "https://api.themoviedb.org/3/movie/top_rated?api_key=${Constants.apiKey}";

  //https://api.themoviedb.org/3/movie/upcoming
  static const upComingUrl =
      "https://api.themoviedb.org/3/movie/upcoming?api_key=${Constants.apiKey}";

  static const searchUrl =
      "https://api.themoviedb.org/3/search/movie?query=boss&include_adult=true&language=en-US&page=1&api_key=${Constants.apiKey}";

  Future<List<Movie>> getTrendingMovie() async {
    final reponse = await http.get(Uri.parse(trendingUrl));
    if (reponse.statusCode == 200) {
      final detectData = json.decode(reponse.body)['results'] as List;
      return detectData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Something Error');
    }
  }

  Future<List<Movie>> getTopMovie() async {
    final reponse = await http.get(Uri.parse(topUrl));
    if (reponse.statusCode == 200) {
      final detectData = json.decode(reponse.body)['results'] as List;
      return detectData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Something Error');
    }
  }

  Future<List<Movie>> getUpcomingMovie() async {
    final reponse = await http.get(Uri.parse(upComingUrl));
    if (reponse.statusCode == 200) {
      final detectData = json.decode(reponse.body)['results'] as List;
      return detectData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Something Error');
    }
  }

  Future<List<Movie>> getSearchMovie(String query) async {
    final response = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/search/movie?query=$query&include_adult=true&language=en-US&page=1&api_key=${Constants.apiKey}"));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Something error');
    }
  }
}
