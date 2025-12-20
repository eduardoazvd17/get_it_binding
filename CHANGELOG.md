# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.0.1] - 2025-12-19

### Added
- Initial release of Easy Binding
- `EasyBinding` abstract class for creating bindings
- `EasyBindingRoute` widget for wrapping pages with lifecycle management
- Support for single binding with `binding` parameter
- Support for multiple bindings with `bindings` parameter
- Automatic `onInit()` call when route is created
- Automatic `onDispose()` call when route is destroyed
- Debug logging using `dart:developer`
- Error handling for initialization and disposal
- Complete documentation and examples
- Example app using GetIt for dependency injection

### Features
- Zero dependencies (Flutter SDK only)
- Framework-agnostic (works with any DI solution)
- Lightweight and performant
- Clean separation of concerns
