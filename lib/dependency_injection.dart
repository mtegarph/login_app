import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:login_app/features/login/data/datasources/local/hive_data.dart';
import 'package:login_app/features/login/data/datasources/remote/login_api_services.dart';
import 'package:login_app/features/login/data/models/local/local_login.dart';
import 'package:login_app/features/login/data/repositories/login_repository_impl.dart';
import 'package:login_app/features/login/domain/repositories/login_repository.dart';
import 'package:login_app/features/login/domain/usecases/get_register_data.dart';
import 'package:login_app/features/login/domain/usecases/get_token_local.dart';
import 'package:login_app/features/login/domain/usecases/post_login.dart';
import 'package:login_app/features/login/domain/usecases/post_register.dart';
import 'package:login_app/features/login/presentation/bloc/post_login/post_login_bloc.dart';
import 'package:login_app/features/login/presentation/bloc/post_register/post_register_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
//dio
  sl.registerSingleton<Dio>(Dio());

  //sharedpref
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(sharedPreferences);

  //hive
  sl.registerLazySingleton<HiveData>(() => HiveData());
  //http
  sl.registerLazySingleton(() => http.Client());
  //data source
  sl.registerLazySingleton<LoginPostApi>(
      () => LoginPostApiImpl(client: sl(), localLogin: sl(), hiveData: sl()));

  sl.registerSingleton<LocalLogin>(LocalLogin());

  //repository
  sl.registerSingleton<LoginRepository>(LoginRepositoryImpl(
      loginPostApi: sl(), localLogin: sl(), hiveData: sl()));

//use case
  sl.registerSingleton<PostLoginUseCase>(
      PostLoginUseCase(loginRepository: sl()));
  sl.registerSingleton<PostRegisterUseCase>(
      PostRegisterUseCase(loginRepository: sl()));
  sl.registerSingleton<GetTokenLocalUseCase>(
      GetTokenLocalUseCase(loginRepository: sl()));

  sl.registerSingleton<GetRegisterDataUseCase>(
      GetRegisterDataUseCase(loginRepository: sl()));
  //bloc
  sl.registerFactory<PostLoginBloc>(() => PostLoginBloc(sl(), sl()));
  sl.registerFactory<PostRegisterBloc>(() => PostRegisterBloc(sl(), sl()));
}
