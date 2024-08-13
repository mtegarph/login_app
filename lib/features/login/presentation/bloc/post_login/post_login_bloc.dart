import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:login_app/core/parameter/parameter.dart';
import 'package:login_app/features/login/domain/usecases/get_token_local.dart';
import 'package:login_app/features/login/domain/usecases/post_login.dart';

part 'post_login_event.dart';
part 'post_login_state.dart';

class PostLoginBloc extends Bloc<PostLoginEvent, PostLoginState> {
  final PostLoginUseCase login;
  final GetTokenLocalUseCase getToken;
  PostLoginBloc(this.login, this.getToken) : super(PostLoginInitial()) {
    on<PostLogin>(onPost);
    on<GetTokenEvent>(onGetToken);
  }
  void onPost(PostLogin event, Emitter<PostLoginState> emit) async {
    emit(LoginPostLoading());
    final result = await login.call(params: event.parameterUpdate);
    result.fold((l) => emit(LoginPostFailed(message: l.message)),
        (r) => emit(LoginPostSuccess(message: r)));
  }

  void onGetToken(GetTokenEvent event, Emitter<PostLoginState> emit) async {
    emit(LoginPostLoading());
    final result = await getToken.call();
    result.fold((l) => emit(LoginPostFailed(message: l.message)),
        (r) => emit(GetTokenSuccess(token: r)));
  }
}
