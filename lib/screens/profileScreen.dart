import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Profile', style: TextStyle(fontSize: 18.0),),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10.0, bottom: 20.0),
              height: 100.0,
              width: 100.0,
              child: CircleAvatar(
                backgroundImage: NetworkImage('https://imageio.forbes.com/specials-images/imageserve/5d35eacaf1176b0008974b54/2020-Chevrolet-Corvette-Stingray/0x0.jpg?format=jpg&crop=4560,2565,x790,y784,safe&width=960'),
                ),
            ),
            Text('Nate Samson',style: TextStyle(fontWeight: FontWeight.w400, fontSize: 28.0),),

            // TODO: Add fields from penthouse or USSApp

          ],
        ),
      ),
    );
  }
}
