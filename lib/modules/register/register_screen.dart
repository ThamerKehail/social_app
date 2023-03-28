import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/components/components.dart';

import '../../layout/social_layout.dart';
import '../../widget/defaul_buton.dart';
import '../../widget/default_form_field.dart';
import '../../widget/default_text_buton.dart';
import 'cubit/register_cubit.dart';
import 'cubit/register_state.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterStates>(
      listener: (context, state) {
        if (state is CreateUserSuccessState) {
          navigateAndFinish(context, const SocialLayout());
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
              child: SingleChildScrollView(
                child: Form(
                  key: BlocProvider.of<RegisterCubit>(context).formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Register",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Register now t browse your app",
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
                            BlocProvider.of<RegisterCubit>(context).userName,
                        keyboardType: TextInputType.text,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return "Please enter your user name";
                          }
                        },
                        prefix: Icons.person_outlined,
                        hint: "User Name",
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      DefaultFormField(
                        controller:
                            BlocProvider.of<RegisterCubit>(context).email,
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
                            BlocProvider.of<RegisterCubit>(context).phone,
                        keyboardType: TextInputType.phone,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return "Please enter your phone";
                          }
                        },
                        prefix: Icons.phone_outlined,
                        hint: "Your Phone",
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      BlocBuilder<RegisterCubit, RegisterStates>(
                        builder: (context, state) {
                          return DefaultFormField(
                            controller: BlocProvider.of<RegisterCubit>(context)
                                .password,
                            keyboardType: TextInputType.visiblePassword,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return "Please enter your Password";
                              }
                            },
                            prefix: Icons.lock_outline,
                            hint: "Password",
                            suffix:
                                BlocProvider.of<RegisterCubit>(context).suffix,
                            suffixOnTap: () {
                              BlocProvider.of<RegisterCubit>(context)
                                  .changePasswordVisibility();
                            },
                            obscureText: BlocProvider.of<RegisterCubit>(context)
                                .isPassword,
                          );
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      DefaultButton(
                          onTap: () {
                            GlobalKey<FormState> key =
                                BlocProvider.of<RegisterCubit>(context).formKey;
                            if (key.currentState!.validate()) {
                              BlocProvider.of<RegisterCubit>(context)
                                  .userRegister();
                            }
                          },
                          text: "Register"),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have account?"),
                          DefaultTextButton(
                              text: "Login",
                              onTap: () {
                                Navigator.pop(context);
                              }),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
