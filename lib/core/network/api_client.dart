import 'dart:convert';

import 'dart:developer' as developer;
import 'package:http/http.dart' as http;

class APICaller {

  final Map<String, String> _defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };


  Future<dynamic> getrequest(String endpoint) async {
    try {
      final response = await http.get(Uri.parse(endpoint), headers: _defaultHeaders);
      return _processResponse(response);
    } catch (e) {
      throw Exception('GET request error: $e');
    }
  }

  /// Global POST request with body
  Future<dynamic> postrequest(String endpoint, Map<String, dynamic> body) async {
    try {
      final response = await http.post(
        Uri.parse(endpoint),
        headers: _defaultHeaders,
        body: jsonEncode(body),
      );
      return _processResponse(response);
    } catch (e) {
      throw Exception('POST request error: $e');
    }
  }

  Future<dynamic> putrequest(String endpoint, Map<String, dynamic> body) async {
    try {
      final response = await http.put(
        Uri.parse(endpoint),
        headers: _defaultHeaders,
        body: jsonEncode(body),
      );
      return _processResponse(response);
    } catch (e) {
      throw Exception('PUT request error: $e');
    }
  }

  dynamic _processResponse(http.Response response) {
    final statusCode = response.statusCode;
    final body = response.body;

    if (statusCode >= 200 && statusCode < 300) {
      return {
        'statusCode': statusCode,
        'data': jsonDecode(body),
      };
    } else {
      throw Exception('Request failed\nStatus: $statusCode\nBody: $body');
    }
  }

}
