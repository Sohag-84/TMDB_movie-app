// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_local_variable, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:tmdb_movie_app/components/cast_list_item.dart';
import 'package:tmdb_movie_app/models/cast_model.dart';

import 'package:tmdb_movie_app/services/api_service.dart';

class CastData extends StatelessWidget {
  final ProgramType programType;
  final int id;
  const CastData({
    Key? key,
    required this.programType,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiService().getCastApi(id: id, type: programType),
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          List<CastModel> castData = snapshot.data ?? [];
          return SizedBox(
            height: 125,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: castData.length,
              itemBuilder: (context, index) {
                return CastListItem(castItem: castData[index]);
              },
            ),
          );
        }
      },
    );
  }
}
