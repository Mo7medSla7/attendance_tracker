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
        cubit.getContext(context);
        return Scaffold(
          floatingActionButton: cubit.floatingButtons[cubit.currentIndex],
          appBar: AppBar(
            centerTitle: true,
            title: cubit.titles[cubit.currentIndex],
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
