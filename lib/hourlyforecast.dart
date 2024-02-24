import 'package:flutter/material.dart';

class HourelyForecast extends StatelessWidget {
  final String time;
  final String temp;
  final IconData icon;

  const HourelyForecast(
      {super.key, required this.time, required this.temp, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Column(children: [
          Text(
            time,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Icon(
            icon,
            size: 20,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            temp,
            style: const TextStyle(),
          ),
        ]),
      ),
    );
  }
}
