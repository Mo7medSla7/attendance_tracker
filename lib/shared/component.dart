import 'package:attendance_tracker/models/lecture_model.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class DefaultFormField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final String? errorMessage;
  bool isPassword;

  DefaultFormField({
    super.key,
    required this.hintText,
    required this.controller,
    this.errorMessage,
    this.isPassword = false,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        fillColor: Colors.grey[100],
        filled: true,
        hintText: hintText,
      ),
      controller: controller,
      obscureText: isPassword,
      validator: (value) {
        if (value!.isEmpty) {
          return '${errorMessage ?? 'This field'} can not be empty';
        }
        return null;
      },
    );
  }
}

class HeaderTitle extends StatelessWidget {
  final String title;
  const HeaderTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.w800,
      ),
    );
  }
}

class Subtitle extends StatelessWidget {
  final String title;
  const Subtitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        fontFamily: null,
      ),
    );
  }
}

class MiniTitle extends StatelessWidget {
  final String title;
  final bool overflow;
  const MiniTitle({super.key, required this.title, this.overflow = false});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      overflow: overflow ? TextOverflow.ellipsis : null,
    );
  }
}

class MainBody extends StatelessWidget {
  final String text;
  final Color? color;
  const MainBody({
    super.key,
    required this.text,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: color,
      ),
    );
  }
}

class SubBody extends StatelessWidget {
  final String text;
  final Color? color;

  const SubBody({
    super.key,
    required this.text,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: color,
      ),
    );
  }
}

class MiniBody extends StatelessWidget {
  final String text;
  final Color? color;

  const MiniBody({
    super.key,
    required this.text,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: color,
      ),
    );
  }
}

class FullWidthElevatedButton extends StatelessWidget {
  final String text;
  final Function() onTap;
  final Color? color;

  const FullWidthElevatedButton(
      {super.key, required this.text, required this.onTap, this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: onTap,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(color ?? Colors.blue[900]),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

class DefaultGridView extends StatelessWidget {
  const DefaultGridView({super.key,});
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      crossAxisCount: 2,
      children: List.generate(
          lectures.length,
              (index)=>buildLectureItem(lectures[index])
      ),

    );
  }
  Widget buildLectureItem(LectureModel lecture)=> Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Colors.indigo,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: double.maxFinite,
            alignment:Alignment.topLeft,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[300],
            ),
            child: Text(
              'Dr.${lecture.drName}',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: double.maxFinite,
            alignment:Alignment.center,
            decoration: BoxDecoration(
              color: Colors.grey[300],
            ),
            child: Text(
              '${lecture.subject}',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        SizedBox(height: 20,),
        Center(
          child: new CircularPercentIndicator(
            radius:40.0,
            lineWidth: 10.0,
            percent: lecture.attendancePercent/100,
            center: new Text(
                '${lecture.attendancePercent} %',
                 style: TextStyle(
                   fontSize: 20,
                 ),
            ),
            progressColor: Colors.green,
          ),
        ),
      ],
    ),
  );
}

