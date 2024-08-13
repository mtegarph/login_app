import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_app/dependency_injection.dart';
import 'package:login_app/features/dashboard/presentation/pages/dahsboard_page.dart';
import 'package:login_app/features/dashboard/presentation/pages/splash_screen.dart';
import 'package:login_app/features/login/data/models/local/register_hive.dart';
import 'package:login_app/features/login/presentation/bloc/post_login/post_login_bloc.dart';
import 'package:login_app/features/login/presentation/bloc/post_register/post_register_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:login_app/features/login/presentation/pages/login_page.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<RegisterHive>(RegisterHiveAdapter());
  await Hive.openBox<RegisterHive>('register_hive');
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PostLoginBloc>(
          create: (context) => sl()..add(const GetTokenEvent()),
        ),
        BlocProvider<PostRegisterBloc>(
          create: (context) => sl()..add(const GetDataRegister()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: BlocBuilder<PostLoginBloc, PostLoginState>(
          builder: (context, state) {
            if (state is GetTokenSuccess) {
              return state.token == 'null'
                  ? const SplashScreen()
                  : const LoginPage();
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
