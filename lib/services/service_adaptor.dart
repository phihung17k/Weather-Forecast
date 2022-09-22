import 'dart:convert';

import 'package:http/http.dart';

import '../log.dart';

class ServiceAdaptor {
  Map<String, dynamic>? parseToMap(Response? response) {
    Log.d("------------------START------------------");
    Log.d("status code:${response?.statusCode}");
    Log.d("headers: ${response?.headers}");
    Log.d("body: ${response?.body}");
    Log.d("-------------------END-------------------");
    if (response != null) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    }
    return null;
  }
}
