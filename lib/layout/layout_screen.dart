import 'package:attendance_tracker/layout/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/states.dart';

class LayoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: const Icon(Icons.qr_code_scanner, size: 26),
          ),
          appBar: AppBar(
            centerTitle: true,
            title: cubit.titles[cubit.currentIndex],
            actions: (cubit.currentIndex == 1)
                ? [IconButton(onPressed: () {}, icon: const Icon(Icons.search))]
                : null,
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeNavBar(index);
            },
            items: const [
              BottomNavigationBarItem(
                label: 'Home',
                icon: Icon(
                  Icons.home_rounded,
                ),
              ),
              BottomNavigationBarItem(
                label: 'Subjects',
                icon: Icon(
                  Icons.menu_book_rounded,
                ),
              ),
              BottomNavigationBarItem(
                label: 'Profile',
                icon: Icon(
                  Icons.person,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
