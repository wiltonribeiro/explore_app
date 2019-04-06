import 'package:explore_flutter/models/Photo.dart';
import 'package:explore_flutter/models/Quest.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PhotosAPI {

  final _headers = {"Authorization":"Client-ID <YOUR_API_KEY>"};

  Future<Photo> requestPhoto(String id) async {
    String url = "https://api.unsplash.com/photos/$id";
    var data = await http.get(url, headers: _headers);
    var jsonResult = json.decode(data.body);
    return new Photo.fromJSON(jsonResult);
  }

  Future<List<Photo>> requestPhotos(Quest quest, {int page = 1}) async {
    switch(quest.keyWord.toLowerCase()){
      case "popular":
        return _requestPhotoByPopularity(page: page);
        break;
      case "newest":
        return _requestPhotoByDate(page: page);
        break;
      default:
        return _requestPhotosByQuery(quest.keyWord, page: page);
        break;
    }
  }

  Future<List<Photo>> _requestPhotosByQuery(String query, {int page = 1}) async {
    String url = "https://api.unsplash.com/search/photos?page=$page&per_page=18&query=${query.replaceAll(" ", "+")}";
    var data = await http.get(url, headers: _headers);
    var jsonResult = json.decode(data.body);
    return _buildList(jsonResult["results"]);
  }

  Future<List<Photo>> _requestPhotoByPopularity({int page = 1}) async {
    String url = "https://api.unsplash.com/photos?page=$page&per_page=18&order_by=popular";
    var data = await http.get(url, headers: _headers);
    var jsonResult = json.decode(data.body);
    return _buildList(jsonResult);
  }

  Future<List<Photo>> _requestPhotoByDate({int page = 1}) async {
    String url = "https://api.unsplash.com/photos?page=$page&per_page=18&order_by=latest";
    var data = await http.get(url, headers: _headers);
    var jsonResult = json.decode(data.body);
    return _buildList(jsonResult);
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