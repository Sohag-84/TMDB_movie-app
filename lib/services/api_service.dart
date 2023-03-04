import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tmdb_movie_app/constant/constant.dart';
import 'package:tmdb_movie_app/models/movie_models.dart';

enum MovieType { nowPlaying, popular, topRated, upcoming }

class ApiService {
  Future<List<MovieModel>> getMovieApi(MovieType type) async {
    String url = "";

    if (type == MovieType.nowPlaying) {
      url = baseUrl + nowPlayingMovieUrl;
    } else if (type == MovieType.popular) {
      url = baseUrl + popularMovieUrl;
    } else if (type == MovieType.topRated) {
      url = baseUrl + topRatedMovieUrl;
    } else if (type == MovieType.upcoming) {
      url = baseUrl + upcomingMovieUrl;
    }

    try {
      http.Response response = await http.get(
        Uri.parse(
          "$url?api_key=99ac2298b20a80432c1d0f8618e51601&language=en-US",
        ),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body.toString());
        List<dynamic> body = json['results'];
        List<MovieModel> movieList =
            body.map((movieData) => MovieModel.fromJson(movieData)).toList();
        return movieList;
      } else {
        throw "No movie found";
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
