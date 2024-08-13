import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:login_app/config/theme/app_theme.dart';
import 'package:login_app/config/theme/app_widget.dart';
import 'package:login_app/core/constant/constant.dart';
import 'package:login_app/core/parameter/register.dart';
import 'package:login_app/features/login/presentation/bloc/post_register/post_register_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController passwordConfirm = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController nama = TextEditingController();

  TextEditingController noHp = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<PostRegisterBloc, PostRegisterState>(
          builder: (context, state) {
            if (state is GetDataRegisterSuccess) {
              email.text = state.data.email.toString() == 'null'
                  ? ''
                  : state.data.email.toString();
              username.text = state.data.username.toString() == 'null'
                  ? ''
                  : state.data.username.toString();
              noHp.text = state.data.noHp.toString() == 'null'
                  ? ''
                  : state.data.noHp.toString();
              password.text = state.data.password.toString() == 'null'
                  ? ''
                  : state.data.password.toString();
              passwordConfirm.text = state.data.password.toString() == 'null'
                  ? ''
                  : state.data.password.toString();
              nama.text = state.data.name.toString() == 'null'
                  ? ''
                  : state.data.name.toString();
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
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
                            "Ayo Mulai!",
                            style: headlineStyleText()
                                .copyWith(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Center(
                            child: Text(
                          "Buat akun baru",
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
                                hintText: "Username", controller: username)),
                        const Gap(10),
                        Text(
                          "Nama Lengkap",
                          style: titleStyleText(),
                        ),
                        const Gap(10),
                        SizedBox(
                            width: MediaQuery.of(context).size.width / 1.1,
                            height: 45,
                            child: CustomTextField(
                                hintText: "Nama Lengkap", controller: nama)),
                        const Gap(10),
                        Text(
                          "Email",
                          style: titleStyleText(),
                        ),
                        const Gap(10),
                        SizedBox(
                            width: MediaQuery.of(context).size.width / 1.1,
                            height: 45,
                            child: CustomTextField(
                              hintText: "email",
                              controller: email,
                              obscureText: false,
                            )),
                        const Gap(10),
                        Text(
                          "Nomor Telepon",
                          style: titleStyleText(),
                        ),
                        const Gap(10),
                        SizedBox(
                            width: MediaQuery.of(context).size.width / 1.1,
                            height: 45,
                            child: CustomTextField(
                              hintText: "Nomor Telepon",
                              controller: noHp,
                              obscureText: false,
                            )),
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
                        const Gap(10),
                        Text(
                          "Konfirmasi Password",
                          style: titleStyleText(),
                        ),
                        const Gap(10),
                        SizedBox(
                            width: MediaQuery.of(context).size.width / 1.1,
                            height: 45,
                            child: CustomTextField(
                              hintText: "konfirmasi Password Anda",
                              controller: passwordConfirm,
                              obscureText: true,
                            )),
                        const Gap(50),
                        BlocConsumer<PostRegisterBloc, PostRegisterState>(
                          listener: (context, state) {
                            if (state is RegisterPostSuccess) {
                              Navigator.pop(context);
                              // Navigator.pushReplacement(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) => const DashboardPage(),
                              //     ));
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.black,
                                  content: Text(state.message),
                                ),
                              );
                            }
                          },
                          builder: (context, state) {
                            return Center(
                              child: CustomButton(
                                  function: () {
                                    // ParameterUpdate parameterUpdate =
                                    //     ParameterUpdate(
                                    //         name: email.text,
                                    //         password: password.text);
                                    // context.read<PostLoginBloc>().add(PostLogin(
                                    //     parameterUpdate: parameterUpdate));
                                    ParameterRegister parameterRegister =
                                        ParameterRegister(
                                            name: nama.text,
                                            password: password.text,
                                            noHp: noHp.text,
                                            email: email.text,
                                            username: username.text);
                                    context.read<PostRegisterBloc>().add(
                                        PostRegister(
                                            parameterUpdate:
                                                parameterRegister));
                                  },
                                  child: (state is RegisterPostLoading)
                                      ? const CupertinoActivityIndicator()
                                      : Text(
                                          "Daftar Sekarang",
                                          style: titleStyleText()
                                              .copyWith(color: Colors.white),
                                        )),
                            );
                          },
                        ),
                        Gap(
                          MediaQuery.of(context).size.height / 25,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
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
                          "Ayo Mulai!",
                          style: headlineStyleText()
                              .copyWith(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Center(
                          child: Text(
                        "Buat akun baru",
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
                              hintText: "Username", controller: username)),
                      const Gap(10),
                      Text(
                        "Nama Lengkap",
                        style: titleStyleText(),
                      ),
                      const Gap(10),
                      SizedBox(
                          width: MediaQuery.of(context).size.width / 1.1,
                          height: 45,
                          child: CustomTextField(
                              hintText: "Nama Lengkap", controller: nama)),
                      const Gap(10),
                      Text(
                        "Email",
                        style: titleStyleText(),
                      ),
                      const Gap(10),
                      SizedBox(
                          width: MediaQuery.of(context).size.width / 1.1,
                          height: 45,
                          child: CustomTextField(
                            hintText: "email",
                            controller: email,
                            obscureText: false,
                          )),
                      const Gap(10),
                      Text(
                        "Nomor Telepon",
                        style: titleStyleText(),
                      ),
                      const Gap(10),
                      SizedBox(
                          width: MediaQuery.of(context).size.width / 1.1,
                          height: 45,
                          child: CustomTextField(
                            hintText: "Nomor Telepon",
                            controller: noHp,
                            obscureText: false,
                          )),
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
                      const Gap(10),
                      Text(
                        "Konfirmasi Password",
                        style: titleStyleText(),
                      ),
                      const Gap(10),
                      SizedBox(
                          width: MediaQuery.of(context).size.width / 1.1,
                          height: 45,
                          child: CustomTextField(
                            hintText: "konfirmasi Password Anda",
                            controller: passwordConfirm,
                            obscureText: true,
                          )),
                      const Gap(50),
                      BlocConsumer<PostRegisterBloc, PostRegisterState>(
                        listener: (context, state) {
                          if (state is RegisterPostSuccess) {
                            Navigator.pop(context);
                            // Navigator.pushReplacement(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => const DashboardPage(),
                            //     ));
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.black,
                                content: Text(state.message),
                              ),
                            );
                          }
                        },
                        builder: (context, state) {
                          return Center(
                            child: CustomButton(
                                function: () {
                                  // ParameterUpdate parameterUpdate =
                                  //     ParameterUpdate(
                                  //         name: email.text,
                                  //         password: password.text);
                                  // context.read<PostLoginBloc>().add(PostLogin(
                                  //     parameterUpdate: parameterUpdate));
                                  ParameterRegister parameterRegister =
                                      ParameterRegister(
                                          name: nama.text,
                                          password: password.text,
                                          noHp: noHp.text,
                                          email: email.text,
                                          username: username.text);
                                  context.read<PostRegisterBloc>().add(
                                      PostRegister(
                                          parameterUpdate: parameterRegister));
                                },
                                child: (state is RegisterPostLoading)
                                    ? const CupertinoActivityIndicator()
                                    : Text(
                                        "Daftar Sekarang",
                                        style: titleStyleText()
                                            .copyWith(color: Colors.white),
                                      )),
                          );
                        },
                      ),
                      Gap(
                        MediaQuery.of(context).size.height / 25,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
