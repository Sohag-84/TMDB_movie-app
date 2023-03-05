// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tmdb_movie_app/models/tv_model.dart';
import 'package:tmdb_movie_app/views/pages/tv/tv_details.dart';

import '../../../../constant/constant.dart';

class TvSlider extends StatelessWidget {
  final List<TvModel> tvShowList;
  const TvSlider({Key? key, required this.tvShowList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: tvShowList.length,
      itemBuilder: (context, index, realIndex) {
        return InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TvDetails(tvData: tvShowList[index]),
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: CachedNetworkImage(
              width: double.infinity,
              fit: BoxFit.fill,
              imageUrl:
                  movieImgBaseUrl + tvShowList[index].posterPath.toString(),
              placeholder: (context, url) =>
                  Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
        );
      },
      options: CarouselOptions(
        height: 180.h,
        autoPlay: true,
        enlargeCenterPage: true,
        aspectRatio: 12 / 9,
      ),
    );
  }
}
