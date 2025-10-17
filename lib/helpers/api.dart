import 'dart:convert';
import 'package:http/http.dart' as http;

class Api {
  static Future<dynamic> get({required String url , required String keyMap}) async {
    try {
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final jsonData = jsonDecode(response.body);
        return jsonData[keyMap];
      } else {
        throw ('Bad response with #StatusCode : ${response.statusCode} And #Body ${response.body}');
      }
    } catch (e) {
      throw ('Bad request : error => $e');
    }
  }
}
