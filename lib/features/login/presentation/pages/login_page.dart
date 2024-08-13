import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:login_app/config/theme/app_theme.dart';
import 'package:login_app/config/theme/app_widget.dart';
import 'package:login_app/core/constant/constant.dart';
import 'package:login_app/core/parameter/parameter.dart';
import 'package:login_app/features/login/presentation/bloc/post_login/post_login_bloc.dart';
import 'package:login_app/features/login/presentation/bloc/post_register/post_register_bloc.dart';
import 'package:login_app/features/login/presentation/pages/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: SingleChildScrollView(
            child: SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(40),
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        Urls.imageUrl,
                        height: 200,
                      ),
                    ),
                  ),
                  const Gap(20),
                  Center(
                    child: Text(
                      "Selamat Datang Di Salma",
                      style: headlineStyleText()
                          .copyWith(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Gap(5),
                  Center(
                      child: Text(
                    "Nikmati kemudahan Mencari Produk Sesuai Keinginan Kamu",
                    style: headlineStyleText().copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.grey[500]),
                    textAlign: TextAlign.center,
                  )),
                  const Gap(50),
                  Text(
                    "Username",
                    style: titleStyleText(),
                  ),
                  const Gap(10),
                  SizedBox(
                      width: MediaQuery.of(context).size.width / 1.1,
                      height: 45,
                      child: CustomTextField(
                          hintText: "Username", controller: email)),
                  const Gap(10),
                  Text(
                    "Password",
                    style: titleStyleText(),
                  ),
                  const Gap(10),
                  SizedBox(
                      width: MediaQuery.of(context).size.width / 1.1,
                      height: 45,
                      child: CustomTextField(
                        hintText: "Password",
                        controller: password,
                        obscureText: true,
                      )),
                  const Gap(50),
                  BlocConsumer<PostLoginBloc, PostLoginState>(
                    listener: (context, state) {
                      print(state.toString());
                      if (state is LoginPostSuccess) {
                        // Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => const DahsboardPage(),
                        //     ));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.green,
                            content: Text(
                                'data local dari token anda adalah : ${state.message}'),
                          ),
                        );
                      } else if (state is LoginPostFailed) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.redAccent,
                            content: Text(state.message),
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      return Center(
                        child: CustomButton(
                            function: () {
                              ParameterUpdate parameterUpdate = ParameterUpdate(
                                  name: email.text, password: password.text);
                              context.read<PostLoginBloc>().add(
                                  PostLogin(parameterUpdate: parameterUpdate));
                            },
                            child: (state is LoginPostLoading)
                                ? const CupertinoActivityIndicator()
                                : Text(
                                    "Login",
                                    style: titleStyleText()
                                        .copyWith(color: Colors.white),
                                  )),
                      );
                    },
                  ),
                  Gap(
                    MediaQuery.of(context).size.height / 25,
                  ),
                  Center(
                    child: Wrap(children: [
                      Text(
                        "Tidak Punya Akun?",
                        style: titleStyleText(),
                      ),
                      GestureDetector(
                        onTap: () {
                          context
                              .read<PostRegisterBloc>()
                              .add(const GetDataRegister());
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RegisterPage()));
                        },
                        child: Text(
                          "Daftar Disini",
                          style: titleStyleText()
                              .copyWith(color: ColorStyle.primaryColor),
                        ),
                      ),
                    ]),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
