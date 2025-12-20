import 'package:example/src/home_binding.dart';
import 'package:example/src/home_page.dart';
import 'package:flutter/material.dart';
import 'package:easy_binding/easy_binding.dart';

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
      ),
      initialRoute: '/home',
      routes: {
        '/home': (context) {
          return EasyBindingRoute(
            binding: HomeBinding(),
            page: const HomePage(),
          );
        },
      },
    );
  }
}
