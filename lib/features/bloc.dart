import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:roof/network/network.dart';

import 'package:rxdart/rxdart.dart';

import 'model/user_model.dart';

class PhotoBloc {
  final APIRepo api = APIRepo();
  int pageNumber = 1;
  double pixels = 0.0;

  ReplaySubject<List<User>> _subject = ReplaySubject();

  final ReplaySubject<ScrollNotification> _controller = ReplaySubject();

  Observable<List<User>> get stream => _subject.stream;
  Sink<ScrollNotification> get sink => _controller.sink;

  PhotoBloc() {
    // _subject.addStream(Observable.fromFuture(api.getUsers(pageNumber)));
    _subject.addStream(Observable.fromFuture(api.getUsers(pageNumber)));

    _controller.listen((notification) => loadPhotos(notification));
  }

  Future<void> loadPhotos([
    ScrollNotification notification,
  ]) async {
    if (notification.metrics.pixels == notification.metrics.maxScrollExtent &&
        pixels != notification.metrics.pixels) {
      pixels = notification.metrics.pixels;

      pageNumber++;
      List<User> list = await api.getUsers(pageNumber);
      _subject.sink.add(list);
    }
  }

  void dispose() {
    _controller.close();
    _subject.close();
  }
}
