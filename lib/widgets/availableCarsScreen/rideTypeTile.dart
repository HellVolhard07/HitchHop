import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:hitchhop/constants.dart';
import 'package:hitchhop/screens/availableCarsScreen.dart';
import 'package:hitchhop/screens/mapSample.dart';

class RideTypeTile extends StatelessWidget {
  final String imageUrl;
  final String text;
  final String type;

  const RideTypeTile(
      {required this.imageUrl, required this.text, required this.type});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MapSample(type: type)),
        );
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(40.0, 40.0, 40.0, 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.yellow,
        ),
        height: 280.0,
        width: 300.0,
        child: Column(
          children: [
            SizedBox(
              height: 160.0,
              width: 160.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  40.0,
                ),
                child: Image(
                  image: NetworkImage(
                    loginImage,
                  ),
                ),
              ),
            ),
            Container(
                padding: const EdgeInsets.only(top: 26.0),
                child: Text(
                  text,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ))
          ],
        ),
      ),
    );
  }
}
