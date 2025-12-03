import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rxdart/rxdart.dart';
import 'package:storage/main.dart';

class StoreAuthProvider extends AuthProvider {
  StoreAuthProvider(FlutterSecureStorage injectedDependency)
    : _storage = injectedDependency {
    // A special StreamController that captures the latest item that has been added to the controller,
    // and emits that as the first item to any new listener.
    _subject = BehaviorSubject<AuthModel>(
      sync: true,
      onListen: () async {
        final Map<String?, String?> storedValues = await getStoredValues();
        put(
          AuthModel(
            name: storedValues['name'],
            accessToken: storedValues['accessToken'],
            refreshToken: storedValues['refreshToken'],
          ),
          write: false,
        );
      },
    );
  }

  static const String _nameKey = 'name_token';
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  final FlutterSecureStorage _storage;
  Subject<AuthModel>? _subject;

  @override
  Future<Map<String?, String?>> getStoredValues() async {
    final String? name = await _storage.read(key: _nameKey);
    final String? accessToken = await _storage.read(key: _accessTokenKey);
    final String? refreshToken = await _storage.read(key: _refreshTokenKey);
    return <String?, String?>{
      name: name,
      accessToken: accessToken,
      refreshToken: refreshToken,
    };
  }

  @override
  Stream<AuthModel> get() {
    // "distinct" skips data events if they are equal to the previous data event.
    return _subject!.distinct();
  }

  @override
  Future<void> put(AuthModel model, {bool write = true}) async {
    if (model.isEmpty) {
      if (write) {
        await _storage.delete(key: _nameKey);
        await _storage.delete(key: _accessTokenKey);
        await _storage.delete(key: _refreshTokenKey);
      }
      _subject!.add(AuthModel.empty());
    } else {
      if (write) {
        await _storage.write(key: _nameKey, value: model.name);
        await _storage.write(key: _accessTokenKey, value: model.accessToken);
        await _storage.write(key: _refreshTokenKey, value: model.refreshToken);
      }
      _subject!.add(model);
    }
  }

  @override
  Future<void> update({
    String? name,
    String? accessToken,
    String? refreshToken,
  }) async {
    if (name != null && name.isNotEmpty) {
      await _storage.write(key: _nameKey, value: name);
    }
    if (accessToken != null && accessToken.isNotEmpty) {
      await _storage.write(key: _accessTokenKey, value: accessToken);
    }
    if (refreshToken != null && refreshToken.isNotEmpty) {
      await _storage.write(key: _refreshTokenKey, value: refreshToken);
    }
    // do NOT add a new model to the subject to avoid side effects in the authBloc
    // unless the server returns 403 for this user. See authentication interceptor
    // See RefreshTokenService in the backend
    if (<String?>[
      name,
      accessToken,
      refreshToken,
    ].every((String? property) => property == null)) {
      await remove();
    }
  }

  @override
  Future<void> remove() async {
    await put(AuthModel.empty());
  }
}
