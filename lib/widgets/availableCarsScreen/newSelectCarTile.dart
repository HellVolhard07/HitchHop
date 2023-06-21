import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hitchhop/config.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../screens/bottomNavBar.dart';

class NewCarSelectTile extends StatelessWidget {
  const NewCarSelectTile(
      {Key? key,
      required this.name,
      required this.destination,
      required this.source,
      required this.time,
      required this.reviews,
      required this.stars,
      required this.sourceLatLng,
      required this.destinationLatLng,
      required this.tripId})
      : super(key: key);

  final String name;
  final String source;
  final String destination;
  final String time;
  final String stars;
  final String reviews;
  final LatLng sourceLatLng;
  final LatLng destinationLatLng;
  final String tripId;

  void startRide(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('userId');
    var reqBody = {
      'userId': userId!,
      'tripId': tripId,
      'source': {
        "lat": sourceLatLng.latitude,
        "lng": sourceLatLng.longitude,
        "place": source,
      },
      'destination': {
        "lat": destinationLatLng.latitude,
        "lng": destinationLatLng.longitude,
        "place": destination,
      },
    };

    var response = await http.post(Uri.parse(attachTrip),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody));

    print("Attach: ${response.body}");
    final snackBar = SnackBar(
      content: const Text('Ride confirmed!'),
      action: SnackBarAction(
        label: 'OK!',
        onPressed: () {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => BottomNavBar()),
              (route) => false);
        },
      ),
    );

    // Find the ScaffoldMessenger in the widget tree
    // and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        startRide(context);
      },
      child: Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 10.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.grey[100],
        ),
        child: Column(
          children: [
            ListTile(
              title: Text(source),
              subtitle: Text("Lorem ipsum dolores"),
              leading: Icon(Icons.location_on_outlined, color: Colors.red),
            ),
            ListTile(
              title: Text(destination),
              subtitle: Text("Lorem ipsum dolores"),
              leading: Icon(
                Icons.location_on,
                color: Colors.green,
              ),
              trailing: SizedBox(
                height: 50.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.asset('assets/images/Car.png'),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14.0),
                border: Border.all(
                  color: Color(0xff6750a4),
                ),
                color: Colors.grey[300],
              ),
              child: ListTile(
                title: Text(name),
                subtitle: Text(stars + " stars (" + reviews + " reviews)"),
                trailing: Text(
                  time + ' mins',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
