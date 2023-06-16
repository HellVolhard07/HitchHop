import 'package:flutter/material.dart';

class SignupScreenOld extends StatelessWidget {
  const SignupScreenOld({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.redAccent,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: mediaQuery.size.width * 0.05,
            vertical: mediaQuery.size.height * 0.03,
          ),
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 360.0,
                ),
                Column(
                  children: [
                    Text(
                      'Sign Up',
                      style: TextStyle(
                          fontSize: 40.0, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "It's easier to sign up now",
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40.0,
                ),
                Container(
                  height: mediaQuery.size.height * 0.08,
                  width: mediaQuery.size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: TextButton.icon(
                    onPressed: () => {},
                    icon: const Icon(Icons.facebook, size: 32.0),
                    label: const Text(
                      "Continue with facebook",
                      style: TextStyle(color: Colors.black, fontSize: 18.0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24.0,
                ),
                Container(
                  height: mediaQuery.size.height * 0.06,
                  width: mediaQuery.size.width * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextButton(
                    onPressed: () => {},
                    child: const Text(
                      "I'll use my email or phone instead",
                      style: TextStyle(color: Colors.black, fontSize: 14.0),
                    ),
                  ),
                ),
                const SizedBox(height: 14.0,),
                const Text('Or', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),),
                const SizedBox(height: 10.0,),
                // TODO: Add necessary icons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                        radius: 24.0,
                        backgroundColor: Colors.yellow,
                        child: IconButton(
                            onPressed: () => {},
                            icon: const Icon(Icons.mail),
                            splashRadius: 24.0)),
                    const SizedBox(
                      width: 10.0,
                    ),
                    CircleAvatar(
                        radius: 24.0,
                        backgroundColor: Colors.yellow,
                        child: IconButton(
                            onPressed: () => {},
                            icon: const Icon(Icons.mail),
                            splashRadius: 24.0),),
                    const SizedBox(
                      width: 10.0,
                    ),
                    CircleAvatar(
                        radius: 24.0,
                        backgroundColor: Colors.yellow,
                        child: IconButton(
                            onPressed: () => {},
                            icon: const Icon(Icons.mail),
                            splashRadius: 24.0),),
                  ],
                ),
                const SizedBox(height: 20.0,),
                RichText(
                  text: const TextSpan(
                    children: <TextSpan>[
                      TextSpan(text: ' Already have an account? ', style: TextStyle(fontSize: 16.0,),),
                      TextSpan(text: 'Login', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0,),),
                    ],
                  ),
                )
                ,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
