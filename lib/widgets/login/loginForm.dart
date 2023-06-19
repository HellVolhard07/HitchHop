import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hitchhop/screens/mapSample.dart';
import 'package:hitchhop/config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hitchhop/screens/bottomNavBar.dart';

import '../../screens/landingScreen.dart';
import 'package:http/http.dart' as http;

class LoginForm extends StatelessWidget {
  LoginForm({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // late SharedPreferences prefs; // @TODO- kabhi token save karne ka mann kare to

  void loginUser(BuildContext context) async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      var reqBody = {
        'email': emailController.text,
        "password": passwordController.text
      };
      print(Uri.parse(login));
      var response = await http.post(Uri.parse(login),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(reqBody));

      var jsonResponse = jsonDecode(response.body);
      print('RESPONSE ${jsonResponse}');
      final user = jsonResponse['user'];

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('userId', jsonResponse['user']['_id']);
      await prefs.setString('name', jsonResponse['user']['name']);
      await prefs.setString('email', jsonResponse['user']['email']);
      await prefs.setString('token', jsonResponse['token']);
      if (jsonResponse['success']) {
        var myToken = jsonResponse['user']['email'];
        // prefs.setString('token', myToken); @TODO- kabhi token save karne ka mann kare to
        print(user['name']);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BottomNavBar()),
        );
      } else {
        print('Something went wrong');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: emailController,
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
              controller: passwordController,
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
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => MapSample()),
                  // );
                  loginUser(context);
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
