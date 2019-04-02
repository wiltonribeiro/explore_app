import 'package:flutter/material.dart';
import 'package:explore_flutter/models/Quest.dart';
import 'package:explore_flutter/models/Photo.dart';

class GridCustomPhoto extends StatelessWidget {

  final Quest quest;

  GridCustomPhoto({Key key, this.quest}) : super(key:key);

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
          new ClipRRect(borderRadius: BorderRadius.circular(20), child:
            new Image.network(p1.thumbURL, height: (MediaQuery.of(context).size.width*0.6 - 10)/2, width: (MediaQuery.of(context).size.width*0.6 - 10)/2, fit: BoxFit.cover)
          )
        ),
        new Container(margin: EdgeInsets.only(top: 10, left: 20), child:
          new ClipRRect(borderRadius: BorderRadius.circular(20), child:
            new Image.network(p2.thumbURL, height: (MediaQuery.of(context).size.width*0.6 - 10)/2, width: (MediaQuery.of(context).size.width*0.6 - 10)/2, fit: BoxFit.cover)
          )
        ),
      ]),
      new Container(margin: EdgeInsets.only(top: 10, left: 10), child:
        new ClipRRect(borderRadius: BorderRadius.circular(20), child:
          new Image.network(p3.regularURL, height: MediaQuery.of(context).size.width*0.6, width: (MediaQuery.of(context).size.width*0.6 - 10), fit: BoxFit.cover)
        )
      ),
    ]);
  }

  Widget _buildEqualSizeGrid(BuildContext context, Photo p1, Photo p2, Photo p3){
    return new Row(children: <Widget>[
      new Container(margin: EdgeInsets.only(top: 10, left: 20), child:
        new ClipRRect(borderRadius: BorderRadius.circular(20), child:
          new Image.network(p1.regularURL, height: (MediaQuery.of(context).size.width - 60)/3, width: (MediaQuery.of(context).size.width - 60)/3, fit: BoxFit.cover)
        )
      ),
      new Container(margin: EdgeInsets.only(top: 10, left: 10), child:
        new ClipRRect(borderRadius: BorderRadius.circular(20), child:
          new Image.network(p2.regularURL, height: (MediaQuery.of(context).size.width - 60)/3, width: (MediaQuery.of(context).size.width - 60)/3, fit: BoxFit.cover)
        )
      ),
      new Container(margin: EdgeInsets.only(top: 10, left: 10), child:
        new ClipRRect(borderRadius: BorderRadius.circular(20), child:
          new Image.network(p3.regularURL, height: (MediaQuery.of(context).size.width - 60)/3, width: (MediaQuery.of(context).size.width - 60)/3, fit: BoxFit.cover)
        )
      ),
    ]);
  }


}