import 'package:cinemaze/models/discover_model.dart';
import 'package:cinemaze/models/favoritemovie.dart';
import 'package:cinemaze/models/movie_detail_model.dart';
import 'package:cinemaze/screens/movie_detail.dart';
import 'package:cinemaze/widgets/Rating.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'favorite_button.dart';

class MovieList extends StatelessWidget {
  final int id;
  final String title;
  final String posterPath;
  final double popularity;

  MovieList({this.id, this.title, this.posterPath, this.popularity});

  String getImage(String imageName){
    return "https://www.themoviedb.org/t/p/w500/$imageName";
  }


  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> jS = {
      "id" : id,
      "title" : title,
      "poster_path" : posterPath,
      "popularity" : popularity
    };
    MovieDetailModel mDM = MovieDetailModel.fromJson(jS);
    DiscoverModel dM = DiscoverModel.fromJson(jS);
    return GestureDetector(
        onTap: (){
          Navigator.push(context, CupertinoPageRoute(builder: (context)=> MovieDetail(discoverModel: dM)));
        },
        child: Container(
          child: Stack(
              children:[
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: FadeInImage.assetNetwork(
                    placeholder: "assets/loading.gif",
                    image: getImage(posterPath),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black26,
                              Colors.black.withAlpha(0)
                            ]
                        )
                    ),
                  ),
                ),
                Positioned(
                    right: 0,
                    child:Container(
                      margin: EdgeInsets.only(top: 8),
                      child: Rating(rating: mDM.popularity, isBold: true,),
                    )
                ),
              ]
          ),
        )
    );
  }
}
