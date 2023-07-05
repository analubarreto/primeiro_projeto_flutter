
import 'package:flutter/material.dart';

class Difficulty extends StatelessWidget {

  final int dificultyLevel;

  const Difficulty({
    required this.dificultyLevel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> stars = List.generate(5, (index) => Icon(
      Icons.star,
      size: 15,
      color: (dificultyLevel >= index + 1) ? Colors.deepPurple : Colors.deepPurple[100],
    ));

    return Row(
      children: stars,
    );
  }
}