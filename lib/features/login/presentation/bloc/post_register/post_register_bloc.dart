import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:login_app/core/parameter/register.dart';
import 'package:login_app/features/login/domain/usecases/post_register.dart';

part 'post_register_event.dart';
part 'post_register_state.dart';

class PostRegisterBloc extends Bloc<PostRegisterEvent, PostRegisterState> {
  final PostRegisterUseCase register;
  PostRegisterBloc(this.register) : super(PostLoginInitial()) {
    on<PostRegister>(onPost);
  }
  void onPost(PostRegister event, Emitter<PostRegisterState> emit) async {
    emit(RegisterPostLoading());
    final result = await register.call(params: event.parameterUpdate);
    result.fold((l) => emit(RegisterPostFailed(message: l.message)),
        (r) => emit(RegisterPostSuccess(message: r)));
  }
}
