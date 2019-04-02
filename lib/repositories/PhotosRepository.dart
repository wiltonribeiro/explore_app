import 'package:explore_flutter/models/Photo.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class PhotosRepository {


  Future<List<Photo>> requestPhotosByQuery(String query) async {
    String data = await rootBundle.loadString("assets/data/photoTemplate.json");
    var jsonResult = json.decode(data);
    return _buildList(jsonResult["results"]);
  }

  List<Photo> requestPhotoByPopularity(){

  }

  List<Photo> requestPhotoByDate(){

  }

  List<Photo> _buildList(List data){
    List<Photo> photos = new List();
    data.forEach((d){
      Photo p = new Photo.fromJSON(d);
      photos.add(p);
    });
    return photos;
  }

}