import 'dart:ui';

import 'package:cinemaze/models/genre_model.dart';
import 'package:cinemaze/services/http_service.dart';
import 'package:cinemaze/variables/my_heading.dart';
import 'package:cinemaze/variables/variables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GenreWidget extends StatefulWidget {
  @override
  _GenreWidgetState createState() => _GenreWidgetState();
}

class _GenreWidgetState extends State<GenreWidget> {
  final HttpService httpService = new HttpService();

  List<GenreModel> _genreModel = [];

  @override
  void initState() {
    super.initState();
    this.getGenres();
  }

  getGenres() async {
    _genreModel = await httpService.fetchGenre();
    setState(() {

    });
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Wrap(
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
            height: 150,
            alignment: Alignment.center,
            child: GridView.count(
              primary: true,
              padding: const EdgeInsets.all(8),
              crossAxisCount: 2,
              scrollDirection: Axis.horizontal,
              childAspectRatio: 9/16,
              children:
                  _genreModel.map((e) => MyListItem(genreModel: e)).toList(),
            ),
          ),
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
    return Column(children: [
      GestureDetector(
        onTap: (){
          debugPrint(genreModel.id.toString());
        },
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.black87, Colors.black])),
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.all(paddingSmall),
          child: Text(
            genreModel.name,
            softWrap: false,
            overflow: TextOverflow.fade,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
          ),
        ),
      ),
    ]);
  }
}
