import 'dart:developer' as developer;

abstract class GetItBinding {
  Future<void> onInit() async {
    developer.log('onInit: $runtimeType', name: 'GetItBinding');
  }

  Future<void> onDispose() async {
    developer.log('onDispose: $runtimeType', name: 'GetItBinding');
  }
}
