import 'package:flutter/material.dart';
import 'package:hitchhop/screens/mapSample.dart';

import '../../screens/landingScreen.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            SizedBox(
              height: 20.0,
            ),
            TextFormField(
              decoration: const InputDecoration(
                label: Text(
                  'Password',
                ),
                prefixIcon: Icon(
                  Icons.fingerprint,
                  // TODO: iconColor: color,
                ),
                suffixIcon: IconButton(
                  onPressed: null,
                  icon: Icon(
                    Icons.remove_red_eye_sharp,
                  ),
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
            SizedBox(
              height: 20.0,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MapSample()),
                  );
                },
                child: Text('Login'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
