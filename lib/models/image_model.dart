// To parse this JSON data, do
//
//     final imageModel = imageModelFromJson(jsonString);

import 'dart:convert';

ImageModel imageModelFromJson(String str) => ImageModel.fromJson(json.decode(str));

String imageModelToJson(ImageModel data) => json.encode(data.toJson());

class ImageModel {
  ImageModel({
    this.backdrops,
    this.id,
    this.posters,
  });

  List<Backdrop> backdrops;
  int id;
  List<Backdrop> posters;

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
    backdrops: json["backdrops"] == null ? null : List<Backdrop>.from(json["backdrops"].map((x) => Backdrop.fromJson(x))),
    id: json["id"] == null ? null : json["id"],
    posters: json["posters"] == null ? null : List<Backdrop>.from(json["posters"].map((x) => Backdrop.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "backdrops": backdrops == null ? null : List<dynamic>.from(backdrops.map((x) => x.toJson())),
    "id": id == null ? null : id,
    "posters": posters == null ? null : List<dynamic>.from(posters.map((x) => x.toJson())),
  };
}

class Backdrop {
  Backdrop({
    this.aspectRatio,
    this.filePath,
    this.height,
    this.iso6391,
    this.voteAverage,
    this.voteCount,
    this.width,
  });

  double aspectRatio;
  String filePath;
  int height;
  String iso6391;
  double voteAverage;
  int voteCount;
  int width;

  factory Backdrop.fromJson(Map<String, dynamic> json) => Backdrop(
    aspectRatio: json["aspect_ratio"] == null ? null : json["aspect_ratio"].toDouble(),
    filePath: json["file_path"] == null ? null : json["file_path"],
    height: json["height"] == null ? null : json["height"],
    iso6391: json["iso_639_1"] == null ? null : json["iso_639_1"],
    voteAverage: json["vote_average"] == null ? null : json["vote_average"].toDouble(),
    voteCount: json["vote_count"] == null ? null : json["vote_count"],
    width: json["width"] == null ? null : json["width"],
  );

  Map<String, dynamic> toJson() => {
    "aspect_ratio": aspectRatio == null ? null : aspectRatio,
    "file_path": filePath == null ? null : filePath,
    "height": height == null ? null : height,
    "iso_639_1": iso6391 == null ? null : iso6391,
    "vote_average": voteAverage == null ? null : voteAverage,
    "vote_count": voteCount == null ? null : voteCount,
    "width": width == null ? null : width,
  };
}
