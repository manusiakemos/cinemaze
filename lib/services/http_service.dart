import 'dart:convert';
import 'package:cinemaze/models/discover_model.dart';
import 'package:cinemaze/models/image_model.dart';
import 'package:cinemaze/models/movie_detail_model.dart';
import 'package:cinemaze/models/popular_model.dart';
import 'package:cinemaze/models/genre_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class HttpService {
  final String apiKey = "c53bb17532fdb88ca2ca8f386db91841";
  //nowPlaying

  Future<List<DiscoverModel>> fetchNowPlaying() async {
    final String nowPlayingUrl = "https://api.themoviedb.org/3/movie/now_playing?api_key=$apiKey";
    var res = await http.get((Uri.parse(nowPlayingUrl)));
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body)['results'];
      List<DiscoverModel> discover =
          body.map((dynamic item) => DiscoverModel.fromJson(item)).toList();
      return discover;
    } else {
      throw "Unable to retrieve discover data.";
    }
  }

  //PopularTv

  Future<List<DiscoverModel>> fetchPopularTv() async {
    final String popularUrl =
        "https://api.themoviedb.org/3/discover/tv?api_key=$apiKey&sort_by=popularity.desc&page=1";
    var res = await http.get((Uri.parse(popularUrl)));
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body)['results'];
      List<DiscoverModel> popular =
          body.map((dynamic item) => DiscoverModel.fromJson(item)).toList();
      return popular;
    } else {
      throw "Unable to retrieve trending data.";
    }
  }

  //MovieDetail
  Future<MovieDetailModel> fetchMovieDetail(int id, bool isMovie) async {
    String key = "$apiKey";
    String movieDetailUrl;
    if(isMovie){
      movieDetailUrl = "https://api.themoviedb.org/3/movie/${id.toString()}?api_key=$key";
    }else{
      movieDetailUrl = "https://api.themoviedb.org/3/tv/$id?api_key=$key";
    }
    var res = await http.get((Uri.parse(movieDetailUrl)));
    MovieDetailModel movieDetailModel;
    movieDetailModel = movieDetailModelFromJson(res.body);
    if (res.statusCode == 200) {
      return movieDetailModel;
    } else {
      throw Exception("Unable to retrieve trending data.");
    }
  }

  Future<ImageModel> fetchImages(int id, bool isMovie) async {
    String key = "$apiKey";
    String movieDetailUrl;
    if(isMovie){
      movieDetailUrl = "https://api.themoviedb.org/3/movie/${id.toString()}/images?api_key=$key";
    }else{
      movieDetailUrl = "https://api.themoviedb.org/3/tv/${id}/images?api_key=$key";
    }
    var res = await http.get((Uri.parse(movieDetailUrl)));
    ImageModel imageModel;
    imageModel = imageModelFromJson(res.body);
    if (res.statusCode == 200) {
      return imageModel;
    } else {
      throw Exception("Unable to retrieve trending data.");
    }
  }


  //popularMovie
  Future<List<DiscoverModel>> fetchPopularMovie({String page = "1"}) async {
    final String popularMovie = "https://api.themoviedb.org/3/discover/movie?api_key=$apiKey&sort_by=popularity.desc&page=$page";
    var res = await http.get((Uri.parse(popularMovie)));
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body)['results'];
      List<DiscoverModel> popular =
      body.map((dynamic item) => DiscoverModel.fromJson(item)).toList();
      return popular;
    } else {
      throw "Unable to retrieve popular movie data.";
    }
  }

  //Genre
  Future<List<GenreModel>> fetchGenre() async {
    final String genreUrl =
        "https://api.themoviedb.org/3/genre/movie/list?api_key=$apiKey&language=en-US";
    var res = await http.get((Uri.parse(genreUrl)));
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body)['genres'];
      List<GenreModel> genres =
          body.map((dynamic item) => GenreModel.fromJson(item)).toList();
      return genres;
    } else {
      throw "Unable to retrieve genre data.";
    }
  }
}
