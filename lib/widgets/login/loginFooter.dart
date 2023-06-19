import 'package:flutter/material.dart';
import 'package:hitchhop/screens/signupScreen.dart';

class LoginFooter extends StatelessWidget {
  const LoginFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Or'),
        SizedBox(
          height: 10.0,
        ),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () => {},
            icon: Icon(Icons.facebook),
            label: Text(
              'Signin with google',
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignupScreen()),
            );
          },
          child: Text.rich(TextSpan(children: [
            TextSpan(
              text: "Don't have an account?",
              style: Theme.of(context).textTheme.bodyText1,
            ),
            TextSpan(text: 'Signup')
          ])),
        ),
      ],
    );
  }
}
