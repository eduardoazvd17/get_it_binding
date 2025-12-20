# Easy Binding Example

This example demonstrates how to use the Easy Binding package with GetIt for dependency injection.

## What's Included

This example shows:

1. **Creating a Binding** - `HomeBinding` manages the lifecycle of `HomeController`
2. **Using with Routes** - Wrapping pages with `EasyBindingRoute`
3. **Accessing Dependencies** - Getting registered dependencies in the page
4. **Automatic Cleanup** - Dependencies are disposed when leaving the route

## Project Structure

```
example/
  lib/
    src/
      home_binding.dart      # Binding that manages HomeController
      home_controller.dart   # Simple controller with counter logic
      home_page.dart        # Page that uses the controller
    main.dart               # App setup with routes
```

## How It Works

### 1. Controller (`home_controller.dart`)

A simple `ChangeNotifier` that manages a counter:

```dart
class HomeController extends ChangeNotifier {
  int _counter = 0;
  int get counter => _counter;
  
  void incrementCounter() {
    _counter++;
    notifyListeners();
  }
}
```

### 2. Binding (`home_binding.dart`)

Registers and unregisters the controller in GetIt:

```dart
class HomeBinding extends EasyBinding {
  @override
  void onInit() {
    GetIt.instance.registerSingleton<HomeController>(HomeController());
  }

  @override
  void onDispose() {
    GetIt.instance.unregister<HomeController>();
  }
}
```

### 3. Route Setup (`main.dart`)

Wraps the page with `EasyBindingRoute`:

```dart
routes: {
  '/home': (context) => EasyBindingRoute(
    binding: HomeBinding(),
    page: const HomePage(),
  ),
}
```

### 4. Page (`home_page.dart`)

Gets the controller from GetIt and uses it:

```dart
class HomePage extends StatefulWidget {
  @override
  Widget build(BuildContext context) {
    final controller = GetIt.instance<HomeController>();
    
    return Scaffold(
      body: ListenableBuilder(
        listenable: controller,
        builder: (context, _) {
          return Text('${controller.counter}');
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.incrementCounter,
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

## Running the Example

1. Navigate to the example directory:
```bash
cd example
```

2. Get dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## What to Notice

When you run the example:

1. **On Route Enter**: Check the console logs - you'll see `[EasyBinding] onInit: HomeBinding`
2. **Using the App**: The counter increments normally using the registered controller
3. **On Route Exit**: Check console logs - you'll see `[EasyBinding] onDispose: HomeBinding`

## Next Steps

Try modifying the example:

- Add more bindings for different controllers
- Create multiple routes with different bindings
- Try using multiple bindings with the `bindings: []` parameter

## Learn More

- [Easy Binding Documentation](https://pub.dev/packages/easy_binding)
- [GetIt Package](https://pub.dev/packages/get_it)
- [More Examples](../EXAMPLES.md)
