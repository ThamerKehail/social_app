import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/social_layout.dart';
import 'package:social_app/modules/login/cubit/login_cubit.dart';
import 'package:social_app/modules/login/cubit/login_state.dart';
import 'package:social_app/modules/register/register_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';
import 'package:social_app/widget/defaul_buton.dart';
import 'package:social_app/widget/default_form_field.dart';
import 'package:social_app/widget/default_text_buton.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {
        if (state is LoginErrorState) {
          showToast(txt: state.error, state: ToastState.ERROR);
        }
        if (state is LoginSuccessState) {
          CacheHelper.saveData(key: 'uid', value: state.uid).then((value) {
            navigateTo(context, const SocialLayout());
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Form(
                      key: BlocProvider.of<LoginCubit>(context).formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "LOGIN",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "login now t browse your app",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: Colors.grey),
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          DefaultFormField(
                            controller:
                                BlocProvider.of<LoginCubit>(context).email,
                            keyboardType: TextInputType.emailAddress,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return "Please enter your email";
                              }
                            },
                            prefix: Icons.email_outlined,
                            hint: "Email Address",
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          DefaultFormField(
                            controller:
                                BlocProvider.of<LoginCubit>(context).password,
                            keyboardType: TextInputType.visiblePassword,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return "Please enter your Password";
                              }
                            },
                            prefix: Icons.lock_outline,
                            hint: "Password",
                            suffix: BlocProvider.of<LoginCubit>(context).suffix,
                            suffixOnTap: () {
                              BlocProvider.of<LoginCubit>(context)
                                  .changePasswordVisibility();
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          DefaultButton(
                              onTap: () {
                                GlobalKey<FormState> key =
                                    BlocProvider.of<LoginCubit>(context)
                                        .formKey;
                                if (key.currentState!.validate()) {
                                  BlocProvider.of<LoginCubit>(context)
                                      .userLogin();
                                }
                              },
                              text: "Login"),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Don't have an account?"),
                              DefaultTextButton(
                                  text: "Register",
                                  onTap: () {
                                    navigateTo(context, const RegisterScreen());
                                  }),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  (state is LoginLoadingState)
                      ? Center(
                          child: Theme(
                            data: ThemeData(
                              cupertinoOverrideTheme: const CupertinoThemeData(
                                  brightness: Brightness.dark),
                            ),
                            child: const CupertinoActivityIndicator(
                              radius: 25,
                            ),
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
