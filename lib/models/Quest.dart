import 'package:explore_flutter/models/Photo.dart';

abstract class Quest {

  List<Photo> _photos;
  String _keyWord;

  Quest(this._keyWord){
    this._photos = new List();
  }

  String get keyWord => _keyWord;

  List<Photo> get photos => _photos;

  void addListPhoto(List<Photo> data){
    this._photos.addAll(data);
  }

  void addPhoto(Photo photo){
    _photos.add(photo);
  }

  bool isLoaded(){
    return _photos.length>0;
  }

}