import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:easy_binding/src/easy_binding.dart';

import '../easy_binding.dart';

class EasyBindingRoute extends StatefulWidget {
  final EasyBinding? binding;
  final List<EasyBinding> bindings;
  final Widget page;

  const EasyBindingRoute({
    super.key,
    this.binding,
    this.bindings = const [],
    required this.page,
  });

  @override
  State<EasyBindingRoute> createState() => _GetItRouteState();
}

class _GetItRouteState extends State<EasyBindingRoute> {
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
