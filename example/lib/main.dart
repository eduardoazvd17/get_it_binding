import 'package:example/src/home_binding.dart';
import 'package:example/src/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get_it_binding/get_it_binding.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GetItBinding Example',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      initialRoute: '/home',
      routes: {
        '/home': (context) {
          return GetItRoute(binding: HomeBinding(), page: const HomePage());
        },
      },
    );
  }
}
