

import 'dart:convert';

import 'package:bloc_login/login/model/models.dart';
import 'package:get_it/get_it.dart';

import '../../rest_client/rest_client.dart';

class AuthenticationRepository {

  late RestClient _client;

  AuthenticationRepository() {  
    _client = GetIt.I.get<RestClient>();
  }


  Future<LoginResponse> doLogin(LoginRequest requestData) async {

    String url = "/auth/login/";
    
    var jsonResponse = await _client.post(url, requestData);
    return LoginResponse.fromJson(jsonDecode(jsonResponse));
    


  }


}