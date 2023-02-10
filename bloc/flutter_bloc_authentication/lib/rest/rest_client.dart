

import 'dart:convert';
import 'dart:io';

import 'package:http_interceptor/http_interceptor.dart';
import 'package:injectable/injectable.dart';
import 'package:http/http.dart' as http;


class ApiConstants {

  static String baseUrl = "http://localhost:8080";
  //static String baseUrl = "http://10.0.2.2:8080";
  


}

class HeadersApiInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    try {
      data.headers["Content-Type"] = "application/json";
      data.headers["Accept"] = "application/json";
    } catch (e) {
      print(e);
    }
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async => data;
}

@Order(-10)
@singleton
class RestClient {

  RestClient();

  //final _httpClient = http.Client();
  final _httpClient = InterceptedClient.build(interceptors: [HeadersApiInterceptor()]);


  Future<dynamic> get(String url) async {

    try {

        Uri uri = Uri.parse(ApiConstants.baseUrl + url);

        final response = await _httpClient.get(uri);
        var responseJson = _response(response);
        return responseJson;


    } on SocketException catch(ex) {
      throw FetchDataException('No internet connection: ${ex.message}');
    }

  }

  Future<dynamic> post(String url, dynamic body) async {

      try {

        Uri uri = Uri.parse(ApiConstants.baseUrl + url);

        final response = await _httpClient.post(uri, body: jsonEncode(body));
        var responseJson = _response(response);
        return responseJson;

    } on SocketException catch(ex) {
      throw FetchDataException('No internet connection: ${ex.message}');
    }

  }


  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        var responseJson = utf8.decode(response.bodyBytes);
        return responseJson;
      case 204:
        return;
      case 400:
        throw BadRequestException(utf8.decode(response.bodyBytes));
      case 401:
        throw AuthenticationException(utf8.decode(response.bodyBytes));
      case 403:
        throw UnauthorizedException(utf8.decode(response.bodyBytes));
      case 404:
        throw NotFoundException(utf8.decode(response.bodyBytes));
      case 500:
      default:
        throw FetchDataException(
            'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}

// ignore_for_file: prefer_typing_uninitialized_variables
// ignore_for_file: annotate_overrides

class CustomException implements Exception {
  final _message;
  final _prefix;

  CustomException([this._message, this._prefix]);

  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends CustomException {
  FetchDataException([String? message])
      : super(message, "");
}

class BadRequestException extends CustomException {
  BadRequestException([message]) : super(message, "");
}

class AuthenticationException extends CustomException {
  AuthenticationException([message]) : super(message,"");
}


class UnauthorizedException extends CustomException {
  UnauthorizedException([message]) : super(message,"");
}

class NotFoundException extends CustomException {
  NotFoundException([message]) : super(message, "");
}
