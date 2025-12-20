import 'package:example/src/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

/// Home page widget that displays a counter.
///
/// This page retrieves the [HomeController] from GetIt, which was
/// registered by the [HomeBinding] when the route was created.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// Get the HomeController from GetIt.
  ///
  /// This will work because HomeBinding registered it when the route
  /// was initialized.
  final HomeController controller = GetIt.instance<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EasyBinding Example'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'You have pushed the button this many times:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            // ListenableBuilder rebuilds only when the controller notifies
            ListenableBuilder(
              listenable: controller,
              builder: (context, child) {
                return Text(
                  controller.counter.toString(),
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
