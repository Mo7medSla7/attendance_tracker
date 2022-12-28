import 'package:flutter/material.dart';

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
        fontSize: 24,
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
