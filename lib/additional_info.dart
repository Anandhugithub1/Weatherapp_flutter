import 'package:flutter/material.dart';

class Addintionalinfoitem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  const Addintionalinfoitem(
      {super.key,
      required this.icon,
      required this.title,
      required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Icon(
        icon,
        size: 32,
      ),
      const SizedBox(
        height: 8,
      ),
      Text(
        title,
        style: const TextStyle(),
      ),
      const SizedBox(
        height: 8,
      ),
      Text(
        value,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      )
    ]);
  }
}
