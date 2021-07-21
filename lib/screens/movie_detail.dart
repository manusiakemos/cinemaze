import 'package:cinemaze/models/discover_model.dart';
import 'package:cinemaze/models/image_model.dart';
import 'package:cinemaze/models/movie_detail_model.dart';
import 'package:cinemaze/services/http_service.dart';
import 'package:cinemaze/variables/variables.dart';
import 'package:cinemaze/widgets/favorite_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shape_of_view/shape/arc.dart';
import 'package:shape_of_view/shape_of_view.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieDetail extends StatefulWidget {
  final DiscoverModel discoverModel;

  MovieDetail({this.discoverModel});

  @override
  _MovieDetailState createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  final HttpService httpService = new HttpService();

  MovieDetailModel movieDetailModel;

  getImage(String imageName) {
    return "https://www.themoviedb.org/t/p/w500/$imageName";
  }

  void _launchURL() async {
    var url = movieDetailModel.homepage;
    await launch(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder(
          future: httpService.fetchMovieDetail(
              widget.discoverModel.id, widget.discoverModel.title != null),
          builder: (context, AsyncSnapshot<MovieDetailModel> snapshot) {
            if (snapshot.hasData) {
              movieDetailModel = snapshot.data;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          ShapeOfView(
                              elevation: 0,
                              shape: ArcShape(
                                  direction: ArcDirection.Outside,
                                  height: 40,
                                  position: ArcPosition.Bottom),
                              child: Image.network(
                                  getImage(movieDetailModel.backdropPath),
                                  fit: BoxFit.fill,
                                  width: double.infinity)),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.3,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                  Colors.black54,
                                  Colors.black.withAlpha(0)
                                ])),
                            child: SafeArea(
                              child: Container(
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconButton(
                                          iconSize: 24,
                                          icon: Icon(
                                            Icons.arrow_back_ios,
                                            color: textSecondary,
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                        FavoriteButton(
                                          movieDetailModel: movieDetailModel,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: MediaQuery.of(context).size.height * 0.19,
                            left: 10,
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(paddingMedium),
                              child: Image.network(
                                getImage(movieDetailModel.posterPath),
                                height:
                                    MediaQuery.of(context).size.height * 0.23,
                              ),
                            ),
                          ),
                          Positioned(
                              width: MediaQuery.of(context).size.width * 0.63,
                              top: MediaQuery.of(context).size.height * 0.29,
                              left: MediaQuery.of(context).size.width * 0.37,
                              child: Container(
                                  padding: EdgeInsets.all(paddingMedium),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 4),
                                        child: Text(
                                          movieDetailModel.judul(),
                                          maxLines: 1,
                                          softWrap: false,
                                          overflow: TextOverflow.fade,
                                          style: headingPrimary,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 4),
                                            child: Row(
                                              children: [
                                                Icon(Icons.star,
                                                    color: Colors.amber),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: paddingSmall,
                                                      right: paddingLarge),
                                                  child: Text(
                                                      movieDetailModel
                                                          .voteAverage
                                                          .toString(),
                                                      style: textMuted),
                                                ),
                                              ],
                                            ),
                                          ),
                                          showRunTime(movieDetailModel)
                                        ],
                                      ),
                                      Container(
                                        height: 30,
                                        child: MovieDetailGenre(
                                          movieDetailModel: movieDetailModel,
                                        ),
                                      )
                                    ],
                                  ))),
                          Positioned(
                            width: 130,
                            right: MediaQuery.of(context).size.width * 0.05,
                            top: MediaQuery.of(context).size.height * 0.235,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.teal)),
                              onPressed: () {
                                _launchURL();
                              },
                              child: Text(
                                "HOMEPAGE",
                                style: headingPrimaryWhite,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(paddingMedium),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: Container(
                                padding: EdgeInsets.all(paddingSmall),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    MyInfoList(
                                      label: "RELEASE DATE",
                                      value: movieDetailModel.tanggalRilis(),
                                    ),
                                    MyInfoList(
                                      label: "STATUS",
                                      value: movieDetailModel.status,
                                    ),
                                    MyInfoList(
                                        label: "LANGUAGE",
                                        value: movieDetailModel.originalLanguage
                                            .toUpperCase()),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 30),
                                      child: Text("STORYLINE",
                                          style: headingPrimary),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: paddingMedium),
                                      child: Text(
                                        movieDetailModel.overview,
                                        style: TextStyle(
                                            color: Colors.black45,
                                            fontFamily: fontPrimary),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 30),
                                      child:
                                          Text("PHOTO", style: headingPrimary),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: paddingMedium),
                                      child: FutureBuilder(
                                        future: httpService.fetchImages(
                                            movieDetailModel.id,
                                            movieDetailModel.title != null),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<ImageModel>
                                                snapshot) {
                                          if (snapshot.hasData) {
                                            ImageModel imageModel =
                                                snapshot.data;
                                            List<Backdrop> backdrop =
                                                imageModel.backdrops;
                                            return Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.2,
                                              child: ListView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  children: backdrop.map((e) {
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 4),
                                                      child: ClipRRect(
                                                        borderRadius: BorderRadius.circular(10),
                                                        child: Image.network(
                                                            getImage(e.filePath),
                                                            fit: BoxFit.cover),
                                                      ),
                                                    );
                                                  }).toList()),
                                            );
                                          } else {
                                            return Center(
                                              child: Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: colorSecondary,
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  showRunTime(MovieDetailModel movieDetailModel) {
    if (movieDetailModel.runtime != null) {
      return Container(
        child: Row(
          children: [
            Icon(Icons.access_time, color: Colors.teal),
            Padding(
              padding: EdgeInsets.only(left: paddingSmall, right: paddingLarge),
              child: Text("${movieDetailModel.runtime.toString()} min",
                  style: textMuted),
            ),
          ],
        ),
      );
    }
    return SizedBox();
  }
}

class MyInfoList extends StatelessWidget {
  MyInfoList({this.label, this.value = "UNKNOWN"});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: paddingSmall),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(label, style: headingPrimarySmall),
          Padding(
            padding: EdgeInsets.only(left: paddingSmall),
            child: Text(value, style: textMuted, textAlign: TextAlign.start),
          )
        ],
      ),
    );
  }
}

class MovieDetailGenre extends StatelessWidget {
  const MovieDetailGenre({this.movieDetailModel});

  final MovieDetailModel movieDetailModel;

  @override
  Widget build(BuildContext context) {
    List<Genre> movieDetailGenre = movieDetailModel.genres;
    if (movieDetailModel.genres != null && movieDetailModel.genres.length > 0) {
      return ListView(
        scrollDirection: Axis.horizontal,
        children: movieDetailGenre.map((e) {
          return Container(
            height: 5,
            padding: EdgeInsets.symmetric(
                horizontal: paddingMedium, vertical: paddingSmall),
            margin: EdgeInsets.only(right: paddingLarge),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Colors.black87, Colors.black])),
            child: Center(
              child: Text(
                e.name,
                style: TextStyle(color: textWhite, fontSize: fontSizeSmall),
              ),
            ),
          );
        }).toList(),
      );
    }
    return Text("No Genre");
  }
}
