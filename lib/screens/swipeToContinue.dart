import 'package:flutter/material.dart';
import 'package:slide_to_confirm/slide_to_confirm.dart';

class SwipeToContinue extends StatelessWidget {
  const SwipeToContinue({Key? key}) : super(key: key);

  void confirmed() {
    print('Slider confirmed!');
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Center(
              child: ConfirmationSlider(
                onConfirmation: () => confirmed(),
                foregroundColor: Colors.lightGreen,
                textStyle: const TextStyle(
                    color: Colors.black54,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
