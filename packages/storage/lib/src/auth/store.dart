import 'package:apiClient/main.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rxdart/rxdart.dart';

class StoreAuthProvider extends AuthProvider {
  StoreAuthProvider(FlutterSecureStorage storage) : _storage = storage {
    _subject = BehaviorSubject<AuthModel>(
      onListen: () async {
        final String? token = await _storage.read(key: _tokenKey);
        doTokenWork(token: token, subject: _subject);
      },
    );
  }

  static const String _tokenKey = 'token';
  final FlutterSecureStorage _storage;
  Subject<AuthModel>? _subject;

  void doTokenWork({Subject<AuthModel>? subject, String? token}) {
    AuthModel model;
    if (token == null || token.isEmpty) {
      model = AuthModel.empty();
    } else {
      model = AuthModel(token: token);
    }
    _subject!.add(model);
  }

  @override
  Stream<AuthModel> get() {
    return _subject!.distinct();
  }

  @override
  Future<void> put(AuthModel model) async {
    if (model.isEmpty) {
      await _storage.delete(key: _tokenKey);
      _subject!.add(AuthModel.empty());
    } else {
      await _storage.write(key: _tokenKey, value: model.token);
      _subject!.add(AuthModel(token: model.token));
    }
    return;
  }

  @override
  Future<void> remove() async {
    await put(AuthModel.empty());
  }
}
