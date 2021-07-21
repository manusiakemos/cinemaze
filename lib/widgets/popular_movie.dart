import 'dart:ui';

import 'package:cinemaze/models/discover_model.dart';
import 'package:cinemaze/screens/allmovie_screen.dart';
import 'package:cinemaze/screens/movie_detail.dart';
import 'package:cinemaze/services/http_service.dart';
import 'package:cinemaze/variables/my_heading.dart';
import 'package:cinemaze/variables/variables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class PopularMovieWidget extends StatelessWidget {
  final HttpService httpService = new HttpService();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: paddingSmall),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("MOST POPULAR MOVIES", style: MyHeading(headingStyleCustom: HeadingStyle.m)),
              TextButton(
                  child: Text("Show All",
                    style: TextStyle(color: Colors.teal.withOpacity(0.9), fontWeight: FontWeight.bold),
                  ),
                  onPressed: (){
                    //move to popular movies with loadmore
                    Navigator.push(context,
                      CupertinoPageRoute(builder: (context) => AllMovieScreen(isMovie: true,))
                    );
                  }
              )
            ],
          )
        ),
        Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height * 0.27,
            width: MediaQuery.of(context).size.width,
            child: FutureBuilder(
              future: httpService.fetchPopularMovie(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<DiscoverModel>> snapshot) {
                if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {

                  List<DiscoverModel> discoverModel = snapshot.data;
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: discoverModel.length,
                    itemBuilder: (BuildContext context, int index){
                      return Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(context, CupertinoPageRoute(builder: (context){
                              return MovieDetail(discoverModel : discoverModel[index]);
                            }));
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: FadeInImage.assetNetwork(
                                placeholder: "assets/loading.gif",
                                fit: BoxFit.cover,
                                image: getImage(discoverModel[index].posterPath),
                            )
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            )),
      ],
    );
  }

  getImage(String imageName)
  {
    return "https://www.themoviedb.org/t/p/w200/${imageName}";
  }
}
