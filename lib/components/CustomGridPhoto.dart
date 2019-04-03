import 'package:flutter/material.dart';
import 'package:explore_flutter/models/Quest.dart';
import 'package:explore_flutter/models/Photo.dart';
import 'package:explore_flutter/components/CustomPhotoGridItem.dart';

class CustomGridPhoto extends StatelessWidget {

  final Quest quest;

  CustomGridPhoto({Key key, this.quest}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return new Wrap(direction: Axis.horizontal, children: _buildGrid(context));
  }

  List<Widget> _buildGrid(BuildContext context){
    List<Widget> widgets = new List();
    List<Photo> p = this.quest.photos;
    for(var i = 0; p.length - i > 3; i+=3){
      if(i%2==0)
        widgets.add(_buildDifferentSizeGrid(context, p[i], p[i+1], p[i+2]));
      else
        widgets.add(_buildEqualSizeGrid(context, p[i], p[i+1], p[i+2]));
    }
    return  widgets;
  }

  Widget _buildDifferentSizeGrid(BuildContext context, Photo p1, Photo p2, Photo p3){
    return new Row(children: <Widget>[
      new Column(children: <Widget>[
        new Container(margin: EdgeInsets.only(top: 10, left: 20), child:
          new CustomPhotoGridItem(photo: p1, height: (MediaQuery.of(context).size.width*0.6 - 10)/2, width: (MediaQuery.of(context).size.width*0.6 - 10)/2)
        ),
        new Container(margin: EdgeInsets.only(top: 10, left: 20), child:
          new CustomPhotoGridItem(photo: p2, height: (MediaQuery.of(context).size.width*0.6 - 10)/2, width: (MediaQuery.of(context).size.width*0.6 - 10)/2)
        ),
      ]),
      new Container(margin: EdgeInsets.only(top: 10, left: 10), child:
        new CustomPhotoGridItem(photo: p3, height: MediaQuery.of(context).size.width*0.6, width: (MediaQuery.of(context).size.width*0.6 - 10))
      ),
    ]);
  }

  Widget _buildEqualSizeGrid(BuildContext context, Photo p1, Photo p2, Photo p3){
    return new Row(children: <Widget>[
      new Container(margin: EdgeInsets.only(top: 10, left: 20), child:
        new CustomPhotoGridItem(photo: p1, height: (MediaQuery.of(context).size.width - 60)/3, width: (MediaQuery.of(context).size.width - 60)/3)
      ),
      new Container(margin: EdgeInsets.only(top: 10, left: 10), child:
        new CustomPhotoGridItem(photo:p2, height: (MediaQuery.of(context).size.width - 60)/3, width: (MediaQuery.of(context).size.width - 60)/3)
      ),
      new Container(margin: EdgeInsets.only(top: 10, left: 10), child:
        new CustomPhotoGridItem(photo:p3, height: (MediaQuery.of(context).size.width - 60)/3, width: (MediaQuery.of(context).size.width - 60)/3)
      ),
    ]);
  }

}