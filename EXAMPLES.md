# Easy Binding - Additional Examples

## Example 1: Using with GoRouter

```dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_binding/easy_binding.dart';
import 'package:get_it/get_it.dart';

// 1. Create your controller
class ProductsController {
  List<String> products = ['Product 1', 'Product 2', 'Product 3'];
}

// 2. Create your binding
class ProductsBinding extends EasyBinding {
  @override
  void onInit() {
    GetIt.instance.registerSingleton<ProductsController>(ProductsController());
  }

  @override
  void onDispose() {
    GetIt.instance.unregister<ProductsController>();
  }
}

// 3. Create your page
class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = GetIt.instance<ProductsController>();
    
    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: ListView.builder(
        itemCount: controller.products.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(controller.products[index]),
          );
        },
      ),
    );
  }
}

// 4. Setup GoRouter with EasyBinding
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/products',
        builder: (context, state) => EasyBindingRoute(
          binding: ProductsBinding(),
          page: const ProductsPage(),
        ),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }
}
```

## Example 2: Using with BLoC

```dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_binding/easy_binding.dart';

// BLoC
class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  void increment() => emit(state + 1);
  void decrement() => emit(state - 1);
}

// Binding
class CounterBinding extends EasyBinding {
  late CounterCubit _cubit;

  @override
  void onInit() {
    _cubit = CounterCubit();
  }

  @override
  void onDispose() {
    _cubit.close();
  }

  CounterCubit get cubit => _cubit;
}

// Page
class CounterPage extends StatelessWidget {
  final CounterBinding binding;
  
  const CounterPage({super.key, required this.binding});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: binding.cubit,
      child: Scaffold(
        appBar: AppBar(title: const Text('Counter with BLoC')),
        body: Center(
          child: BlocBuilder<CounterCubit, int>(
            builder: (context, count) {
              return Text(
                '$count',
                style: Theme.of(context).textTheme.headlineMedium,
              );
            },
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () => binding.cubit.increment(),
              child: const Icon(Icons.add),
            ),
            const SizedBox(height: 8),
            FloatingActionButton(
              onPressed: () => binding.cubit.decrement(),
              child: const Icon(Icons.remove),
            ),
          ],
        ),
      ),
    );
  }
}

// Route setup
final counterBinding = CounterBinding();

MaterialApp(
  routes: {
    '/counter': (context) => EasyBindingRoute(
      binding: counterBinding,
      page: CounterPage(binding: counterBinding),
    ),
  },
)
```

## Example 3: Complex Feature with Repository Pattern

```dart
import 'package:flutter/material.dart';
import 'package:easy_binding/easy_binding.dart';
import 'package:get_it/get_it.dart';

// Domain Layer
class User {
  final String id;
  final String name;
  
  User({required this.id, required this.name});
}

// Data Layer
abstract class UserRepository {
  Future<List<User>> getUsers();
  Future<User> getUser(String id);
}

class UserRepositoryImpl implements UserRepository {
  @override
  Future<List<User>> getUsers() async {
    await Future.delayed(Duration(seconds: 1));
    return [
      User(id: '1', name: 'John'),
      User(id: '2', name: 'Jane'),
    ];
  }

  @override
  Future<User> getUser(String id) async {
    await Future.delayed(Duration(milliseconds: 500));
    return User(id: id, name: 'User $id');
  }
}

// Presentation Layer
class UserController extends ChangeNotifier {
  final UserRepository _repository;
  
  List<User> _users = [];
  bool _loading = false;
  
  List<User> get users => _users;
  bool get loading => _loading;
  
  UserController(this._repository);
  
  Future<void> loadUsers() async {
    _loading = true;
    notifyListeners();
    
    try {
      _users = await _repository.getUsers();
    } catch (e) {
      print('Error loading users: $e');
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}

// Binding
class UserBinding extends EasyBinding {
  @override
  void onInit() {
    final getIt = GetIt.instance;
    
    // Register repository
    getIt.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(),
    );
    
    // Register controller with repository dependency
    getIt.registerSingleton<UserController>(
      UserController(getIt<UserRepository>()),
    );
    
    // Load initial data
    getIt<UserController>().loadUsers();
  }

  @override
  void onDispose() {
    final getIt = GetIt.instance;
    getIt.unregister<UserController>();
    getIt.unregister<UserRepository>();
  }
}

// Page
class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = GetIt.instance<UserController>();
    
    return Scaffold(
      appBar: AppBar(title: const Text('Users')),
      body: ListenableBuilder(
        listenable: controller,
        builder: (context, _) {
          if (controller.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          
          return ListView.builder(
            itemCount: controller.users.length,
            itemBuilder: (context, index) {
              final user = controller.users[index];
              return ListTile(
                title: Text(user.name),
                subtitle: Text('ID: ${user.id}'),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.loadUsers,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

// Route setup
MaterialApp(
  routes: {
    '/users': (context) => EasyBindingRoute(
      binding: UserBinding(),
      page: const UsersPage(),
    ),
  },
)
```

