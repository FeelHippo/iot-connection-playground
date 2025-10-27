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
        final String? token = await _storage.read(key: _tokenKey);
        final String? userUid = await _storage.read(key: _userUidKey);
        doTokenWork(token: token, userUid: userUid);
      },
    );
  }

  static const String _tokenKey = 'token';
  static const String _userUidKey = 'user_uid';
  final FlutterSecureStorage _storage;
  Subject<AuthModel>? _subject;

  void doTokenWork({
    required String? token,
    required String? userUid,
  }) {
    AuthModel model;
    if (token == null || token.isEmpty) {
      model = AuthModel.empty();
    } else {
      model = AuthModel(
        token: token,
        userUid: userUid,
      );
    }
    _subject!.add(model);
  }

  @override
  Stream<AuthModel> get() {
    // "distinct" skips data events if they are equal to the previous data event.
    return _subject!.distinct();
  }

  @override
  Future<void> put(AuthModel model) async {
    if (model.isEmpty) {
      await _storage.delete(key: _tokenKey);
      _subject!.add(AuthModel.empty());
    } else {
      await _storage.write(key: _tokenKey, value: model.token);
      await _storage.write(key: _userUidKey, value: model.userUid);
      _subject!.add(model);
    }
    return;
  }

  @override
  Future<void> remove() async {
    await put(AuthModel.empty());
  }
}
