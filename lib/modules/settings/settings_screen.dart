import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/social_cubit.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/widget/defaul_buton.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        UserModel userModel = SocialCubit.get(context).userModel;
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
                          '${userModel.cover}',
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 65,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(userModel.image!),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                userModel.userName!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              Text(
                userModel.bio!,
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
                    onPressed: () {},
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