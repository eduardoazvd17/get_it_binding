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
    widget.binding?.onInit();
    for (final binding in widget.bindings) {
      binding.onInit();
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    widget.binding?.onDispose();
    for (final binding in widget.bindings) {
      binding.onDispose();
    }
  }

  @override
  Widget build(BuildContext context) => widget.page;
}
