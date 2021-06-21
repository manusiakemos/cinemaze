// To parse this JSON data, do
//
//     final trendingModel = trendingModelFromJson(jsonString);

import 'dart:convert';

PopularModel trendingModelFromJson(String str) => PopularModel.fromJson(json.decode(str));

String trendingModelToJson(PopularModel data) => json.encode(data.toJson());

class PopularModel {
  PopularModel({
    this.originalLanguage,
    this.originalTitle,
    this.posterPath,
    this.genreIds,
    this.voteAverage,
    this.title,
    this.voteCount,
    this.video,
    this.backdropPath,
    this.id,
    this.overview,
    this.releaseDate,
    this.firstAirDate,
    this.adult,
    this.name,
    this.popularity,
    this.mediaType,
  });

  String originalLanguage;
  String originalTitle;
  String posterPath;
  List<int> genreIds;
  double voteAverage;
  String title;
  String name;
  int voteCount;
  bool video;
  String backdropPath;
  int id;
  String overview;
  DateTime releaseDate;
  DateTime firstAirDate;
  bool adult;
  double popularity;
  String mediaType;

  String judul (){
    return name != null ? name : title;
  }

  String tanggalRilis(){
    return releaseDate != null ? releaseDate.year.toString() : firstAirDate.year.toString();
  }

  factory PopularModel.fromJson(Map<String, dynamic> json) => PopularModel(
    originalLanguage: json["original_language"] == null ? null : json["original_language"],
    originalTitle: json["original_title"] == null ? null : json["original_title"],
    posterPath: json["poster_path"] == null ? null : json["poster_path"],
    genreIds: json["genre_ids"] == null ? null : List<int>.from(json["genre_ids"].map((x) => x)),
    voteAverage: json["vote_average"] == null ? null : json["vote_average"].toDouble(),
    title: json["title"] == null ? null : json["title"],
    name: json["name"] == null ? null : json["name"],
    voteCount: json["vote_count"] == null ? null : json["vote_count"],
    video: json["video"] == null ? null : json["video"],
    backdropPath: json["backdrop_path"] == null ? null : json["backdrop_path"],
    id: json["id"] == null ? null : json["id"],
    overview: json["overview"] == null ? null : json["overview"],
    releaseDate: json["release_date"] == null ? null : DateTime.parse(json["release_date"]),
    firstAirDate: json["first_air_date"] == null ? null : DateTime.parse(json["first_air_date"]),
    adult: json["adult"] == null ? null : json["adult"],
    popularity: json["popularity"] == null ? null : json["popularity"].toDouble(),
    mediaType: json["media_type"] == null ? null : json["media_type"],
  );

  Map<String, dynamic> toJson() => {
    "original_language": originalLanguage == null ? null : originalLanguage,
    "original_title": originalTitle == null ? null : originalTitle,
    "poster_path": posterPath == null ? null : posterPath,
    "genre_ids": genreIds == null ? null : List<dynamic>.from(genreIds.map((x) => x)),
    "vote_average": voteAverage == null ? null : voteAverage,
    "title": title == null ? null : title,
    "name": name == null ? null : name,
    "vote_count": voteCount == null ? null : voteCount,
    "video": video == null ? null : video,
    "backdrop_path": backdropPath == null ? null : backdropPath,
    "id": id == null ? null : id,
    "overview": overview == null ? null : overview,
    "release_date": releaseDate == null ? null : "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
    "first_air_date": firstAirDate == null ? null : "${firstAirDate.year.toString().padLeft(4, '0')}-${firstAirDate.month.toString().padLeft(2, '0')}-${firstAirDate.day.toString().padLeft(2, '0')}",
    "adult": adult == null ? null : adult,
    "popularity": popularity == null ? null : popularity,
    "media_type": mediaType == null ? null : mediaType,
  };
}
