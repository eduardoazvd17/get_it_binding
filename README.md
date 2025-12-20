# Easy Binding

[![Pub Version](https://img.shields.io/pub/v/easy_binding)](https://pub.dev/packages/easy_binding)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)

A lightweight Flutter package for managing dependencies lifecycle in routes. Inspired by GetX bindings but **framework-agnostic** - works with any dependency injection solution.

## 🎯 Why Easy Binding?

- **🪶 Lightweight**: Minimal overhead, just lifecycle management
- **🔄 Automatic**: Dependencies are registered/unregistered with route lifecycle
- **🎨 Clean Architecture**: Separate dependency setup from UI code
- **🔌 Framework Agnostic**: Works with GetIt, Provider, Riverpod, or any DI solution
- **📦 Zero Dependencies**: Only depends on Flutter SDK

## 📦 Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  easy_binding: ^0.0.1
```

Then run:

```bash
flutter pub get
```

## 🚀 Quick Start

### 1. Create a Binding

A binding is responsible for initializing and disposing dependencies:

```dart
import 'package:easy_binding/easy_binding.dart';
import 'package:get_it/get_it.dart';

class HomeBinding extends EasyBinding {
  @override
  void onInit() {
    // Register your dependencies when the route is created
    GetIt.instance.registerSingleton<HomeController>(HomeController());
  }

  @override
  void onDispose() {
    // Cleanup when the route is destroyed
    GetIt.instance.unregister<HomeController>();
  }
}
```

### 2. Use the Binding in Your Route

Wrap your page with `EasyBindingRoute`:

```dart
import 'package:easy_binding/easy_binding.dart';

MaterialApp(
  routes: {
    '/home': (context) => EasyBindingRoute(
      binding: HomeBinding(),
      page: const HomePage(),
    ),
  },
)
```

### 3. Use Your Dependencies in the Page

```dart
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get your dependency from your DI container
    final controller = GetIt.instance<HomeController>();
    
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(child: Text('Counter: ${controller.counter}')),
    );
  }
}
```

## 📖 Example

### Using with GetIt

```dart
class ProfileBinding extends EasyBinding {
  @override
  void onInit() {
    final getIt = GetIt.instance;
    getIt.registerLazySingleton<ProfileRepository>(() => ProfileRepository());
    getIt.registerFactory<ProfileController>(() => ProfileController(getIt()));
  }

  @override
  void onDispose() {
    final getIt = GetIt.instance;
    getIt.unregister<ProfileController>();
    getIt.unregister<ProfileRepository>();
  }
}
```

### Multiple Bindings

You can use multiple bindings for a single route:

```dart
EasyBindingRoute(
  bindings: [
    AuthBinding(),
    UserBinding(),
    SettingsBinding(),
  ],
  page: const DashboardPage(),
)
```

## 🔄 Lifecycle

```
Route Created
    ↓
onInit() called for all bindings
    ↓
Page displayed
    ↓
Route destroyed
    ↓
onDispose() called for all bindings
```

## 🤝 Integration with GoRouter

```dart
GoRouter(
  routes: [
    GoRoute(
      path: '/home',
      builder: (context, state) => EasyBindingRoute(
        binding: HomeBinding(),
        page: const HomePage(),
      ),
    ),
  ],
)
```

## 🐛 Debugging

Easy Binding logs all lifecycle events using `dart:developer`:

```
[EasyBinding] onInit: HomeBinding
[EasyBinding] onDispose: HomeBinding
```

These logs are automatically removed in release builds.

## 📚 Complete Example

Check out the [example](https://github.com/eduardoazvd17/easy_binding/tree/main/example) folder for a complete working app using Easy Binding with GetIt.

## 🤔 FAQ

**Q: Can I use this without any DI package?**  
A: Yes! You can use it with global variables, singleton patterns, or any custom solution.

**Q: Does it work with BLoC?**  
A: Absolutely! Use it to create and dispose BLoCs at the right time.

**Q: What about navigation packages like GoRouter?**  
A: Works perfectly! Just wrap your pages with `EasyBindingRoute`.

**Q: Is there any performance overhead?**  
A: Minimal. It's just one extra StatefulWidget in your tree that does almost nothing.

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 💬 Support

If you have any questions or issues, please open an issue on [GitHub](https://github.com/eduardoazvd17/easy_binding/issues).

---

Made with ❤️ by [Eduardo Azevedo](https://eduardoazevedo.com)
