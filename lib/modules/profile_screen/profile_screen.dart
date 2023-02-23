import 'package:flutter/material.dart';

import '../../helpers/cache_helper.dart';
import '../../shared/component.dart';
import '../login_screen/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: FullWidthElevatedButton(
        text: 'Log Out',
        color: Colors.red,
        onTap: () {
          CacheHelper.putData(key: 'isLoggedIn', value: false);
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ));
        },
      ),
    ));
  }
}
