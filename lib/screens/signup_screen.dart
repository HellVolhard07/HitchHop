import 'package:flutter/material.dart';
import 'package:hitchhop/constants.dart';

import '../widgets/signupFooter.dart';
import '../widgets/signupForm.dart';
import '../widgets/signupHeader.dart';

class SignupScreenTwo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SignupHeader(image: signupImage, title: signupTitle, subTitle: signupSubTitle),
                SignupForm(),
                SignupFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
