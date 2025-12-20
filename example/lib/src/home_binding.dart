import 'package:easy_binding/easy_binding.dart';
import 'package:example/src/home_controller.dart';
import 'package:get_it/get_it.dart';

class HomeBinding extends EasyBinding {
  @override
  Future<void> onInit() async {
    GetIt.instance.registerSingleton<HomeController>(HomeController());
  }

  @override
  Future<void> onDispose() async {
    GetIt.instance.unregister<HomeController>();
  }
}
