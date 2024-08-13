import 'package:dartz/dartz.dart';
import 'package:login_app/core/error/failure.dart';
import 'package:login_app/core/parameter/parameter.dart';
import 'package:login_app/core/parameter/register.dart';
import 'package:login_app/features/login/domain/entities/register_entity.dart';

abstract class LoginRepository {
  Future<Either<Failure, String>> login(ParameterUpdate parameterUpdate);
  Future<Either<Failure, String>> register(ParameterRegister parameterUpdate);
  Future<Either<Failure, String>> getToken();
  Future<Either<Failure, RegisterEntity>> getUser();
}
