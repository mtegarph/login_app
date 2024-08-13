import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:login_app/core/error/exception.dart';
import 'package:login_app/core/error/failure.dart';
import 'package:login_app/core/parameter/parameter.dart';
import 'package:login_app/core/parameter/register.dart';
import 'package:login_app/features/login/data/datasources/remote/login_api_services.dart';
import 'package:login_app/features/login/data/models/local/local_login.dart';
import 'package:login_app/features/login/domain/repositories/login_repository.dart';

class LoginRepositoryImpl extends LoginRepository {
  final LocalLogin localLogin;
  final LoginPostApi loginPostApi;
  LoginRepositoryImpl({required this.loginPostApi, required this.localLogin});

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
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure("An Error Has Occured"));
    } on SocketException {
      return const Left(ConnectionFailure("no network"));
    }
  }
}
