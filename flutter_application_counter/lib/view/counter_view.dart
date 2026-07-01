import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_application_counter/viewmodel/counter_view_model.dart';

import '../events/counter_event.dart';


class CounterScreen extends HookWidget{
  CounterScreen({super.key});

  final vm = CounterViewModel();

  @override
  Widget build(BuildContext context) {
    final clicks = useState(0);
    useEffect(() {
      print("Application Started");

      return () {
        vm.dispose();
      };
    }, []);

    useEffect(() {
      print("Button pressed ${clicks.value} times");

      return null;
    }, [clicks.value]);

    return Scaffold(
      appBar: AppBar(title: Text("Steams + Hooks Demo")),
      body: Center(
        child: StreamBuilder<int>(
          stream: vm.counterStream,

          initialData: 0,

          builder: (context, snapshot) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                const Text("Counter", style: TextStyle(fontSize: 24),),
                const SizedBox(height: 20,),
                Text("${snapshot.data}", style: TextStyle(fontSize: 48)),
                const SizedBox(height: 20,),
                Text("Button Presses: ${clicks.value}"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        clicks.value++;
                        vm.onEvent(CounterEvent.decrement);
                      }, 
                      child: const Text("-")
                    ),
                    const SizedBox(height: 20,),
                    ElevatedButton(
                      onPressed: () {
                        clicks.value++;
                        vm.onEvent(CounterEvent.increment);
                      }, 
                      child: const Text("+")
                    ),
                    const SizedBox(height: 20,),
                    ElevatedButton(
                      onPressed: () {
                        clicks.value++;
                        vm.onEvent(CounterEvent.reset);
                      }, 
                      child: const Text("reset")
                    ),
                  ],
                ),
              ],
            );
          }
        ),
      )
    );
  }
}
