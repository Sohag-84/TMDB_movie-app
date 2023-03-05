// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tmdb_movie_app/models/movie_models.dart';
import 'package:tmdb_movie_app/services/api_service.dart';
import 'package:tmdb_movie_app/views/pages/movie/components/movie_category.dart';
import 'package:tmdb_movie_app/views/pages/movie/components/movie_slider.dart';
import 'package:tmdb_movie_app/uitils/sized_box.dart';

class MovieHome extends StatefulWidget {
  const MovieHome({Key? key}) : super(key: key);

  @override
  State<MovieHome> createState() => _MovieHomeState();
}

class _MovieHomeState extends State<MovieHome> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          5.h.ph,
          FutureBuilder(
            future: ApiService().getMovieApi(MovieType.nowPlaying),
            builder: (context, AsyncSnapshot snapshot) {
              List<MovieModel> movieData = snapshot.data ?? [];
              if (snapshot.hasData) {
                return MovieSlider(
                  movieList: movieData,
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          8.h.ph,
          Text(
            "Popular Movie",
            style: TextStyle(fontSize: 20.sp, color: Colors.white),
          ),
          5.h.ph,
          MovieCategory(height: 200.h, movieType: MovieType.popular),
          8.h.ph,
          Text(
            "Top Rated Movie",
            style: TextStyle(fontSize: 20.sp, color: Colors.white),
          ),
          5.h.ph,
          MovieCategory(height: 200.h, movieType: MovieType.topRated),
          8.h.ph,
          Text(
            "Upcoming Movie",
            style: TextStyle(fontSize: 20.sp, color: Colors.white),
          ),
          5.h.ph,
          MovieCategory(height: 200.h, movieType: MovieType.upcoming),
          5.h.ph,
        ],
      ),
    );
  }
}
