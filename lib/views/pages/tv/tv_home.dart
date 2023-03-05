// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tmdb_movie_app/models/movie_models.dart';
import 'package:tmdb_movie_app/models/tv_model.dart';
import 'package:tmdb_movie_app/services/api_service.dart';
import 'package:tmdb_movie_app/views/pages/movie/components/movie_slider.dart';
import 'package:tmdb_movie_app/uitils/sized_box.dart';

import 'components/tv_category.dart';
import 'components/tv_slider.dart';

class TvHome extends StatefulWidget {
  const TvHome({Key? key}) : super(key: key);

  @override
  State<TvHome> createState() => _TvHomeState();
}

class _TvHomeState extends State<TvHome> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          5.h.ph,
          FutureBuilder(
            future: ApiService().getTvApi(TvType.airingToday),
            builder: (context, AsyncSnapshot snapshot) {
              List<TvModel> tvShowData = snapshot.data ?? [];
              if (snapshot.hasData) {
                return TvSlider(
                  tvShowList: tvShowData,
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
            "Popular TV Show",
            style: TextStyle(fontSize: 20.sp, color: Colors.white),
          ),
          5.h.ph,
          TvCategory(height: 200.h, tvType: TvType.popular),
          8.h.ph,
          Text(
            "Top Rated Show",
            style: TextStyle(fontSize: 20.sp, color: Colors.white),
          ),
          5.h.ph,
          TvCategory(height: 200.h, tvType: TvType.topRated),
          8.h.ph,
          Text(
            "On The Air",
            style: TextStyle(fontSize: 20.sp, color: Colors.white),
          ),
          5.h.ph,
          TvCategory(height: 200.h, tvType: TvType.onTheAir),
          5.h.ph,
        ],
      ),
    );
  }
}
