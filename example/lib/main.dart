import 'package:example/src/home_binding.dart';
import 'package:example/src/home_page.dart';
import 'package:flutter/material.dart';
import 'package:easy_binding/easy_binding.dart';

/// Example app demonstrating how to use EasyBinding with GetIt.
///
/// This example shows:
/// 1. How to create a binding that registers dependencies
/// 2. How to wrap a page with EasyBindingRoute
/// 3. How to retrieve the registered dependencies in the page
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EasyBinding Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/home',
      routes: {
        '/home': (context) {
          // Wrap the page with EasyBindingRoute and provide the binding
          // The binding will be initialized when the route is created
          // and disposed when the route is destroyed
          return EasyBindingRoute(
            binding: HomeBinding(),
            page: const HomePage(),
          );
        },
      },
    );
  }
}
