import 'dart:convert';

import 'package:movie_app_example/constants/constants.dart';
import 'package:movie_app_example/models/movie.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app_example/models/video_movie.dart';

class ApiVideo {
  static const videoApiUrl =
      "https://api.themoviedb.org/3/movie/866398/videos?api_key=${Constants.apiKey}";

  Future<VideoMovie> getVideo(Movie movie) async {
    print(movie.id);
    final reponse = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/movie/${movie.id}/videos?api_key=${Constants.apiKey}"));
    if (reponse.statusCode == 200) {
      final List<dynamic> results = json.decode(reponse.body)['results'];
      if (results.length > 1) {
        final Map<String, dynamic> secondResult = results[1];
        return VideoMovie.fromJson(secondResult);
      } else {
        throw Exception('Second result not found');
      }
    } else {
      throw Exception('Something Error');
    }
  }
}