## Example 4: Nested Navigation with Tab Views

```dart
import 'package:flutter/material.dart';
import 'package:easy_binding/easy_binding.dart';
import 'package:get_it/get_it.dart';

// Controllers for each tab
class HomeTabController {
  String message = 'Home Tab';
}

class SettingsTabController {
  String message = 'Settings Tab';
}

// Bindings
class HomeTabBinding extends EasyBinding {
  @override
  void onInit() {
    GetIt.instance.registerSingleton<HomeTabController>(HomeTabController());
  }

  @override
  void onDispose() {
    GetIt.instance.unregister<HomeTabController>();
  }
}

class SettingsTabBinding extends EasyBinding {
  @override
  void onInit() {
    GetIt.instance.registerSingleton<SettingsTabController>(
      SettingsTabController(),
    );
  }

  @override
  void onDispose() {
    GetIt.instance.unregister<SettingsTabController>();
  }
}

// Tab Pages
class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = GetIt.instance<HomeTabController>();
    return Center(child: Text(controller.message));
  }
}

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = GetIt.instance<SettingsTabController>();
    return Center(child: Text(controller.message));
  }
}

// Main Page with Tabs
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    EasyBindingRoute(
      binding: HomeTabBinding(),
      page: const HomeTab(),
    ),
    EasyBindingRoute(
      binding: SettingsTabBinding(),
      page: const SettingsTab(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
```

## Tips and Best Practices

### 1. Singleton vs Factory Registration

```dart
// Use Singleton for services that maintain state
GetIt.instance.registerSingleton<AuthService>(AuthService());

// Use Factory for controllers that should be recreated
GetIt.instance.registerFactory<LoginController>(
  () => LoginController(GetIt.instance<AuthService>()),
);
```

### 2. Lazy Registration

```dart
// Lazy Singleton - created only when first accessed
GetIt.instance.registerLazySingleton<ApiService>(
  () => ApiService(),
);
```

### 3. Error Handling

```dart
class RobustBinding extends EasyBinding {
  @override
  void onInit() {
    try {
      // Try to initialize
      final service = SomeService.initialize();
      GetIt.instance.registerSingleton(service);
    } catch (e) {
      // Log error
      print('Failed to initialize: $e');
      
      // Register fallback
      GetIt.instance.registerSingleton(FallbackService());
    }
  }
}
```

### 4. Testing Bindings

```dart
void main() {
  test('Binding registers and unregisters correctly', () {
    final binding = HomeBinding();
    
    // Test init
    binding.onInit();
    expect(GetIt.instance.isRegistered<HomeController>(), true);
    
    // Test dispose
    binding.onDispose();
    expect(GetIt.instance.isRegistered<HomeController>(), false);
  });
}
```

