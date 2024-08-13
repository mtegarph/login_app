import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:login_app/core/error/exception.dart';
import 'package:login_app/core/error/failure.dart';
import 'package:login_app/core/parameter/parameter.dart';
import 'package:login_app/core/parameter/register.dart';
import 'package:login_app/features/login/data/datasources/local/hive_data.dart';
import 'package:login_app/features/login/data/datasources/remote/login_api_services.dart';
import 'package:login_app/features/login/data/models/local/local_login.dart';
import 'package:login_app/features/login/domain/entities/register_entity.dart';
import 'package:login_app/features/login/domain/repositories/login_repository.dart';

class LoginRepositoryImpl extends LoginRepository {
  final HiveData hiveData;
  final LocalLogin localLogin;
  final LoginPostApi loginPostApi;
  LoginRepositoryImpl(
      {required this.loginPostApi,
      required this.localLogin,
      required this.hiveData});

  @override
  Future<Either<Failure, String>> login(ParameterUpdate parameterUpdate) async {
    try {
      final result = await loginPostApi.postApi(parameterUpdate);
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure("An Error Has Occured"));
    } on SocketException {
      return const Left(ConnectionFailure("no network"));
    }
  }

  @override
  Future<Either<Failure, String>> register(
      ParameterRegister parameterUpdate) async {
    try {
      await loginPostApi.postRegister(parameterUpdate);
      return const Right("data successfuly added");
    } on ServerException {
      return const Left(ServerFailure("An Error Has Occured"));
    } on SocketException {
      return const Left(ConnectionFailure("no network"));
    }
  }

  @override
  Future<Either<Failure, String>> getToken() async {
    try {
      final result = await localLogin.getToken();
      print('data $result');
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure("An Error Has Occured"));
    } on SocketException {
      return const Left(ConnectionFailure("no network"));
    }
  }

  @override
  Future<Either<Failure, RegisterEntity>> getUser() async {
    try {
      final result = hiveData.getFirstData();
      final data = RegisterEntity(
          id: result?.id,
          name: result?.name.toString(),
          password: result?.password,
          noHp: result?.noHp,
          email: result?.email,
          username: result?.name);
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }
}
