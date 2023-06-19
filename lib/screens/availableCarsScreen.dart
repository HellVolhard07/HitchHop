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

class AvailableCarsScreen extends StatefulWidget {
  const AvailableCarsScreen({Key? key}) : super(key: key);

  @override
  State<AvailableCarsScreen> createState() => _AvailableCarsScreenState();
}

class _AvailableCarsScreenState extends State<AvailableCarsScreen> {
  Future<List<dynamic>> getAvailableCars(String startLocation, String endLocation) async {

    // @TODO @sarthak- Wo lat lng point idhar
    var reqBody = {
      'source': {
        "lat": 28.6562484958429,
        "lng": 77.24075317382812
      },
      'destination': {
        "lat": 28.116610865104626,
        "lng": 77.2692718132267
      },
    };

    var response = await http.post(Uri.parse(listTrips),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody));

    var jsonResponse = jsonDecode(response.body);
    print('RESPONSE ${jsonResponse.trips}');

    if (jsonResponse['success']) {
      print('hehehehe list trip successfull');

      return jsonResponse['trips'];
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: getAvailableCars("", ""),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // If the API call was successful, build the ListView
          List? tripData = snapshot.data;
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
                              '${tripData?.length}' ' cars found',
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
                        itemCount: tripData?.length,
                        itemBuilder: (context, index) {
                          return SelectCarTile(
                              name: tripData![index]["name"].toString(),
                              source: tripData![index]['src'].toString(),
                              destination: tripData![index]['dest'].toString(),
                              time: tripData![index]['detour'].toString());
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          // If the API call was unsuccessful, display an error message
          return Center(
            child: Text('${snapshot.error}'),
          );
        }

        // If the data is still being loaded, show a loading indicator
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
