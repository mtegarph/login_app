import 'package:dartz/dartz.dart';
import 'package:login_app/core/error/failure.dart';
import 'package:login_app/core/parameter/parameter.dart';
import 'package:login_app/core/usecase/usecase.dart';
import 'package:login_app/features/login/domain/repositories/login_repository.dart';

class PostLoginUseCase
    extends UseCase<Either<Failure, String>, ParameterUpdate> {
  final LoginRepository loginRepository;

  PostLoginUseCase({required this.loginRepository});

  @override
  Future<Either<Failure, String>> call({ParameterUpdate? params}) {
    return loginRepository.login(params!);
  }
}
