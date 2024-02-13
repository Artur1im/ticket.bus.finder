import 'dart:convert';
import 'package:bus_finder/api.dart/apr_error.dart';
import 'package:http/http.dart' as http;

class Api {
  static const ENDPOINT = 'bibiptrip.com';
  static const VERSION_API = 'api/avibus';

  final Map<String, String> _headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  Future<dynamic> get(String path, {Map<String, dynamic>? params}) async {
    params = (params);

    Uri url = Uri.https(ENDPOINT, '/${Api.VERSION_API}$path', params);
    http.Response response = await http.get(url, headers: _headers);
    Map<String, dynamic> content = jsonDecode(response.body);
    if (response.statusCode != 200) {
      throw ApiError(response.statusCode, content.toString());
    }
    return content;
  }

  Future<dynamic> post(String path, {Map<String, dynamic>? params}) async {
    params = (params);

    Uri url = Uri.https(ENDPOINT, '/${Api.VERSION_API}$path', params);
    http.Response response = await http.get(url, headers: _headers);
    Map<String, dynamic> content = jsonDecode(response.body);
    if (response.statusCode != 200) {
      throw ApiError(response.statusCode, content.toString());
    }
    return content;
  }
}
