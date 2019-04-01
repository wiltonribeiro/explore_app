import 'package:flutter/material.dart';
import 'package:explore_flutter/models/Quest.dart';
import 'package:explore_flutter/models/DefaultQuest.dart';
import 'package:explore_flutter/bloc/QuestBloc.dart';

class QuestWidget extends StatelessWidget {

  final Quest quest;
  final QuestBloc _questBloc = new QuestBloc();
  QuestWidget({@required this.quest});

  @override
  Widget build(BuildContext context) {
    return new Container(padding: EdgeInsets.only(left: 20, right: 10), child:
        new Row(children: <Widget>[
          new GestureDetector(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                new Text(this.quest.keyWord, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                new StreamBuilder(initialData: _questBloc.currentQuest, stream: _questBloc.listenCurrentQuest, builder: (context, AsyncSnapshot<Quest> snapshot) {
                  return new AnimatedOpacity(opacity: snapshot.data == this.quest ? 1 : 0, duration: Duration(milliseconds: 200), child:
                      new ClipOval(child: new Container(height: 5, width: 5, color: Colors.black))
                  );
                })
              ]
            ),
            onTap: (){
              _questBloc.selectQuest(this.quest);
            },
          ),
          this.quest is DefaultQuest ? new Container(height: 0, width: 0) :
            new Container(padding: EdgeInsets.only(left: 5, bottom: 10), child:
              new InkWell(
                splashColor: Colors.transparent,
                child: new Icon(Icons.close, size: 15, color: Colors.grey),
                onTap: (){
                  _questBloc.removeQuest(this.quest);
                },
              )
            )
        ])
    );
  }

}