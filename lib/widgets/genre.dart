import 'dart:ui';

import 'package:cinemaze/models/genre_model.dart';
import 'package:cinemaze/services/http_service.dart';
import 'package:cinemaze/variables/my_heading.dart';
import 'package:cinemaze/variables/variables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GenreWidget extends StatelessWidget {
  final HttpService httpService = new HttpService();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("GENRES",
                      style: MyHeading(headingStyleCustom: HeadingStyle.m)),
                ],
              )),
          Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              child: FutureBuilder(
                future: httpService.fetchGenre(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<GenreModel>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    List<GenreModel> genreModel = snapshot.data;
                    return Container(
                        padding: const EdgeInsets.all(5),
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        child: ListView.builder(
                          itemCount: genreModel.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return MyListItem(genreModel: genreModel[index]);
                          },
                        ));
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              )),
        ],
      ),
    );
  }
}

class MyListItem extends StatelessWidget {
  final GenreModel genreModel;

  MyListItem({this.genreModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.black87, Colors.black])),
      padding: EdgeInsets.all(paddingLarge),
      margin: EdgeInsets.all(paddingSmall),
      child: Center(
        child: Text(
          genreModel.name,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}
