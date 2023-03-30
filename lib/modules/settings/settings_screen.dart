import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/edit_profile/cubit/edit_profile_cubit.dart';
import 'package:social_app/modules/edit_profile/edit_profile_screen.dart';
import 'package:social_app/shared/components/components.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditProfileCubit, EditProfileState>(
      listener: (context, state) {
        if (state is EditProfileInitialState) {
          print("init");
        }
      },
      builder: (context, state) {
        var cubit = EditProfileCubit.get(context);

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 200,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: double.infinity,
                        height: 160,
                        child: Image.network(
                          '${cubit.userModel.cover}',
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 65,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage:
                            NetworkImage(cubit.userModel.image ?? ""),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                cubit.userModel.userName!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              Text(
                cubit.userModel.bio!,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: const [
                      Text("100"),
                      Text("Post"),
                    ],
                  ),
                  Column(
                    children: const [
                      Text("100"),
                      Text("Photo"),
                    ],
                  ),
                  Column(
                    children: const [
                      Text("100"),
                      Text("Followers"),
                    ],
                  ),
                  Column(
                    children: const [
                      Text("100"),
                      Text("Following"),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                      child: OutlinedButton(
                    onPressed: () {},
                    child: const Text("Edit Profile"),
                  )),
                  SizedBox(
                    width: 8,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      navigateTo(context, const EditProfileScreen());
                    },
                    child: const Icon(Icons.edit_outlined),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
