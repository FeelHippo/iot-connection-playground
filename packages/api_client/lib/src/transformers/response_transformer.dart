import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ResponseTransformer extends SyncTransformer {
  ResponseTransformer() : super(jsonDecodeCallback: _parseJson);
}

dynamic _parseAndDecode(String response) {
  return jsonDecode(response);
}

dynamic _parseJson(String text) {
  return compute(_parseAndDecode, text);
}
