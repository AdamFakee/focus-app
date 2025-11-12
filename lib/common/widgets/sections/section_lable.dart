import 'package:flutter/material.dart';

class SectionLable extends StatelessWidget {
  final String title;
  const SectionLable({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
    );
  }
}