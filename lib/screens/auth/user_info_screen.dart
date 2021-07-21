import 'dart:convert';

import 'package:cinemaze/models/favoritemovie.dart';
import 'package:cinemaze/providers/refresh_provider.dart';
import 'package:cinemaze/providers/user_provider.dart';
import 'package:cinemaze/variables/variables.dart';
import 'package:cinemaze/widgets/movie_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shape_of_view/shape_of_view.dart';

class UserInfoScreen extends StatefulWidget {
  final bool isMovie;

  const UserInfoScreen({Key key, this.isMovie = true}) : super(key: key);

  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  ScrollController _scrollController = new ScrollController();
  List<FavoriteMovie> listMovies = [];

  @override
  void initState() {
    super.initState();
    fetchMovies();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> fetchMovies() async {
    final fM = await FavoriteMovie.all();
    if(mounted){
      setState(() {
        listMovies = [];
        listMovies.addAll(fM);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String _imageName = "assets/images/bg.png";
    String _title =
        widget.isMovie ? "Your Favorite Movies" : "Your Favorite TV Series";

    Provider.of<RefreshProvider>(context, listen: true).addListener(() {
      fetchMovies();
    });

    return Consumer(
      builder: (BuildContext context, RefreshProvider data, child) {
        return Scaffold(
          body: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                floating: true,
                pinned: false,
                snap: true,
                elevation: 0,
                collapsedHeight: MediaQuery.of(context).size.height * 0.25,
                backgroundColor: Colors.white.withAlpha(0).withOpacity(0),
                expandedHeight: MediaQuery.of(context).size.height * 0.35,
                flexibleSpace: Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: Stack(children: [
                    ShapeOfView(
                        elevation: 0,
                        shape: ArcShape(
                            direction: ArcDirection.Outside,
                            height: 30,
                            position: ArcPosition.Bottom),
                        child: Image.asset(
                          _imageName,
                          fit: BoxFit.cover,
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                        )),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: SafeArea(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Consumer<UserProvider>(
                                builder: (BuildContext context,
                                    UserProvider userProvider, child) {
                                  return Container(
                                      child: Center(
                                          child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.network(
                                        userProvider.userData.photoURL),
                                  )));
                                },
                              ),
                              Container(
                                  margin: EdgeInsets.only(bottom: 5),
                                  child: Center(
                                    child: Text(
                                      _title,
                                      style: headingSliver,
                                    ),
                                  )),
                            ]),
                      ),
                    ),
                  ]),
                ),
                // leading: SizedBox(),
              ),
              SliverGrid(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.5,
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 0,
                  childAspectRatio: 2 / 3,
                ),
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MovieList(
                      id: listMovies[index].id,
                      title: listMovies[index].title,
                      posterPath: listMovies[index].posterPath,
                      popularity: listMovies[index].popularity,
                    ),
                  );
                }, childCount: listMovies.length),
              ),
            ],
          ),
        );
      },
    );
  }
}
