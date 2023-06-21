import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hitchhop/config.dart';
import 'package:hitchhop/screens/availableCarsScreen.dart';
import 'package:hitchhop/screens/profileScreen.dart';
import 'package:hitchhop/screens/trackRide.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slide_to_confirm/slide_to_confirm.dart';
import 'package:http/http.dart' as http;

class SwipeToContinue extends StatelessWidget {
  const SwipeToContinue(
      {Key? key,
      required this.type,
      required this.sourceLatLng,
      required this.destinationLatLng,
      required this.source,
      required this.destination})
      : super(key: key);

  final String type;
  final LatLng sourceLatLng;
  final LatLng destinationLatLng;
  final String source;
  final String destination;

  Future<String?> getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? id = prefs.getString('userId');
    return id;
  }

  void confirmed(BuildContext context, String userId) async {
    print(userId);
    if (type == 'take') {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AvailableCarsScreen(
                  sourceLatLng: sourceLatLng,
                  destinationLatLng: destinationLatLng,
                )),
      );
    } else {
      // @TODO @sarthak - fill appropriate data here
      var reqBody = {
        "userId": userId,
        "source": {
          "lat": sourceLatLng.latitude,
          "lng": sourceLatLng.longitude,
          "place": source
        },
        "destination": {
          "lat": destinationLatLng.latitude,
          "lng": destinationLatLng.longitude,
          "place": destination
        },
        "dateTime": "2023-06-16T19:30:00.535+00:00",
        "max_riders": 2
      };
      // @TODO- @sarthak add path in global strings /trip/drive

      var response = await http.post(Uri.parse(postTrip),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(reqBody));

      print(response.body);

      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TrackRide()),
        );
      } else {
        print("Hello");
        final snackBar = SnackBar(
          content: const Text('Something went wrong!'),
          action: SnackBarAction(
            label: 'TRY AGAIN',
            onPressed: () {
              // Some code to undo the change.
            },
          ),
        );

        // Find the ScaffoldMessenger in the widget tree
        // and use it to show a SnackBar.
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  Widget build(BuildContext context) {
    Future<String?> userId = getUserId();
    String? id;
    userId.then((value) {
      id = value;
    });
    return ConfirmationSlider(
      onConfirmation: () => confirmed(context, id!),
      foregroundColor: Color(0xff6750a4),
      textStyle: const TextStyle(
          color: Colors.black54, fontSize: 18.0, fontWeight: FontWeight.bold),
    );
  }
}
