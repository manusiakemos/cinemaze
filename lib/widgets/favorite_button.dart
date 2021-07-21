import 'package:cinemaze/models/favoritemovie.dart';
import 'package:cinemaze/models/movie_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:loquacious/loquacious.dart';
import 'package:loquacious/loquacious_query_builder.dart';

class FavoriteButton extends StatefulWidget {
  final MovieDetailModel movieDetailModel;

  FavoriteButton({this.movieDetailModel});

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFav = false;

  @override
  Widget build(BuildContext context) {
    MovieDetailModel _movieDetailModel = widget.movieDetailModel;

    return IconButton(
      icon: Icon(
        isFav ? Icons.favorite : Icons.favorite_border,
        color: Colors.red,
      ),
      onPressed: () async {
        await addToFav(_movieDetailModel);
        setState(() {
          isFav = !isFav;
        });
      },
    );
  }

  Future<void> addToFav(MovieDetailModel _movieDetailModel) async {
    var now = DateTime.now();
    Map<String, dynamic> _data = {
      "id": _movieDetailModel.id,
      "title" : _movieDetailModel.title,
      "poster_path" : _movieDetailModel.posterPath,
      "popularity" : _movieDetailModel.popularity,
      "created_at" : "${now.year}-${now.month}-${now.day} ${now.hour}:${now.minute}:${now.second}",
      "updated_at" : "${now.year}-${now.month}-${now.day} ${now.hour}:${now.minute}:${now.second}"
    };
    LQB.table("FAVORITE_MOVIES").insert(_data);

    // final fm = await FavoriteMovie.create(
    //   id: _movieDetailModel.id,
    //   popularity: _movieDetailModel.popularity.toString(),
    //   posterPath: _movieDetailModel.posterPath,
    //   title: _movieDetailModel.title
    // );

    getMovies();
  }

  void getMovies() async {
    final movies = await FavoriteMovie.all();
    debugPrint(movies.toString());
  }
}
