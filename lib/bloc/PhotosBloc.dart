import 'package:rxdart/rxdart.dart';
import 'package:explore_flutter/models/Photo.dart';
import 'package:explore_flutter/repositories/PhotosRepository.dart';
import 'package:explore_flutter/models/Quest.dart';

class PhotosBloc {

  static PhotosBloc _photosBloc;

  factory PhotosBloc(){
    if(_photosBloc == null)
      _photosBloc = new PhotosBloc._();

    return _photosBloc;
  }

  PhotosRepository _photosRepository;
  PublishSubject<bool> _publishSubjectLoadedPhotos;
  bool _currentStatus = false;

  PhotosBloc._(){
    _photosRepository = new PhotosRepository();
    _publishSubjectLoadedPhotos = PublishSubject<bool>();
  }

  Observable<bool> get photosLoadingStatus => _publishSubjectLoadedPhotos.stream;


  void requestPhoto(Quest quest) async {
    _updateStatus(false);
    if(!quest.isLoaded()){
      List<Photo> photos =  await _photosRepository.requestPhoto(quest);
      quest.addListPhoto(photos);
    }
    _updateStatus(true);
  }

  void _updateStatus(bool status){
    _currentStatus = status;
    _publishSubjectLoadedPhotos.sink.add(_currentStatus);
  }

  bool get currentStatus => _currentStatus;

  dispose(){
    _publishSubjectLoadedPhotos.close();
  }

}