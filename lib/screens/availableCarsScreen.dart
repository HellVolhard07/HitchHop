import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hitchhop/widgets/selectCarTile.dart';

import '../config.dart';
import 'package:http/http.dart' as http;

/*
*
* On swipe to continue for give ride
* do post ride
* to screen with info
*
*/

class AvailableCarsScreen extends StatelessWidget {
  const AvailableCarsScreen({Key? key}) : super(key: key);

  void getAvailableCars(String startLocation, String endLocation) async {
    var reqBody = {
      'source': startLocation,
      'destination': endLocation,
    };

    var response = await http.post(Uri.parse(listTrips),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody));

    var jsonResponse = jsonDecode(response.body);
    print('RESPONSE ${jsonResponse}');
    if (jsonResponse['success']) {
      var myToken = jsonResponse['token'];
      print('hehe ${myToken}');
    } else {
      print('Something went wrong');
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> tripData = [
      {
        "name": "Pulkit Asri",
        "src": "USICT",
        "dest": "Unique Apartments",
        "detour": "45 minutes"
      },
      {
        "name": "Dhruv Pasricha",
        "src": "Karnal",
        "dest": "USICT",
        "detour": "15 minutes"
      },
    ];

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            'Choose a ride',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // RideTypeTile(imageUrl: 'imageUrl', text: 'Take Ride'),
                // RideTypeTile(imageUrl: 'imageUrl', text: 'Give Ride'),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Available cars for ride',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20.0,
                        ),
                      ),
                      Text(
                        '${tripData.length}' ' cars found',
                        style: const TextStyle(
                          fontSize: 12.0,
                        ),
                      )
                    ],
                  ),
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: tripData.length,
                  itemBuilder: (context, index) {
                    return SelectCarTile(
                        name: tripData[index]["name"].toString(),
                        source: tripData[index]['src'].toString(),
                        destination: tripData[index]['dest'].toString(),
                        time: tripData[index]['detour'].toString());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
