import 'package:shared_preferences/shared_preferences.dart';

class FavoritesPhotosCacheService {

  SharedPreferences _prefs;

  void favorite(String id) async {
    var list = await getFavoriteList();
    list.add(id);

    _saveList(list);
  }

  void disfavor(String value) async {
    var list = await getFavoriteList();
    list.remove(value);

    _saveList(list);
  }

  Future<List<String>> getFavoriteList() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs.getStringList("favoritesPhotos") ?? new List();
  }

  void _saveList(List<String> list){
    _prefs.setStringList("favoritesPhotos", list);
  }

}