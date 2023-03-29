import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/social_cubit.dart';
import 'package:social_app/modules/posts/posts_screen.dart';
import 'package:social_app/shared/components/components.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {
        if (state is SocialAddPostState) {
          navigateTo(context, const PostsScreen());
        }
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              cubit.screenTitle[cubit.currentIndex!],
              style: const TextStyle(color: Colors.black),
            ),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.notifications_none,
                    color: Colors.black,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.search, color: Colors.black)),
            ],
          ),
          body: cubit.screens[cubit.currentIndex!],
          bottomNavigationBar: BottomNavigationBar(
            selectedIconTheme: const IconThemeData(
              color: Colors.blue,
            ),
            unselectedItemColor: Colors.black,
            onTap: (index) {
              cubit.changeBottomNavBar(index);
            },
            currentIndex: cubit.currentIndex!,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined), label: ""),
              BottomNavigationBarItem(
                  icon: Icon(Icons.chat_bubble_outline), label: ""),
              BottomNavigationBarItem(icon: Icon(Icons.post_add), label: ""),
              BottomNavigationBarItem(
                  icon: Icon(Icons.people_alt_outlined), label: ""),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings_outlined), label: ""),
            ],
          ),
        );
      },
    );
  }
}
