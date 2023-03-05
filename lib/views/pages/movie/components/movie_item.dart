// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tmdb_movie_app/constant/constant.dart';
import 'package:tmdb_movie_app/models/movie_models.dart';
import 'package:tmdb_movie_app/uitils/sized_box.dart';
import 'package:tmdb_movie_app/views/pages/movie/movie_details.dart';

class MovieItem extends StatelessWidget {
  final MovieModel movieItem;
  const MovieItem({Key? key, required this.movieItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetails(movieData: movieItem),
          ),
        );
      },
      child: Container(
        width: 125.w,
        height: 200,
        margin: EdgeInsets.all(3.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(7.r),
              child: CachedNetworkImage(
                height: 160.h,
                width: 150.w,
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
                  itemCount: 10,
                  rating: movieItem.voteAverage ?? 0,
                  itemSize: 8.h,
                  itemBuilder: (context, index) {
                    return Icon(
                      Icons.star,
                      color: Colors.amber,
                    );
                  },
                ),
                2.pw,
                Text(
                  movieItem.voteAverage == null
                      ? ""
                      : movieItem.voteAverage.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 12.sp),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
