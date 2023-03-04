// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tmdb_movie_app/models/tv_model.dart';
import 'package:tmdb_movie_app/services/api_service.dart';

import 'tv_item_list.dart';

class TvCategory extends StatelessWidget {
  final double height;
  final TvType tvType;
  const TvCategory({
    Key? key,
    required this.height,
    required this.tvType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ApiService().getTvApi(tvType),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            List<TvModel> tvShowList = snapshot.data ?? [];
            return SizedBox(
              height: height,
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: tvShowList.length,
                itemBuilder: (context, index) {
                  return TvItem(tvItem: tvShowList[index]);
                },
              ),
            );
          }
        });
  }
}
