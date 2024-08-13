import 'package:dartz/dartz.dart';
import 'package:login_app/core/error/failure.dart';
import 'package:login_app/core/parameter/register.dart';
import 'package:login_app/core/usecase/usecase.dart';
import 'package:login_app/features/login/domain/repositories/login_repository.dart';

class PostRegisterUseCase
    extends UseCase<Either<Failure, String>, ParameterRegister> {
  final LoginRepository loginRepository;

  PostRegisterUseCase({required this.loginRepository});

  @override
  Future<Either<Failure, String>> call({ParameterRegister? params}) {
    return loginRepository.register(params!);
  }
}
