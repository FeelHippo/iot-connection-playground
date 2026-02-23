import 'package:apiClient/main.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:giggle/presentation/dependencies/modules/app_module.dart';
import 'package:giggle/presentation/dependencies/modules/data_module.dart';
import 'package:giggle/presentation/dependencies/modules/domain_module.dart';
import 'package:giggle/presentation/dependencies/modules/network_module.dart';
import 'package:injector/injector.dart';
import 'package:storage/main.dart';

/// Inversion of Control
/// https://stackoverflow.com/a/3140/10708345
class IOC {
  /// init all app dependencies
  IOC.appScope() : parent = null {
    _initDependencies();
  }

  /// same as appScope, for testing purposes
  IOC.appScopeTest({void Function(Injector injector)? builder})
    : parent = null {
    if (builder != null) {
      builder(injector);
    }
  }

  /// assembler, injects services to the application
  final Injector injector = Injector();
  final List<DisposableDependency> _disposables = <DisposableDependency>[];

  /// parent object passing in a child object's dependencies
  /// in addition to controlling execution flow
  final IOC? parent;

  void _initDependencies() {
    /// Api Clients
    _registerSingleton<Dio>(NetworkModule.createDio);
    _registerSingleton<ApiClient>(NetworkModule.createApiClient);

    /// Storage
    _registerSingleton<FlutterSecureStorage>(
      DataModule.createFlutterSecureStorage,
    );
    _registerSingleton<UserPreferences>(DataModule.createUserPreferences);

    /// Data Providers
    _registerSingleton<AuthProvider>(DataModule.createAuthProvider);
    _registerSingleton<AuthenticationProvider>(
      DataModule.createAuthenticationProvider,
    );
    _registerSingleton<LocaleProviderInterface>(
      DataModule.createLocaleStorageProvider,
    );

    /// App UI
    _registerSingleton<Connectivity>(AppModule.createConnectivity);

    /// Repositories
    _registerSingleton<UserRepository>(DomainModule.createUserRepository);
    _registerSingleton<AuthRepository>(DomainModule.createAuthRepository);
    _registerSingleton<AuthenticationRepository>(
      DomainModule.createAuthenticationRepository,
    );
  }

  void _registerSingleton<T>(
    DependencyBuilder<T> builder, {
    bool override = false,
    String dependencyName = '',
  }) {
    injector.registerSingleton<T>(
      () {
        final T instance = builder(injector);
        if (instance is DisposableDependency) {
          _disposables.add(instance);
        }
        return instance;
      },
      override: override,
      dependencyName: dependencyName,
    );
  }

  void _registerDependency<T>(
    DependencyBuilder<T> builder, {
    bool override = false,
    String dependencyName = '',
  }) {
    injector.registerDependency<T>(
      () {
        final T instance = builder(injector);
        if (instance is DisposableDependency) {
          _disposables.add(instance);
        }
        return instance;
      },
      override: override,
      dependencyName: dependencyName,
    );
  }

  /// return instance of dependency object
  T getDependency<T>({String dependencyName = ''}) {
    try {
      if (exists<T>()) {
        return injector.get<T>(dependencyName: dependencyName);
      } else if (parent?.exists<T>() ?? false) {
        return parent!.getDependency<T>(dependencyName: dependencyName);
      } else {
        debugPrint('Type not defined $T');
        throw Error();
      }
    } catch (e) {
      debugPrint('Type not defined $T');
      rethrow;
    }
  }

  /// returns True if instance of dependency exists
  bool exists<T>({String dependencyName = ''}) {
    return injector.exists<T>(dependencyName: dependencyName);
  }

  /// dispose of a dependency
  void dispose() {
    for (final DisposableDependency disposable in _disposables) {
      disposable.dispose();
    }
  }
}

/// type definition
typedef DependencyBuilder<T> = T Function(Injector injector);

/// define
abstract class DisposableDependency {
  void dispose();
}
