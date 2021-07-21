import 'package:cinemaze/models/favoritemovie.dart';
import 'package:cinemaze/models/movie_detail_model.dart';
import 'package:cinemaze/providers/refresh_provider.dart';
import 'package:flutter/material.dart';
import 'package:loquacious/loquacious.dart';
import 'package:loquacious/loquacious_query_builder.dart';
import 'package:provider/provider.dart';

class FavoriteButton extends StatefulWidget {
  final dynamic movieDetailModel;

  FavoriteButton({this.movieDetailModel});

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();

}

class _FavoriteButtonState extends State<FavoriteButton> {

  bool isFav = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    MovieDetailModel _movieDetailModel = widget.movieDetailModel;
    setIsFav(_movieDetailModel);

    return IconButton(
      icon: Icon(
        isFav ? Icons.favorite : Icons.favorite_border,
        color: Colors.red,
      ),
      onPressed: () async {
        //jika sdh difavoritkan maka hapus
        if(isFav){
          await removeFav(_movieDetailModel);
        }else{
          //jika belum, tambahkan ke favorit
          await addToFav(_movieDetailModel);
        }

        if (!mounted) return;

        if (mounted) {
          setState(() {
            isFav = !isFav;
          });
        }

        Provider.of<RefreshProvider>(context,listen: false).refreshPage();

      },
    );
  }

  Future<void> addToFav(MovieDetailModel movieDetailModel) async {
    var now = DateTime.now();
    Map<String, dynamic> _data = {
      "id": movieDetailModel.id,
      "title" : movieDetailModel.title,
      "poster_path" : movieDetailModel.posterPath,
      "popularity" : movieDetailModel.popularity,
      "created_at" : "${now.year}-${now.month}-${now.day} ${now.hour}:${now.minute}:${now.second}",
      "updated_at" : "${now.year}-${now.month}-${now.day} ${now.hour}:${now.minute}:${now.second}"
    };
    await LQB.table("FAVORITE_MOVIES").insert(_data);

    getMovies();
  }

  void getMovies() async {
    final movies = await FavoriteMovie.all();
  }


  Future<void> removeFav(MovieDetailModel movieDetailModel) async {
    LQB.table("FAVORITE_MOVIES").where("id", movieDetailModel.id).delete();
  }

  Future<void> setIsFav(MovieDetailModel movieDetailModel) async {
    final data = await FavoriteMovie.find(movieDetailModel.id);
    if(data != null){
      if(data.id == movieDetailModel.id){
        if (!mounted) return;

        if(mounted){
          setState(() {
            isFav = true;
          });
        }
      }
    }
  }
}
