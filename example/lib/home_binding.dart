import 'package:example/home_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:get_it_binding/get_it_binding.dart';

class HomeBinding extends GetItBinding {
  @override
  Future<void> onInit() async {
    GetIt.instance.registerSingleton<HomeController>(HomeController());
  }

  @override
  Future<void> onDispose() async {
    GetIt.instance.unregister<HomeController>();
  }
}
