import 'package:flutter/material.dart';
import 'package:hitchhop/widgets/selectCarTile.dart';

class AvailableCarScreenOld extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: 210.0,
        child: SelectCarTile(),
      ),
    );
  }
}
