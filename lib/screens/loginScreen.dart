import 'package:flutter/material.dart';
import 'package:hitchhop/constants.dart';

import '../widgets/login/loginForm.dart';
import '../widgets/login/loginFooter.dart';
import '../widgets/signup/signupHeader.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

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
                SignupHeader(image: loginImage, title: loginTitle, subTitle: loginSubTitle),
                LoginForm(),
                LoginFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
