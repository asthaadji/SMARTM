import 'package:flutter/material.dart';

class SprinklerPage extends StatefulWidget {
  const SprinklerPage({super.key});

  @override
  State<SprinklerPage> createState() => _SprinklerPageState();
}

class _SprinklerPageState extends State<SprinklerPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(children: [
        Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Kontrol Sprinkle Sprayer",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ))
      ]),
    );
  }
}
