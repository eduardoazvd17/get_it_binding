import 'package:easy_binding/easy_binding.dart';
import 'package:example/src/home_controller.dart';
import 'package:get_it/get_it.dart';

/// Binding for the Home page.
///
/// This binding is responsible for registering and unregistering
/// the [HomeController] in the GetIt dependency injection container.
///
/// The controller will be automatically registered when the Home route
/// is created and unregistered when the route is disposed.
class HomeBinding extends EasyBinding {
  @override
  void onInit() {
    // Register the HomeController as a singleton in GetIt
    GetIt.instance.registerSingleton<HomeController>(HomeController());
  }

  @override
  void onDispose() {
    // Unregister the HomeController from GetIt
    GetIt.instance.unregister<HomeController>();
  }
}
