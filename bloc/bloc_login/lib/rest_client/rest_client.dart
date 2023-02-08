
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

import '../exceptions/exceptions.dart';


class ApiConstants {

  static String baseUrl = "http://localhost:8080";
  


}

@singleton
class RestClient {

  RestClient();

  final _httpClient = http.Client();


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
        throw UnauthorizedException(utf8.decode(response.bodyBytes));
      case 403:
        throw UnauthorizedException(utf8.decode(response.bodyBytes));
      case 404:
        throw NotFoundException(utf8.decode(response.bodyBytes));
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }





}