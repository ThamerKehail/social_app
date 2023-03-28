import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/login/cubit/login_cubit.dart';
import 'package:social_app/modules/login/cubit/login_state.dart';
import 'package:social_app/widget/defaul_buton.dart';
import 'package:social_app/widget/default_form_field.dart';
import 'package:social_app/widget/default_text_buton.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
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
                  SizedBox(
                    height: 30.0,
                  ),
                  DefaultFormField(
                    controller: TextEditingController(),
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
                  BlocBuilder<LoginCubit, LoginStates>(
                    builder: (context, state) {
                      return DefaultFormField(
                        controller: TextEditingController(),
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
                      );
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  DefaultButton(onTap: () {}, text: "Login"),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?"),
                      DefaultTextButton(text: "Register", onTap: () {}),
                    ],
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
