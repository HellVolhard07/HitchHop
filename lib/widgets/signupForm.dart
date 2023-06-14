import 'package:flutter/material.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                label: Text(
                  'Full Name',
                ),
                prefixIcon: Icon(
                  Icons.person_outline_rounded,
                  // TODO: iconColor: color,
                ),
                border: OutlineInputBorder(),
                // Todo: labelStyle: TextStyle(color: color),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2.0,
                    //Todo: color: color,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0,),
            TextFormField(
              decoration: const InputDecoration(
                label: Text(
                  'Email',
                ),
                prefixIcon: Icon(
                  Icons.email_outlined,
                  // TODO: iconColor: color,
                ),
                border: OutlineInputBorder(),
                // Todo: labelStyle: TextStyle(color: color),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2.0,
                    //Todo: color: color,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0,),
            TextFormField(
              decoration: const InputDecoration(
                label: Text(
                  'Phone No',
                ),
                prefixIcon: Icon(
                  Icons.numbers,
                  // TODO: iconColor: color,
                ),
                border: OutlineInputBorder(),
                // Todo: labelStyle: TextStyle(color: color),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2.0,
                    //Todo: color: color,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0,),
            TextFormField(
              decoration: const InputDecoration(
                label: Text(
                  'Password',
                ),
                prefixIcon: Icon(
                  Icons.fingerprint,
                  // TODO: iconColor: color,
                ),
                border: OutlineInputBorder(),
                // Todo: labelStyle: TextStyle(color: color),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2.0,
                    //Todo: color: color,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0,),
            SizedBox(width: double.infinity,
                child: ElevatedButton(onPressed: () => {}, child: Text('Signup'),),),
          ],
        ),
      ),
    );
  }
}
