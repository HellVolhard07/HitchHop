import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hitchhop/config.dart';
import 'package:hitchhop/screens/landingScreen.dart';
import 'package:http/http.dart' as http;


class SignupForm extends StatelessWidget {
  SignupForm({Key? key}) : super(key: key);

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  // late SharedPreferences prefs; // @TODO- kabhi token save karne ka mann kare to

  void signupUser(BuildContext context) async {
    if(emailController.text.isNotEmpty
        && passwordController.text.isNotEmpty
        && phoneNoController.text.isNotEmpty
        && nameController.text.isNotEmpty){
      var reqBody ={
        'phone_number': phoneNoController.text,
        'email': emailController.text,
        'password': passwordController.text,
        'name': nameController.text,
        'lastname': '', // @TODO-ask- rakhna h kya ?
      };
      print(Uri.parse(register));
      var response = await http.post(Uri.parse(register),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(reqBody)
      );

      var jsonResponse= jsonDecode(response.body);
      print('RESPONSE ${jsonResponse}');
      if(jsonResponse['success']){
        var myToken = jsonResponse['token'];
        // prefs.setString('token', myToken); @TODO- kabhi token save karne ka mann kare to
        print('hehe ${myToken}');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LandingScreen()),
        );
      }else{
        print('Something went wrong');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: nameController,
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
            SizedBox(height: 20.0,),
            TextFormField(
              controller: phoneNoController,
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
              controller: passwordController,
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
                child: ElevatedButton(onPressed: () => {
                  signupUser(context)
                }, child: Text('Signup'),),),
          ],
        ),
      ),
    );
  }
}
