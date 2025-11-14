import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:sakina/helpers/errors/internet_exceptions.dart';

class Api {
  static Future<dynamic> get({
    required String url,
    required String keyMap,
  }) async {
    try {
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final jsonData = jsonDecode(response.body);
        return jsonData[keyMap];
      } else {
        throw ('Bad response with #StatusCode : ${response.statusCode} And #Body ${response.body}');
      }
    } on TimeoutException catch (ex) {
      throw InternetTimeoutEception(message: ex.message);
    } on SocketException catch (ex) {
      throw NoInternetException(message: ex.message);
    } on http.ClientException catch (ex) {
      throw NoInternetException(message: ex.message);
    } catch (e) {
      throw InternetTimeoutEception(message: 'Timeout Exception');
    }
  }
}
