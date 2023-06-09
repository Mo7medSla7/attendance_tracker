import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/component.dart';

class SubjectSearchScreen extends StatelessWidget {
  SubjectSearchScreen({Key? key}) : super(key: key);

  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    cubit.toggleSearch(false);
    cubit.searchedSubjects = [];

    return BlocConsumer<AppCubit, AppStates>(listener: (context, state) {
      if (state is RegisterSubjectSuccessState) {
        showDefaultSnackBar(context, 'Subjects registered successfully');
      }
      if (state is RegisterSubjectErrorState) {
        showDefaultSnackBar(context, 'Something went wrong or already exists');
      }
    }, builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Search'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  height: 50,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Stack(alignment: Alignment.center, children: [
                    TextField(
                      onSubmitted: (value) {
                        if (!cubit.isSearching) {
                          cubit.subjectSearch(value);
                        }
                      },
                      controller: searchController,
                      onTap: () {
                        cubit.toggleSearch(true);
                      },
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(left: 8),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    if (!cubit.isFocused)
                      const Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(
                          'Search',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: IconButton(
                        onPressed: !cubit.isSearching
                            ? () => cubit.subjectSearch(searchController.text)
                            : null,
                        icon: const Icon(Icons.search, color: Colors.indigo),
                        padding: EdgeInsets.zero,
                        splashRadius: 20,
                      ),
                    ),
                  ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: cubit.isSearching
                    ? const Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 28.0),
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          bool checkState = false;
                          cubit.checkStates.add(checkState);
                          var subject = cubit.searchedSubjects[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: CheckboxListTile(
                              onChanged: (value) {
                                if (value!) {
                                  cubit.addSubject(subject.id, index);
                                } else {
                                  checkState = value;
                                  cubit.removeSubject(subject.id, index);
                                }
                              },
                              value: cubit.checkStates[index],
                              title: MiniTitle(title: subject.name),
                              subtitle: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MiniBody(text: subject.faculty),
                                    MiniBody(text: 'Level ${subject.year}'),
                                  ],
                                ),
                              ),
                              tileColor: Colors.white,
                            ),
                          );
                        },
                        itemCount: cubit.searchedSubjects.length,
                      ),
              ),
              if (cubit.searchedSubjects.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FullWidthElevatedButton(
                    text: 'Register',
                    onTap: () {
                      cubit.sendSubjectsToRegister();
                    },
                  ),
                ),
            ],
          ),
        ),
      );
    });
  }
}
