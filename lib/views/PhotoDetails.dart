import 'package:flutter/material.dart';
import 'package:explore_flutter/models/Photo.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:explore_flutter/bloc/FavoriteBloc.dart';
import 'dart:ui';

class PhotoDetails extends StatefulWidget {
  final Photo photo;
  PhotoDetails({Key key, this.photo}) : super(key:key);

  @override
  _PhotoDetails createState() => new _PhotoDetails();

}

class _PhotoDetails extends State<PhotoDetails> {

  FavoriteBloc _favoriteBloc;

  @override
  void initState() {
    _favoriteBloc = new FavoriteBloc();
    _favoriteBloc.triggerIsFavorite(widget.photo.id);
    super.initState();
  }


  void _favorite() {
    _favoriteBloc.addToFavorite(widget.photo.id);
  }

  void _disfavor(){
    _favoriteBloc.removeFavorite(widget.photo.id);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(backgroundColor: Colors.transparent, body:
      new Stack(children: <Widget>[
            new Stack(children: <Widget>[
              new BackdropFilter(
                filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: new Container(
                  decoration: new BoxDecoration(color: Colors.black.withOpacity(0.5)),
                ),
              )
            ]),
        new SafeArea(child:
          new SingleChildScrollView(child:
            new Container(padding: EdgeInsets.all(20), child:
                new Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                  new Hero(tag: "photo${widget.photo.id}", child:
                    new ClipRRect(borderRadius: BorderRadius.circular(20), child: new FadeInImage.memoryNetwork(placeholder: kTransparentImage, image: widget.photo.smallURL, width: MediaQuery.of(context).size.width))
                  ),
                  new Container(margin: EdgeInsets.only(top: 10, left: 5, right: 5), child:
                    new Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                      new Row(children: <Widget>[
                        new Padding(padding: EdgeInsets.only(right: 5), child: new Icon(Icons.place, color: Colors.white)),
                        new Text(widget.photo.author.location ?? "Not defined", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12))
                      ]),
                      new Row(children: <Widget>[
                        new Padding(padding: EdgeInsets.only(right: 10), child: new Text(widget.photo.author.name.split(" ")[0], style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12))),
                        new ClipOval(child: new Image.network(widget.photo.author.profileImage, height: 25, width: 25))
                      ]),
                    ])
                  ),
                  new Padding(padding: EdgeInsets.only(top: 20, left: 5, right: 5), child:
                      new Column(children: <Widget>[
                        new SizedBox(width: double.infinity, child:
                          new RaisedButton.icon(icon: Icon(Icons.file_download, color: Colors.black), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),onPressed: () async {
                            //TODO download image
                          }, label: new Text("DOWNLOAD", style: TextStyle(fontWeight: FontWeight.bold)), color: Colors.white)
                        ),
                        new StreamBuilder(initialData: false, stream: _favoriteBloc.isFavListen, builder: (context, AsyncSnapshot<bool> snapshot){
                          String _favTextContent;
                          Color _favButtonColor;
                          Color _favTextColor;

                          if(snapshot.data) {
                              _favTextContent = "DISFAVOR";
                              _favButtonColor = Colors.white;
                              _favTextColor = Colors.black;
                          } else {
                            _favTextContent = "FAVORITE";
                            _favButtonColor = const Color(0xFFf84545);
                            _favTextColor = Colors.white;
                          }

                          return new SizedBox(width: double.infinity, child:
                            new RaisedButton.icon(icon: Icon(Icons.favorite, color: _favTextColor), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),onPressed: () async {
                              if(snapshot.data)
                                _disfavor();
                              else
                                _favorite();
                            }, label: new Text(_favTextContent, style: TextStyle(fontWeight: FontWeight.bold, color: _favTextColor)), color: _favButtonColor)
                          );
                        })
                      ])
                  )
                ])
            )
          )
        )
      ])
    );
  }

}