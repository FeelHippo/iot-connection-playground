import 'package:apiClient/main.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:giggle/presentation/modules/app_module.dart';
import 'package:giggle/presentation/modules/bloc_module.dart';
import 'package:giggle/presentation/modules/data_module.dart';
import 'package:giggle/presentation/modules/domain_module.dart';
import 'package:giggle/presentation/modules/network_module.dart';
import 'package:giggle/presentation/onboarding/auth/auth_bloc/auth_bloc.dart';
import 'package:giggle/presentation/splash/bloc/splash_bloc.dart';
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
  IOC.appScopeTest({
    void Function(Injector injector)? builder,
  }) : parent = null {
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
    /// Common
    _registerSingleton<FlutterSecureStorage>(
      DataModule.createFlutterSecureStorage,
    );

    /// Api Clients
    _registerSingleton<Dio>(NetworkModule.createDio);
    _registerSingleton<ApiClient>(NetworkModule.createApiClient);

    /// Storage
    _registerSingleton<UserPreferences>(DataModule.createUserPreferences);

    /// Data Providers
    _registerSingleton<LocaleProvider>(DataModule.createLocaleProvider);
    _registerSingleton<SomethingProvider>(
      DomainModule.createSomethingProvider,
    );
    _registerSingleton<AuthProvider>(DataModule.createAuthProvider);
    _registerSingleton<LoginProvider>(DataModule.createLoginProvider);
    _registerSingleton<UserProvider>(DataModule.createUserProvider);

    /// Data Mappers
    _registerDependency<SomethingMapper>(DataModule.createSomethingMapper);

    /// App UI
    _registerSingleton<DefaultCacheManager>(
      AppModule.createDefaultCacheManager,
    );
    _registerSingleton<Connectivity>(AppModule.createConnectivity);

    /// Interactors
    _registerSingleton<SomethingInteractor>(
      DomainModule.createSomethingInteractor,
    );
    _registerSingleton<UserInteractor>(DomainModule.createUserInteractor);
    _registerSingleton<AuthInteractor>(DomainModule.createAuthInteractor);
    _registerSingleton<LoginInteractor>(DomainModule.createLoginInteractor);

    /// Blocs
    _registerDependency<AuthBloc>(
      BlocModule.createAuthBloc,
    );
    _registerDependency<SplashBloc>(BlocModule.createSplashBloc);
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
