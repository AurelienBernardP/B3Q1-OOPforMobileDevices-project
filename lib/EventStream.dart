import 'dart:async';

class EventStream {
  
  static final EventStream _singleton = EventStream._internal();

  StreamController _controller;
  Stream _stream ;

  factory EventStream(){
    return _singleton;
  }

  EventStream._internal(){
   _controller = StreamController() ;
   _stream = _controller.stream;
  }

  StreamController getController() => _controller;
  Stream getStream() => _stream;
}