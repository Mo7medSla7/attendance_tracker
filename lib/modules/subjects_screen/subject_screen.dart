import 'package:attendance_tracker/layout/cubit/cubit.dart';
import 'package:attendance_tracker/shared/component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubit/states.dart';

class Subject_Screen extends StatelessWidget {
  const Subject_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return ListView.builder(
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.all(4.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeaderTitle(title: cubit.subjectsForRegister[index].name),
                    Text(cubit.subjectsForRegister[index].faculty),
                  ],
                ),
              ),
            );
          },
          itemCount: cubit.subjectsForRegister.length,
        );
      },
    );
  }
}
