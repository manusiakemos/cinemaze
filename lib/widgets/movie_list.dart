import 'package:cinemaze/models/discover_model.dart';
import 'package:cinemaze/models/favoritemovie.dart';
import 'package:cinemaze/models/movie_detail_model.dart';
import 'package:cinemaze/screens/movie_detail.dart';
import 'package:flutter/cupertino.dart';

import 'favorite_button.dart';

class MovieList extends StatelessWidget {
  final int id;
  final String title;
  final String posterPath;
  final String popularity;

  MovieList({this.id, this.title, this.posterPath, this.popularity});

  String getImage(String imageName){
    return "https://www.themoviedb.org/t/p/w500/$imageName";
  }


  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> jS = {
      "id" : id,
      "title" : title
    };
    MovieDetailModel mDM = MovieDetailModel.fromJson(jS);
    DiscoverModel dM = DiscoverModel.fromJson(jS);
    return GestureDetector(
        onTap: (){
          Navigator.push(context, CupertinoPageRoute(builder: (context)=> MovieDetail(discoverModel: dM)));
        },
        child: Stack(
            children:[
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FadeInImage.assetNetwork(
                  placeholder: "assets/loading.gif",
                  image: getImage(posterPath),
                ),
              ),
              Positioned(
                child: FavoriteButton(movieDetailModel: mDM),
              )
            ]
        )
    );
  }
}
