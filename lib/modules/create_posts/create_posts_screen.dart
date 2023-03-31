import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/social_cubit.dart';
import 'package:social_app/widget/default_text_buton.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "Add Post",
              style: TextStyle(color: Colors.black),
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
            actions: [
              DefaultTextButton(
                  text: 'Post',
                  onTap: () {
                    if (SocialCubit.get(context).postImage == null) {
                      SocialCubit.get(context).createPost();
                    } else {
                      SocialCubit.get(context).uploadPosImage();
                    }
                  })
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if (state is SocialCreatePostLoadingState)
                  LinearProgressIndicator(),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(
                          "https://www.bing.com/th?id=OIP.NfJCEFT-pMf8Me5cyKfgRgHaFH&w=150&h=104&c=8&rs=1&qlt=90&o=6&dpr=1.3&pid=3.1&rm=2"),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(child: Text("Thamer Kehail")),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: SocialCubit.get(context).post,
                    decoration: const InputDecoration(
                      hintText: "What is on your min......",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                if (SocialCubit.get(context).postImage != null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 160,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: FileImage(
                                    SocialCubit.get(context).postImage!),
                                fit: BoxFit.cover)),
                      ),
                      IconButton(
                        onPressed: () {
                          SocialCubit.get(context).removePostImage();
                        },
                        icon: const CircleAvatar(
                            radius: 25,
                            child: Icon(
                              Icons.close,
                              size: 20,
                            )),
                      )
                    ],
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                        onPressed: () {
                          SocialCubit.get(context).getPostImage();
                        },
                        child: Row(
                          children: const [
                            Icon(
                              Icons.photo_outlined,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text("Add Photo"),
                          ],
                        )),
                    TextButton(onPressed: () {}, child: const Text('# tags')),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
