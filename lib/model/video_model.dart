// To parse this JSON data, do
//
//     final videomodel = videomodelFromJson(jsonString);

import 'dart:convert';

List<Videomodel> videomodelFromJson(String str) =>
    List<Videomodel>.from(json.decode(str).map((x) => Videomodel.fromJson(x)));

String videomodelToJson(List<Videomodel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Videomodel {
  Videomodel(
      {this.id,
      this.url,
      this.isDownloaded,
      this.localPathDirectory,
      this.title});

  final int id;
  final String url;
  bool isDownloaded;
  String localPathDirectory;
  final String title;

  factory Videomodel.fromJson(Map<String, dynamic> json) => Videomodel(
        id: json["id"] == null ? null : json["id"],
        url: json["url"] == null ? null : json["url"],
        title: json["title"] == null ? null : json["title"],
        isDownloaded:
            json["isDownloaded"] == null ? null : json["isDownloaded"],
        localPathDirectory: json["localPathDirectory"] == null
            ? null
            : json["localPathDirectory"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "url": url == null ? null : url,
        "title": title == null ? null : title,
        "isDownloaded": isDownloaded == null ? null : isDownloaded,
        "localPathDirectory":
            localPathDirectory == null ? null : localPathDirectory,
      };
}
