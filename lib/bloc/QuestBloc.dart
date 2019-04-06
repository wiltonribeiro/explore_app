import 'package:rxdart/rxdart.dart';
import 'package:explore_flutter/bloc/PhotosBloc.dart';
import 'package:explore_flutter/models/Quest.dart';
import 'package:explore_flutter/models/UserQuest.dart';
import 'package:explore_flutter/models/DefaultQuest.dart';

class QuestBloc {
  
  static QuestBloc _questBloc;

  factory QuestBloc(){
    if(_questBloc == null)
      _questBloc = new QuestBloc._();
    
    return _questBloc;
  }

  List<Quest> _questList;
  Quest _currentQuest;
  PublishSubject<Quest> _publishSubjectQuest;
  PublishSubject<List<Quest>> _publishSubjectQuestList;
  PhotosBloc _photosBloc;

  QuestBloc._(){
    _photosBloc = new PhotosBloc();
    _publishSubjectQuest = new PublishSubject<Quest>();
    _publishSubjectQuestList = new PublishSubject<List<Quest>>();
    _questList = [new DefaultQuest("Popular"), new DefaultQuest("Newest")];

    selectQuest(_questList.first);
  }

  Observable<List<Quest>> get listenQuestList => _publishSubjectQuestList.stream;

  Observable<Quest> get listenCurrentQuest => _publishSubjectQuest.stream;

  Quest get currentQuest => _currentQuest;

  List<Quest> get questList => _questList;

  bool addQuest(String questContent){
    var validation = _verifyEqualsQuestContent(questContent);
    if(validation) return !validation;

    Quest _userQuest = new UserQuest(questContent);
    _questList.add(_userQuest);
    _updateQuestList();

    selectQuest(_userQuest);
    return true;
  }

  void removeQuest(Quest quest){
    _questList.remove(quest);
    if(quest == _currentQuest){
      selectQuest(_questList.last);
    }

    _updateQuestList();
  }

  void selectQuest(Quest quest){
    _currentQuest = quest;
    _photosBloc.requestPhoto(quest);
    _updateCurrentQuest();
  }

  void _updateCurrentQuest(){
    _publishSubjectQuest.sink.add(_currentQuest);
  }

  void _updateQuestList(){
    _publishSubjectQuestList.sink.add(_questList);
  }

  bool _verifyEqualsQuestContent(String questContent){
    _questList.forEach((quest){
      if(quest.keyWord == questContent)
        return true;
    });

    return false;
  }

  void dispose(){
    _questBloc = null;
    _publishSubjectQuest.close();
    _publishSubjectQuestList.close();
  }

}