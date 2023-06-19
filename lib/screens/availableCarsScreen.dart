import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hitchhop/widgets/availableCarsScreen/newSelectCarTile.dart';
import 'package:hitchhop/widgets/availableCarsScreen/selectCarTile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config.dart';
import 'package:http/http.dart' as http;

class AvailableCarsScreen extends StatefulWidget {
  const AvailableCarsScreen({Key? key}) : super(key: key);

  @override
  State<AvailableCarsScreen> createState() => _AvailableCarsScreenState();
}

class _AvailableCarsScreenState extends State<AvailableCarsScreen> {
  Future<List<dynamic>> getAvailableCars(String startLocation,
      String endLocation) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? sourceLatLng = prefs.getString('startLatLng');
    print("Source lat $sourceLatLng");

    // @TODO @sarthak- Wo lat lng point idhar
    var reqBody = {
      'source': {"lat": 28.6562484958429, "lng": 77.24075317382812},
      'destination': {"lat": 28.116610865104626, "lng": 77.2692718132267},
    };

    var response = await http.post(Uri.parse(listTrips),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody));

    var jsonResponse = jsonDecode(response.body);

    if (jsonResponse['success']) {
      print('hehehehe RESPONSE ${jsonResponse}');
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
                          return NewCarSelectTile(
                            // name:
                            //     tripData![index]["driver"]["name"].toString(),
                            source: tripData![index]['source']['place']
                                .toString(),
                            destination: tripData![index]['destination']
                            ['place']
                                .toString(),
                            time: timeList![index]['time'].toString(),
                            stars: timeList[index]['stars'].toString(),
                            reviews: timeList[index]['reviews'].toString(),
                            name: timeList[index]['name'].toString(),

                          );
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

const timeList = [
  {"time": "12", "name": "Pulkit Asri", "stars": "3.3", "reviews": "418"},
  {"time": "3", "name": "Sarthak K", "stars": "4.7", "reviews": "30"},
  {"time": "7", "name": "Dhruv Pasricha", "stars": "4.2", "reviews": "687"},
];
