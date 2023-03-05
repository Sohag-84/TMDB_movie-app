// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tmdb_movie_app/constant/constant.dart';
import 'package:tmdb_movie_app/models/cast_model.dart';

class CastListItem extends StatelessWidget {
  final CastModel castItem;
  const CastListItem({Key? key, required this.castItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4.w),
      child: Column(
        children: [
          ClipOval(
            child: CachedNetworkImage(
              height: 80.h,
              width: 80.w,
              fit: BoxFit.fill,
              imageUrl: movieImgBaseUrl + castItem.profilePath.toString(),
              placeholder: (context, url) =>
                  Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          Text(
            castItem.name.toString(),
            style: TextStyle(color: Colors.white, fontSize: 12.sp),
          ),
          Text(
            castItem.knownForDepartment.toString(),
            style: TextStyle(color: Colors.white, fontSize: 10.sp),
          ),
        ],
      ),
    );
  }
}
