import 'package:dartz/dartz.dart';
import 'package:login_app/core/error/failure.dart';
import 'package:login_app/core/parameter/parameter.dart';
import 'package:login_app/core/parameter/register.dart';

abstract class LoginRepository {
  Future<Either<Failure, String>> login(ParameterUpdate parameterUpdate);
  Future<Either<Failure, String>> register(ParameterRegister parameterUpdate);
  Future<Either<Failure, String>> getToken();
}
