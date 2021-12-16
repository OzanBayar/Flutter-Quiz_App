import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final String answerText;
  final Color answerColor;
  final VoidCallback? answerTap;

  const Answer(
      {Key? key,
      required this.answerText,
      required this.answerColor,
      required this.answerTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: answerTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
        width: double.infinity,
        decoration: BoxDecoration(
          color: answerColor,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          answerText,
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
