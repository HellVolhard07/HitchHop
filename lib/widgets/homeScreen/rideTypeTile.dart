import 'package:flutter/material.dart';

class RideTypeTile extends StatelessWidget {
  final String imageUrl;
  final String text;

  const RideTypeTile({required this.imageUrl, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(40.0, 40.0, 40.0, 0),
      height: 280.0,
      width: 300.0,
      color: Colors.yellow,
      child: Column(
        children: [
          Container(
            height: 160.0,
            color: Colors.blue,
          ),

          Container(padding: const EdgeInsets.only(top: 26.0),child: Text(text, style: TextStyle(fontSize: 20.0),))
        ],
      ),
    );
  }
}
