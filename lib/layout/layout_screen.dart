import 'dart:async';

import 'package:attendance_tracker/layout/cubit/cubit.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../helpers/cache_helper.dart';
import '../modules/login_screen/login_screen.dart';
import '../modules/no_internet_screen/no_internet_screen.dart';
import 'cubit/states.dart';

class LayoutScreen extends StatefulWidget {
  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  late Connectivity _connectivity;
  late StreamSubscription<ConnectivityResult> _subscription;

  @override
  void initState() {
    super.initState();

    _connectivity = Connectivity();
    _subscription = _connectivity.onConnectivityChanged.listen((event) {
      setState(() {
        if (event == ConnectivityResult.none) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const NoInternetScreen()),
          );
        }
      });
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

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
            centerTitle: cubit.currentIndex == 2 ? false : true,
            title: cubit.titles[cubit.currentIndex],
            actions: cubit.currentIndex == 2
                ? [
                    Padding(
                      padding: const EdgeInsets.only(right: 4.0),
                      child: TextButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Logout From This Account ?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
                                  child: const Text(
                                    'No',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(true);
                                  },
                                  child: const Text('Yes'),
                                ),
                              ],
                            ),
                          ).then((logout) {
                            if (logout ?? false) {
                              CacheHelper.putData(
                                  key: 'isLoggedIn', value: false);
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (context) => LoginScreen(),
                                  ),
                                  (route) => false);
                              cubit.logout();
                            }
                          });
                        },
                        child: Row(
                          children: const [
                            Text(
                              'Logout',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(width: 4),
                            Icon(
                              color: Colors.white,
                              Icons.logout,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]
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
