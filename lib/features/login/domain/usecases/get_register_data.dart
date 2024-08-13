import 'package:dartz/dartz.dart';
import 'package:login_app/core/error/failure.dart';
import 'package:login_app/core/usecase/usecase.dart';
import 'package:login_app/features/login/domain/entities/register_entity.dart';
import 'package:login_app/features/login/domain/repositories/login_repository.dart';

class GetRegisterDataUseCase
    extends UseCase<Either<Failure, RegisterEntity>, void> {
  final LoginRepository loginRepository;

  GetRegisterDataUseCase({required this.loginRepository});

  @override
  Future<Either<Failure, RegisterEntity>> call({void params}) {
    return loginRepository.getUser();
  }
}
