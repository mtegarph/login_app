import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:login_app/core/constant/constant.dart';
import 'package:login_app/core/error/exception.dart';

import 'package:login_app/core/parameter/parameter.dart';
import 'package:login_app/core/parameter/register.dart';
import 'package:login_app/features/login/data/datasources/local/hive_data.dart';
import 'package:login_app/features/login/data/models/local/local_login.dart';
import 'package:login_app/features/login/domain/entities/register_entity.dart';

abstract class LoginPostApi {
  Future postApi(ParameterUpdate parameterUpdate);
  Future postRegister(ParameterRegister parameterRegister);
}

class LoginPostApiImpl extends LoginPostApi {
  final http.Client client;
  final LocalLogin localLogin;
  final HiveData hiveData;
  LoginPostApiImpl(
      {required this.client, required this.localLogin, required this.hiveData});
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
      await localLogin.saveUserId(data['id'].toString());

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
    await hiveData.addData(RegisterEntity(
        id: jsonDecode(response.body)['id'].toString(),
        name: parameterRegister.name,
        password: parameterRegister.password,
        noHp: parameterRegister.noHp,
        email: parameterRegister.email,
        username: parameterRegister.username));
    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw ServerException();
    }
  }
}
