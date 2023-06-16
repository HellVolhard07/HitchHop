import 'package:flutter/material.dart';
import 'package:hitchhop/screens/loginScreen.dart';

class SignupFooter extends StatelessWidget {
  const SignupFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Or'),
        SizedBox(height: 20.0,),
        SizedBox(width: double.infinity,
        child: OutlinedButton.icon(onPressed: () => {}, icon: Icon(Icons.facebook), label: Text('Signin with google',),),),
        TextButton(onPressed: () {
          Navigator.pop(context);
        }, child: Text.rich(
          TextSpan(
            children: [
              TextSpan(text: 'Already have an account?', style: Theme.of(context).textTheme.bodyText1,),
              TextSpan(text: 'Login')
            ]
          )
        ))
      ],
    );
  }
}
