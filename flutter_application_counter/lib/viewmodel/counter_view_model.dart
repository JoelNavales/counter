import '../events/counter_event.dart';
import '../services/counter_services.dart';


class CounterViewModel{
  final CounterService _counterService = CounterService();

  Stream<int> get counterStream => _counterService.counterStream;

  int get counter => _counterService.counter;

  void handleEvent(CounterEvent event) {
    switch (event) {
      case CounterEvent.increment:
        _counterService.increment();
        break;
      case CounterEvent.decrement:
        _counterService.decrement();
        break;
      case CounterEvent.reset:
        _counterService.reset();
        break;
    }
  }

  void dispose() {
    _counterService.dispose();
  }
}