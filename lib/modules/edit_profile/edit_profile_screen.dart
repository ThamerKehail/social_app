import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/social_cubit.dart';
import 'package:social_app/modules/edit_profile/cubit/edit_profile_cubit.dart';
import 'package:social_app/widget/default_form_field.dart';
import 'package:social_app/widget/default_text_buton.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditProfileCubit, EditProfileState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var profileImage = EditProfileCubit.get(context).image;
        var coverImage = EditProfileCubit.get(context).coverImage;
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "Edit Profile",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                )),
            actions: [
              DefaultTextButton(
                text: "Update",
                onTap: () {
                  EditProfileCubit.get(context).uploadProfileImage();
                },
              ),
            ],
          ),
          body: Padding(
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
                        child: Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 160,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: coverImage == null
                                          ? NetworkImage(
                                              '${BlocProvider.of<SocialCubit>(context).userModel.cover}')
                                          : FileImage(coverImage)
                                              as ImageProvider,
                                      fit: BoxFit.cover)),
                            ),
                            IconButton(
                              onPressed: () {
                                EditProfileCubit.get(context).getCoverImage();
                              },
                              icon: const CircleAvatar(
                                  radius: 25,
                                  child: Icon(
                                    Icons.camera_alt_outlined,
                                    size: 20,
                                  )),
                            )
                          ],
                        ),
                      ),
                      Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                            radius: 65,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 60,
                              backgroundImage: profileImage == null
                                  ? NetworkImage(
                                      BlocProvider.of<SocialCubit>(context)
                                          .userModel
                                          .image!)
                                  : FileImage(profileImage) as ImageProvider,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              EditProfileCubit.get(context).getImage();
                            },
                            icon: const CircleAvatar(
                                radius: 25,
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  size: 20,
                                )),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                DefaultFormField(
                    controller: SocialCubit.get(context).userName,
                    keyboardType: TextInputType.name,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return "User Name must not be empty";
                      } else {
                        return null;
                      }
                    },
                    prefix: Icons.person_outlined,
                    hint: "User Name"),
                const SizedBox(
                  height: 10,
                ),
                DefaultFormField(
                    controller: SocialCubit.get(context).bio,
                    keyboardType: TextInputType.text,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return "bio must not be empty";
                      } else {
                        return null;
                      }
                    },
                    prefix: Icons.info_outline,
                    hint: "Bio"),
              ],
            ),
          ),
        );
      },
    );
  }
}
