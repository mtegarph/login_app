import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:login_app/core/parameter/register.dart';
import 'package:login_app/features/login/domain/entities/register_entity.dart';
import 'package:login_app/features/login/domain/usecases/get_register_data.dart';
import 'package:login_app/features/login/domain/usecases/post_register.dart';

part 'post_register_event.dart';
part 'post_register_state.dart';

class PostRegisterBloc extends Bloc<PostRegisterEvent, PostRegisterState> {
  final PostRegisterUseCase register;
  final GetRegisterDataUseCase getRegister;
  PostRegisterBloc(this.register, this.getRegister)
      : super(PostLoginInitial()) {
    on<PostRegister>(onPost);
    on<GetDataRegister>(onGetData);
  }
  void onPost(PostRegister event, Emitter<PostRegisterState> emit) async {
    emit(RegisterPostLoading());
    final result = await register.call(params: event.parameterUpdate);
    result.fold((l) => emit(RegisterPostFailed(message: l.message)),
        (r) => emit(RegisterPostSuccess(message: r)));
  }

  void onGetData(GetDataRegister event, Emitter<PostRegisterState> emit) async {
    emit(RegisterPostLoading());
    final result = await getRegister.call();
    result.fold((l) => emit(RegisterPostFailed(message: l.message)),
        (r) => emit(GetDataRegisterSuccess(data: r)));
  }
}
