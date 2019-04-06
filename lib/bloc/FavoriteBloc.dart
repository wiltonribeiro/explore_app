import 'package:rxdart/rxdart.dart';
import 'package:explore_flutter/models/Photo.dart';
import 'package:explore_flutter/services/PhotosAPI.dart';
import 'package:explore_flutter/services/FavoritesPhotosCacheService.dart';

class FavoriteBloc {
  static FavoriteBloc _favoriteBloc;

  Map<String, Photo> _photos;
  PhotosAPI _photosAPI;
  FavoritesPhotosCacheService _cacheService;
  PublishSubject<Map<String,Photo>> _publishSubjectPhotos;
  PublishSubject<bool> _publishSubjectIsFav;

  factory FavoriteBloc(){
    if(_favoriteBloc == null)
      _favoriteBloc = new FavoriteBloc._();

    return _favoriteBloc;
  }

  FavoriteBloc._(){
    _photos = new Map();
    _photosAPI = new PhotosAPI();
    _cacheService = new FavoritesPhotosCacheService();
    _publishSubjectIsFav = new PublishSubject<bool>();
    _publishSubjectPhotos = new PublishSubject<Map<String,Photo>>();

    _loadAllFavorites();
  }

  Observable<Map<String, Photo>> get favoritesPhotosListen => _publishSubjectPhotos.stream;
  Observable<bool> get isFavListen => _publishSubjectIsFav.stream;

  void triggerIsFavorite(String id) async {
    bool isFav = false;
    var list = await _cacheService.getFavoriteList();
    for(var i = 0; i< list.length; i++) {
      if(list[i]==id) {
        isFav = true;
        break;
      }
    }
    _updateIsFav(isFav);
  }

  void triggerPhotosList(){
    Future.delayed(new Duration(milliseconds: 100), (){
       _loadAllFavorites();
    });
  }

  void _updateIsFav(bool isFav){
    _publishSubjectIsFav.sink.add(isFav);
  }

  void addToFavorite(String id) {
    _loadPhoto(id).then((p){
      _photos.putIfAbsent(p.id, () => p);
      _updateList();
    });

    _cacheService.favorite(id);
    _updateIsFav(true);
  }

  void removeFavorite(String id){
    _photos.remove(id);
    _cacheService.disfavor(id);
    _updateIsFav(false);
    _updateList();
  }

  void _loadAllFavorites() async {
    _photos.clear();
    List<String> ids = await _cacheService.getFavoriteList();

    if(ids.length == 0) _updateList();
    else {
      ids.forEach((id) async {
        if(!_photos.containsKey(id)){
          var p = await _loadPhoto(id);
          _photos.putIfAbsent(id, () => p);
        }
        _updateList();
      });
    }
  }

  Future<Photo> _loadPhoto(String id) async {
    return await _photosAPI.requestPhoto(id);
  }

  void _updateList(){
    _publishSubjectPhotos.sink.add(_photos);
  }

  void dispose(){
    _publishSubjectPhotos.close();
    _publishSubjectIsFav.close();
  }
}