import 'package:cinemaze/variables/variables.dart';
import 'package:cinemaze/widgets/appbar_widget.dart';
import 'package:cinemaze/widgets/now_playing.dart';
import 'package:cinemaze/widgets/genre.dart';
import 'package:cinemaze/widgets/popular_movie.dart';
import 'package:cinemaze/widgets/popular_tv.dart';
import 'package:flutter/material.dart';
class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppBarWidget(),
              NowPlayingWidget(),
              GenreWidget(),
              PopularMovieWidget(),
              // PopularTvWidget(),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}