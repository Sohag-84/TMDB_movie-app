// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tmdb_movie_app/models/movie_models.dart';
import 'package:tmdb_movie_app/services/api_service.dart';
import 'package:tmdb_movie_app/views/pages/movie/components/movie_item.dart';

class MovieCategory extends StatelessWidget {
  final double height;
  final MovieType movieType;
  const MovieCategory({
    Key? key,
    required this.height,
    required this.movieType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ApiService().getMovieApi(movieType),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            List<MovieModel> movieList = snapshot.data ?? [];
            return SizedBox(
              height: height,
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: movieList.length,
                itemBuilder: (context, index) {
                  return MovieItem(movieItem: movieList[index]);
                },
              ),
            );
          }
        });
  }
}
