import 'package:flutter/material.dart';

class DefaultFormField extends StatelessWidget {
  final String tintText;
  final TextEditingController controller;

  const DefaultFormField(
      {super.key, required this.tintText, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        fillColor: Colors.grey[100],
        filled: true,
        hintText: tintText,
      ),
      controller: controller,
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

class FullWidthElevatedButton extends StatelessWidget {
  final String text;
  final Function() onTap;

  const FullWidthElevatedButton(
      {super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: onTap,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.blue[900]),
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
