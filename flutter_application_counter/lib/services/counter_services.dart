import 'dart:async';

class CounterService{
 final StreamController<int> _counterController = StreamController<int>.broadcast();
  int _counter = 0;

  Stream<int> get counterStream => _counterController.stream;

  StreamSink<int> get sink => _counterController.sink;

  int get counter => _counter;

  void increment() {
    _counter++;
    sink.add(_counter);
  }

  void decrement() {
    _counter--;
    sink.add(_counter);
  }

  void reset() {
    _counter = 0;
    sink.add(_counter);
  }

  void dispose() {
    _counterController.close();
  }
}