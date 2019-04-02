import 'package:explore_flutter/models/Author.dart';

class Photo {
  String id;
  String createdAt;
  int width;
  int height;
  String color;
  String description;
  String altDescription;
  String thumbURL;
  String largeURL;
  String regularURL;
  String downloadURL;
  Author author;

  Photo.fromJSON(Map<String, dynamic> data){
    this.id = data["id"];
    this.createdAt = data["created_at"];
    this.width = data["width"];
    this.height = data["height"];
    this.color = data["color"];
    this.description = data["description"];
    this.altDescription = data["alt_description"];
    this.thumbURL = data["urls"]["thumb"];
    this.largeURL = data["urls"]["full"];
    this.regularURL = data["urls"]["regular"];
    this.downloadURL = data["links"]["download"];
    this.author = new Author.fromJSON(data["user"]);
  }

  @override
  String toString() {
    return 'Photo{id: $id, createdAt: $createdAt, width: $width, height: $height, color: $color, description: $description, altDescription: $altDescription, thumbURL: $thumbURL, largeURL: $largeURL, downloadURL: $downloadURL, author: $author}';
  }


}