import 'package:cinemaze/models/discover_model.dart';
import 'package:cinemaze/screens/movie_detail.dart';
import 'package:cinemaze/variables/my_heading.dart';
import 'package:cinemaze/variables/variables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cinemaze/service/http_service.dart';
import 'package:flutter/foundation.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/painting.dart';

class NowPlayingWidget extends StatelessWidget {
  final HttpService httpService = new HttpService();

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        height: 250,
        width: MediaQuery.of(context).size.width,
        child: FutureBuilder(
          future: httpService.fetchNowPlaying(),
          builder: (BuildContext context,
              AsyncSnapshot<List<DiscoverModel>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              List<DiscoverModel> discoverModel = snapshot.data;
              return CarouselSlider(
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height * 0.25,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.8,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 4),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.easeIn,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                ),
                items: discoverModel.map((value) {
                  return Builder(
                    builder: (BuildContext context) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              CupertinoPageRoute(builder: (context) {
                            return MovieDetail(discoverModel: value);
                          }));
                        },
                        child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    width: double.infinity,
                                    height: double.infinity,
                                    child: Image.network(
                                        getImage(value.backdropPath),
                                        fit: BoxFit.fill),
                                  ),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.black.withOpacity(0),
                                            Colors.black.withOpacity(0.6),
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                        )),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            value.judul().toUpperCase(),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: fontSecondary
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      );
                    },
                  );
                }).toList(),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }

  getImage(String imageName) {
    return "https://www.themoviedb.org/t/p/w500/${imageName}";
  }
}
