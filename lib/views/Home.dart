import 'package:flutter/material.dart';
import 'package:explore_flutter/components/SearchWidget.dart';
import 'package:explore_flutter/models/Quest.dart';
import 'package:explore_flutter/components/QuestWidget.dart';
import 'package:explore_flutter/bloc/QuestBloc.dart';
import 'package:explore_flutter/components/GridCustomPhoto.dart';

class Home extends StatefulWidget {
  _Home createState() => new _Home();
}

class _Home extends State<Home>{

  ScrollController _scrollController = new ScrollController();
  QuestBloc _questBloc = new QuestBloc();
  
  @override
  Widget build(BuildContext context) {
    
    return new Scaffold(backgroundColor: Colors.white, body:
      new SingleChildScrollView(child:
        new Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.max, children: <Widget>[
          new Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1, left: 20, bottom: 20), child:
            new Text("Explore", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 60)),
          ),
          new Container(margin: EdgeInsets.only(top: 40, right: 20), width: double.infinity, height: 80, child:
            new ListView(shrinkWrap: true, scrollDirection: Axis.horizontal, physics: NeverScrollableScrollPhysics(), reverse: true, children: <Widget>[
              new SearchWidget(),
              new Container(width: MediaQuery.of(context).size.width - MediaQuery.of(context).size.height*0.05 - 30, color: Colors.white70, margin: EdgeInsets.only(right: 10), child:
                new StreamBuilder(initialData: _questBloc.questList, stream: _questBloc.listenQuestList, builder: (context, AsyncSnapshot<List<Quest>> snapshot){
                  _moveScrollToEnd();
                  return new ListView(controller: _scrollController, shrinkWrap: true, scrollDirection: Axis.horizontal,
                    children: snapshot.data.map((q){
                      return new QuestWidget(quest: q);
                    }).toList()
                  );
                })
              )
            ])
          ),
          new StreamBuilder(initialData: _questBloc.currentQuest, stream: _questBloc.listenCurrentQuest, builder: (context, AsyncSnapshot<Quest> snapshot){
            return new GridCustomPhoto(quest: snapshot.data);
          })
        ])
      )
    );
  }

  void _moveScrollToEnd(){
    new Future.delayed(Duration(seconds: 0), (){
      _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: Duration(milliseconds: 250), curve: Curves.ease);
    });
  }

}