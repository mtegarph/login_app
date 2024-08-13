import 'package:dartz/dartz.dart';
import 'package:login_app/core/error/failure.dart';
import 'package:login_app/core/usecase/usecase.dart';
import 'package:login_app/features/login/domain/repositories/login_repository.dart';

class GetTokenLocalUseCase extends UseCase<Either<Failure, String>, void> {
  final LoginRepository loginRepository;

  GetTokenLocalUseCase({required this.loginRepository});

  @override
  Future<Either<Failure, String>> call({void params}) {
    return loginRepository.getToken();
  }
}
