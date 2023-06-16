import 'package:flutter/material.dart';
import 'package:hitchhop/constants.dart';

import '../widgets/signup/signupFooter.dart';
import '../widgets/signup/signupForm.dart';
import '../widgets/signup/signupHeader.dart';

class SignupScreen extends StatelessWidget {

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
