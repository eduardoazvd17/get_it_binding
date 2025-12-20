/// Base class for creating bindings that manage dependencies lifecycle.
///
/// A binding is responsible for initializing and disposing dependencies
/// when a route is created or destroyed. This allows for clean separation
/// of concerns and automatic resource management.
///
/// Example:
/// ```dart
/// class HomeBinding extends EasyBinding {
///   @override
///   void onInit() {
///     GetIt.instance.registerSingleton<HomeController>(HomeController());
///   }
///
///   @override
///   void onDispose() {
///     GetIt.instance.unregister<HomeController>();
///   }
/// }
/// ```
abstract class EasyBinding {
  /// Called when the route is initialized.
  ///
  /// This is the perfect place to register your dependencies in your
  /// dependency injection container (GetIt, Provider, etc.).
  ///
  /// This method is called in [initState] of the [EasyBindingRoute].
  void onInit() {}

  /// Called when the route is disposed.
  ///
  /// This is the perfect place to unregister your dependencies and
  /// clean up resources.
  ///
  /// This method is called in [dispose] of the [EasyBindingRoute].
  void onDispose() {}
}
