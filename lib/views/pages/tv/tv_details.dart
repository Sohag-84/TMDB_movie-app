// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tmdb_movie_app/constant/constant.dart';
import 'package:tmdb_movie_app/models/tv_model.dart';
import 'package:tmdb_movie_app/models/video_model.dart';
import 'package:tmdb_movie_app/services/api_service.dart';
import 'package:tmdb_movie_app/uitils/sized_box.dart';
import 'package:tmdb_movie_app/components/cast_data.dart';
import 'package:tmdb_movie_app/views/pages/tv/components/tv_category.dart';
import 'package:url_launcher/url_launcher.dart';

class TvDetails extends StatelessWidget {
  final TvModel tvData;
  const TvDetails({Key? key, required this.tvData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 94, 91, 91),
      appBar: AppBar(
        elevation: 0,
        title: Text(tvData.name.toString()),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                CachedNetworkImage(
                  width: double.infinity,
                  fit: BoxFit.fill,
                  imageUrl: movieImgBaseUrl + tvData.backdropPath.toString(),
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                FutureBuilder(
                    future: ApiService().getVideosApi(
                      id: tvData.id ?? 0,
                      type: ProgramType.tv,
                    ),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        List<VideoModel> videos = snapshot.data ?? [];
                        if (videos.isNotEmpty) {
                          return IconButton(
                            onPressed: () async {
                              if (!await launchUrl(
                                Uri.parse(
                                    "https://www.youtube.com/embed/${videos[0].key}"),
                              )) {
                                throw Exception("Could not found");
                              }
                            },
                            icon: Icon(
                              Icons.play_circle,
                              size: 35,
                              color: Colors.amber,
                            ),
                          );
                        }
                      }
                      return Container();
                    })
              ],
            ),
            5.h.ph,
            Container(
              padding: EdgeInsets.all(8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tvData.name.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 17.sp,
                    ),
                  ),
                  5.h.ph,
                  Row(
                    children: [
                      RatingBarIndicator(
                        itemCount: 10,
                        rating: tvData.voteAverage ?? 0,
                        itemSize: 14.h,
                        itemBuilder: (context, index) {
                          return Icon(
                            Icons.star,
                            color: Colors.amber,
                          );
                        },
                      ),
                      4.pw,
                      Text(
                        tvData.voteAverage == null
                            ? ""
                            : tvData.voteAverage.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 12.sp),
                      ),
                      Spacer(),
                      Text(
                        "Released:- ${tvData.firstAirDate}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                  10.h.ph,
                  Text(
                    tvData.overview.toString(),
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.white.withOpacity(.80),
                    ),
                  ),
                  8.h.ph,
                  Text(
                    "Cast",
                    style: TextStyle(fontSize: 20.sp, color: Colors.white),
                  ),
                  5.h.ph,
                  CastData(
                    programType: ProgramType.tv,
                    id: tvData.id ?? 0,
                  ),
                  8.h.ph,
                  Text(
                    "Similar TV Show",
                    style: TextStyle(fontSize: 20.sp, color: Colors.white),
                  ),
                  5.h.ph,
                  TvCategory(height: 200.h, tvType: TvType.similar,tvShowId: tvData.id?? 0,),
                  
                  5.h.ph,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
