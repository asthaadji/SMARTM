import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';

class SprinklerBox extends StatefulWidget {
  final int id;
  final bool status;

  const SprinklerBox({super.key, required this.id, required this.status});

  @override
  State<SprinklerBox> createState() => _SprinklerBox();
}

class _SprinklerBox extends State<SprinklerBox> {
  @override
  Widget build(BuildContext context) {
    String boolToStatus(bool status) {
      if (!status) {
        return 'off';
      } else if (status) {
        return 'on';
      }
      return '';
    }

    return Container(
      padding: EdgeInsets.all(10),
      height: 70,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5)
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Entypo.water),
              const SizedBox(width: 12),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('id sprayer: ${widget.id.toString()}'),
                  Text('status: ${boolToStatus(widget.status)}')
                ],
              )
            ],
          ),
          Switch(value: widget.status, onChanged: null)
        ],
      ),
    );
  }
}
