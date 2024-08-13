import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_app/dependency_injection.dart';
import 'package:login_app/features/dashboard/presentation/pages/dahsboard_page.dart';
import 'package:login_app/features/dashboard/presentation/pages/splash_screen.dart';
import 'package:login_app/features/login/presentation/bloc/post_login/post_login_bloc.dart';
import 'package:login_app/features/login/presentation/bloc/post_register/post_register_bloc.dart';

Future<void> main() async {
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
          create: (context) => sl(),
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
            if (state is LoginPostSuccess) {
              return state.message != null
                  ? const DahsboardPage()
                  : const SplashScreen();
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
