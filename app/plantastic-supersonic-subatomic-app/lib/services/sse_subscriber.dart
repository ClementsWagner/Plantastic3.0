import 'dart:async';
import 'dart:convert';
import 'package:universal_html/html.dart' as html;

class SseSubscriber<T> {
  Uri _connection;
  html.EventSource _eventSource;
  StreamController<T> streamController;
  Function fromJson;

  SseSubscriber(String uri, Function fromJson) {
    this.streamController = StreamController<T>();
    this.fromJson = fromJson;
    this._connection = Uri.parse(uri);
    connect();
  }

  SseSubscriber connect() {
    Uri uri = _connection;
    bool withCredentials = false;
    bool closeOnError = true;
    streamController = StreamController<T>();
    _eventSource =
        html.EventSource(uri.toString(), withCredentials: withCredentials);

    _eventSource.addEventListener('message', (html.Event message) {
      var st = ((message as html.MessageEvent).data as String);
      Map map = json.decode(st) as Map;

      streamController.add(fromJson(map));
    });

    if (closeOnError) {
      _eventSource.onError.listen((event) {
        _eventSource?.close();
        streamController.addError(event);
        streamController?.close();
      });
    }
    return this;
  }

  Stream get stream => streamController.stream;

  bool isClosed() =>
      this.streamController == null || this.streamController.isClosed;

  void close() {
    this._eventSource?.close();
    this.streamController?.close();
  }
}
