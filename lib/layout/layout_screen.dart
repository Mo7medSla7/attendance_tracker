import 'package:attendance_tracker/modules/home_screen/home_screen.dart';
import 'package:attendance_tracker/modules/subjects_screen/subject_screen.dart';
import 'package:attendance_tracker/modules/test_screen/test_screen.dart';
import 'package:flutter/material.dart';
class Layout_Screen extends StatefulWidget {
  const Layout_Screen({Key? key}) : super(key: key);
  @override
  State<Layout_Screen> createState() => _Layout_ScreenState();
}
class _Layout_ScreenState extends State<Layout_Screen> {
  int currentIndex= 1;
  List<Text>titles=
  [
    Text('Subjects'),
    Text('Home'),
    Text('Test'),
  ];
  List<Widget>screens =
  [
    Subject_Screen(),
    Home_Screen(),
    Test_Screen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
        title: titles[currentIndex],
      ),
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex=index;
          });
        },
        items:
        const [
          BottomNavigationBarItem(
            label: 'Subjects',
            icon:Icon(
              Icons.menu_book_rounded,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Home',
            icon:Icon(
              Icons.home_rounded,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Test',
            icon:Icon(
              Icons.terrain_sharp,
            ),
          ),
        ],
      ),
    );
  }
}
