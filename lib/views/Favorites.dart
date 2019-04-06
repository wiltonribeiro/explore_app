import 'package:flutter/material.dart';
import 'package:explore_flutter/models/Photo.dart';
import 'package:explore_flutter/components/CustomPhotoGridItem.dart';
import 'package:explore_flutter/bloc/FavoriteBloc.dart';

class Favorites extends StatefulWidget {
  _Favorites createState() => new _Favorites();
}

class _Favorites extends State<Favorites> {

  FavoriteBloc _favoriteBloc;

  @override
  void initState() {
    _favoriteBloc = new FavoriteBloc();
    _favoriteBloc.triggerPhotosList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(backgroundColor: Colors.white, body:
        new Container(margin: EdgeInsets.all(10), child:
          new StreamBuilder(stream: _favoriteBloc.favoritesPhotosListen, builder: (context, AsyncSnapshot<Map<String,Photo>> snapshot) {
            var list = snapshot.data == null ? null : snapshot.data.values.toList();
            if(list == null) return new Center(child: new CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.black)));
            else if(list.length == 0) return new Center(child: _noFav());
            else return
              new GridView.builder(
                itemCount: list.length, gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemBuilder: (BuildContext context, int index) {
                  return new Padding(padding: EdgeInsets.all(10), child: new CustomPhotoGridItem(photo: list[index]));
                }
            );
          })
        )
    );
  }

  Widget _noFav(){
    return new Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      new Padding(padding: EdgeInsets.all(20), child:
        new Image.asset("assets/images/heartbroken.png", width: MediaQuery.of(context).size.width*0.3)
      ),
      new Text("There's no favorite images here", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey))
    ]);
  }

}