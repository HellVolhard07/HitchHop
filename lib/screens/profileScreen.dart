import 'package:flutter/material.dart';
import 'package:hitchhop/constants.dart';
import 'package:hitchhop/screens/loginScreen.dart';
import 'package:hitchhop/screens/myRidesScreen.dart';
import 'package:hitchhop/widgets/profile/profileScreenTile.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.chevron_left,
          ),
        ),
        centerTitle: true,
        title: Text(
          'Profile',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(
            30.0,
          ),
          child: Column(
            children: [
              SizedBox(
                height: 120.0,
                width: 120.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    40.0,
                  ),
                  child: Image(
                    image: NetworkImage(
                      loginImage,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                'Nate Samson',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 28.0),
              ),
              Text(
                'natesamson@gmail.com',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.0),
              ),
              SizedBox(
                height: 10.0,
              ),
              SizedBox(
                width: 200.0,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Edit Profile'),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Divider(),
              SizedBox(
                height: 10.0,
              ),
              ProfileScreenTile(
                title: 'Settings',
                icon: Icons.settings,
                onPress: () {},
              ),
              ProfileScreenTile(
                title: 'My Trips',
                icon: Icons.wallet_outlined,
                onPress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyRidesScreen()),
                  );
                },
              ),
              Divider(),
              ProfileScreenTile(
                title: 'Information',
                icon: Icons.info_outline_rounded,
                onPress: () {},
              ),
              ProfileScreenTile(
                title: 'Logout',
                icon: Icons.logout_outlined,
                onPress: () {
                  // Todo: await auth.signOut();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
