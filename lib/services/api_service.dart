import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tmdb_movie_app/constant/constant.dart';
import 'package:tmdb_movie_app/models/cast_model.dart';
import 'package:tmdb_movie_app/models/movie_models.dart';
import 'package:tmdb_movie_app/models/tv_model.dart';
import 'package:tmdb_movie_app/models/video_model.dart';

enum MovieType { nowPlaying, popular, topRated, upcoming, similar }

enum TvType { airingToday, onTheAir, topRated, popular, similar }

enum ProgramType { tv, movie }

class ApiService {
  Future<List<MovieModel>> getMovieApi(MovieType type, {movieId = 0}) async {
    String url = "";

    if (type == MovieType.nowPlaying) {
      url = baseUrl + nowPlayingMovieUrl;
    } else if (type == MovieType.popular) {
      url = baseUrl + popularMovieUrl;
    } else if (type == MovieType.topRated) {
      url = baseUrl + topRatedMovieUrl;
    } else if (type == MovieType.upcoming) {
      url = baseUrl + upcomingMovieUrl;
    } else if (type == MovieType.similar) {
      url = baseUrl + movieId.toString() + similarUrl;
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

  Future<List<TvModel>> getTvApi(TvType type) async {
    String url = "";

    if (type == TvType.airingToday) {
      url = tvBaseUrl + airingTodayTvUrl;
    } else if (type == TvType.popular) {
      url = tvBaseUrl + popularMovieUrl;
    } else if (type == TvType.topRated) {
      url = tvBaseUrl + topRatedMovieUrl;
    } else if (type == TvType.onTheAir) {
      url = tvBaseUrl + onTheAirTvUrl;
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
        List<TvModel> tvShowList =
            body.map((tvData) => TvModel.fromJson(tvData)).toList();
        return tvShowList;
      } else {
        throw "No Tv show found";
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<VideoModel>> getVideosApi({
    required int id,
    required ProgramType type,
  }) async {
    String url = "";

    if (type == ProgramType.tv) {
      url = tvBaseUrl + id.toString() + videosUrl;
    } else if (type == ProgramType.movie) {
      url = baseUrl + id.toString() + videosUrl;
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
        List<VideoModel> videoList =
            body.map((videoData) => VideoModel.fromJson(videoData)).toList();
        return videoList;
      } else {
        throw "No video found";
      }
    } catch (e) {
      throw e.toString();
    }
  }
  Future<List<CastModel>> getCastApi({
    required int id,
    required ProgramType type,
  }) async {
    String url = "";

    if (type == ProgramType.tv) {
      url = tvBaseUrl + id.toString() + creditUlr;
    } else if (type == ProgramType.movie) {
      url = baseUrl + id.toString() + creditUlr;
    }

    try {
      http.Response response = await http.get(
        Uri.parse(
          "$url?api_key=99ac2298b20a80432c1d0f8618e51601&language=en-US",
        ),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body.toString());
        List<dynamic> body = json['cast'];
        List<CastModel> castList =
            body.map((castData) => CastModel.fromJson(castData)).toList();
        return castList;
      } else {
        throw "No cast found";
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
