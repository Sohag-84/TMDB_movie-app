// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tmdb_movie_app/constant/constant.dart';
import 'package:tmdb_movie_app/models/movie_models.dart';
import 'package:tmdb_movie_app/uitils/sized_box.dart';

class MovieItem extends StatelessWidget {
  final MovieModel movieItem;
  const MovieItem({Key? key, required this.movieItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110.w,
      margin: EdgeInsets.all(3.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(7.r),
            child: CachedNetworkImage(
              height: 120.h,
              width: 110.w,
              fit: BoxFit.fill,
              imageUrl: movieImgBaseUrl + movieItem.posterPath.toString(),
              placeholder: (context, url) =>
                  Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          Text(
            movieItem.title.toString(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          5.h.ph,
          Row(
            children: [
              RatingBarIndicator(
                itemCount: 5,
                rating: movieItem.voteAverage ?? 0,
                itemSize: 12.h,
                itemBuilder: (context, index) {
                  return Icon(
                    Icons.star,
                    color: Colors.amber,
                  );
                },
              ),
              5.pw,
              Text(
                movieItem.voteAverage == null
                    ? ""
                    : movieItem.voteAverage.toString(),
                style: TextStyle(color: Colors.white),
              ),
            ],
          )
        ],
      ),
    );
  }
}
