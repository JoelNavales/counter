import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';


import '../events/counter_event.dart';
import '../viewmodel/counter_view_model.dart';

class CounterView extends HookWidget {
  final CounterViewModel viewModel;

  const CounterView({Key? key, required this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final counter = useState<int>(viewModel.counter);

    useEffect(() {
      final subscription = viewModel.counterStream.listen((value) {
        counter.value = value;
      });
      return subscription.cancel;
    }, [viewModel]);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Streams + Hooks Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Counter Value:',
            ),
            Text(
              '${counter.value}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => viewModel.handleEvent(CounterEvent.increment),
                  child: const Text('Increment'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => viewModel.handleEvent(CounterEvent.decrement),
                  child: const Text('Decrement'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => viewModel.handleEvent(CounterEvent.reset),
                  child: const Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}