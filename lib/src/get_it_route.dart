import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:get_it_binding/src/get_it_binding.dart';

class GetItRoute extends StatefulWidget {
  final GetItBinding? binding;
  final List<GetItBinding> bindings;
  final Widget page;

  const GetItRoute({
    super.key,
    this.binding,
    this.bindings = const [],
    required this.page,
  });

  @override
  State<GetItRoute> createState() => _GetItRouteState();
}

class _GetItRouteState extends State<GetItRoute> {
  @override
  void initState() {
    _initBindings();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _disposeBindings();
  }

  void _initBindings() {
    if (widget.binding != null) {
      widget.binding?.onInit();
      developer.log(
        'onInit: ${widget.binding?.runtimeType}',
        name: 'GetItBinding',
      );
    }
    for (final binding in widget.bindings) {
      binding.onInit();
      developer.log(
        'onInit: ${widget.binding?.runtimeType}',
        name: 'GetItBinding',
      );
    }
  }

  void _disposeBindings() {
    if (widget.binding != null) {
      widget.binding?.onDispose();
      developer.log(
        'onDispose: ${widget.binding?.runtimeType}',
        name: 'GetItBinding',
      );
    }
    for (final binding in widget.bindings) {
      binding.onDispose();
      developer.log(
        'onDispose: ${widget.binding?.runtimeType}',
        name: 'GetItBinding',
      );
    }
  }

  @override
  Widget build(BuildContext context) => widget.page;
}
