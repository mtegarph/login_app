import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:login_app/core/constant/constant.dart';
import 'package:login_app/core/error/exception.dart';

import 'package:login_app/core/parameter/parameter.dart';
import 'package:login_app/core/parameter/register.dart';
import 'package:login_app/features/login/data/models/local/local_login.dart';

abstract class LoginPostApi {
  Future postApi(ParameterUpdate parameterUpdate);
  Future postRegister(ParameterRegister parameterRegister);
}

class LoginPostApiImpl extends LoginPostApi {
  final http.Client client;
  final LocalLogin localLogin;
  LoginPostApiImpl({required this.client, required this.localLogin});
  @override
  Future postApi(ParameterUpdate parameterUpdate) async {
    final response = await client
        .post(Uri.parse("${Urls.productBaseUrl}/auth/login"), body: {
      'username': parameterUpdate.name,
      'password': parameterUpdate.password
    });

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      await localLogin.saveBearerToken(data['token']);
      await localLogin.saveNamaCustomer(data['firstName'] + data['lastName']);
      await localLogin.saveUserId(data['id']);

      var userId = await localLogin.getToken();
      print(userId);
      return userId;
    } else {
      print(response.statusCode);
      throw ServerException();
    }
  }

  @override
  Future postRegister(ParameterRegister parameterRegister) async {
    final response =
        await client.post(Uri.parse("${Urls.productBaseUrl}/users/add"), body: {
      'username': parameterRegister.username,
      'password': parameterRegister.password,
      'email': parameterRegister.email,
      'phone': parameterRegister.noHp,
      'firstName': parameterRegister.name,
    });

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw ServerException();
    }
  }
}
