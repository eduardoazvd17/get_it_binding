import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:easy_binding/src/easy_binding.dart';

import '../easy_binding.dart';

/// A widget that wraps a page and manages bindings lifecycle.
///
/// This widget automatically calls [EasyBinding.onInit] when the route
/// is created and [EasyBinding.onDispose] when the route is destroyed.
///
/// You can provide either a single [binding] or multiple [bindings].
///
/// Example with single binding:
/// ```dart
/// EasyBindingRoute(
///   binding: HomeBinding(),
///   page: const HomePage(),
/// )
/// ```
///
/// Example with multiple bindings:
/// ```dart
/// EasyBindingRoute(
///   bindings: [
///     HomeBinding(),
///     UserBinding(),
///   ],
///   page: const HomePage(),
/// )
/// ```
class EasyBindingRoute extends StatefulWidget {
  /// Single binding to initialize and dispose with this route.
  ///
  /// Use this when you have only one binding to manage.
  final EasyBinding? binding;

  /// Multiple bindings to initialize and dispose with this route.
  ///
  /// Use this when you need to manage multiple bindings for a single route.
  /// All bindings will be initialized in order and disposed in the same order.
  final List<EasyBinding> bindings;

  /// The page widget to display.
  ///
  /// This is the actual page content that will be shown after
  /// the bindings are initialized.
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
    super.initState();
    _initBindings();
  }

  @override
  void dispose() {
    _disposeBindings();
    super.dispose();
  }

  /// Initializes all bindings (single and multiple).
  ///
  /// Calls [EasyBinding.onInit] for each binding and logs the action
  /// in debug mode.
  Future<void> _initBindings() async {
    try {
      if (widget.binding != null) {
        widget.binding!.onInit();
        if (kDebugMode) {
          developer.log(
            'onInit: ${widget.binding!.runtimeType}',
            name: 'EasyBinding',
          );
        }
      }

      for (final binding in widget.bindings) {
        binding.onInit();
        if (kDebugMode) {
          developer.log('onInit: ${binding.runtimeType}', name: 'EasyBinding');
        }
      }
    } catch (e, stackTrace) {
      if (kDebugMode) {
        developer.log(
          'Error initializing bindings',
          name: 'EasyBinding',
          error: e,
          stackTrace: stackTrace,
        );
      }
      rethrow;
    }
  }

  /// Disposes all bindings (single and multiple).
  ///
  /// Calls [EasyBinding.onDispose] for each binding and logs the action
  /// in debug mode.
  Future<void> _disposeBindings() async {
    try {
      if (widget.binding != null) {
        widget.binding!.onDispose();
        if (kDebugMode) {
          developer.log(
            'onDispose: ${widget.binding!.runtimeType}',
            name: 'EasyBinding',
          );
        }
      }

      for (final binding in widget.bindings) {
        binding.onDispose();
        if (kDebugMode) {
          developer.log(
            'onDispose: ${binding.runtimeType}',
            name: 'EasyBinding',
          );
        }
      }
    } catch (e, stackTrace) {
      if (kDebugMode) {
        developer.log(
          'Error disposing bindings',
          name: 'EasyBinding',
          error: e,
          stackTrace: stackTrace,
        );
      }
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) => widget.page;
}
