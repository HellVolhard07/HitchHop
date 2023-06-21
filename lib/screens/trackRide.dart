import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hitchhop/config.dart';
import 'package:hitchhop/location_service.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hitchhop/screens/bottomNavBar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class TrackRide extends StatefulWidget {
  TrackRide({Key? key}) : super(key: key);

  @override
  State<TrackRide> createState() => _TrackRideState();
}

class _TrackRideState extends State<TrackRide> {
  //maps shit
  GoogleMapController? mapController;

  Set<Marker> _markers = Set<Marker>();
  Set<Polygon> _polygons = Set<Polygon>();
  Set<Polyline> _polylines = Set<Polyline>();
  int _polylineIdCounter = 1;

  String source = "";
  String destination = "";
  String name = "";

  bool isLoading = false;

  Future<void> getLocation() async {
    setState(() {
      isLoading = true;
    });
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var startLocation = prefs.getString('startLocation');
    var endLocation = prefs.getString('endLocation');
    var driverName = prefs.getString('name');

    setState(() {
      source = startLocation!;
      destination = endLocation!;
      name = driverName!;
      isLoading = false;
    });
  }

  Future<void> init() async {
    await getLocation();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  void handleShowRoute() async {
    var directions = await LocationService().getDirections(
      source!,
      destination!,
    );

    // @TODO @sarthak - take these start and end location and send it to the api call in availableCarsScreen.dart
    var start_latLng = directions['start_location'];
    var end_latLng = directions['end_location'];

    var boundsNe = directions['bounds_ne'];
    var boundsSw = directions['bounds_sw'];

    _setPolyline(directions['polyline_decoded']);
    _setMarker(
        LatLng(start_latLng['lat'], start_latLng['lng']), 'startLocation');
    _setMarker(LatLng(end_latLng['lat'], end_latLng['lng']), 'endLocation');

    mapController?.animateCamera(
      CameraUpdate.newLatLngBounds(
          LatLngBounds(
            southwest: LatLng(boundsSw['lat'], boundsSw['lng']),
            northeast: LatLng(boundsNe['lat'], boundsNe['lng']),
          ),
          25),
    );
  }

  void _setMarker(LatLng point, id) {
    setState(() {
      _markers.removeWhere((marker) => marker.markerId.value == id);
      _markers.add(
        Marker(
          markerId: MarkerId(id),
          position: point,
        ),
      );
    });
  }

  void _setPolyline(List<PointLatLng> points) {
    final String polylineIdVal = 'polyline_$_polylineIdCounter';
    _polylineIdCounter++;

    _polylines.add(
      Polyline(
        polylineId: PolylineId(polylineIdVal),
        width: 2,
        color: Colors.blue,
        points: points
            .map(
              (point) => LatLng(point.latitude, point.longitude),
            )
            .toList(),
      ),
    );
  }

  Future<String?> getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? id = prefs.getString('userId');
    return id;
  }

  @override
  Widget build(BuildContext context) {
    LatLng point = LatLng(27.6602292, 85.308027);
    getLocation();
    handleShowRoute();
    final mediaquery = MediaQuery.of(context).size;
    Future<String?> id = getUserId();
    String? userId;
    id.then((value) {
      userId = value;
    });

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Track Ride',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: mediaquery.height * 0.03,
                ),
                height: mediaquery.width * 0.8,
                width: mediaquery.width * 0.8,
                child: GoogleMap(
                  compassEnabled: true,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  zoomControlsEnabled: false,
                  zoomGesturesEnabled: true,
                  mapType: MapType.normal,
                  markers: _markers,
                  polygons: _polygons,
                  polylines: _polylines,
                  initialCameraPosition: CameraPosition(
                    //inital position in map
                    target: point, //initial position
                    zoom: 14.0, //initial zoom level
                  ),
                  onMapCreated: (controller) {
                    //method called when map is created
                    setState(() {
                      mapController = controller;
                    });
                  },
                  // onTap: (point) {
                  //   setState(() {
                  //     polygonLatLngs.add(point);
                  //     // _setPolygon();
                  //   });
                  // },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 30.0),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 20.0,
                    horizontal: 30.0,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xffF8F4EA),
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ride Details',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 26.0,
                        ),
                      ),
                      Text.rich(TextSpan(children: [
                        TextSpan(
                          text: "Driver: ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        TextSpan(
                          text: name,
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ])),
                      Text.rich(TextSpan(children: [
                        TextSpan(
                          text: "Start Location: ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        TextSpan(
                          text: source!,
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ])),
                      Text.rich(TextSpan(children: [
                        TextSpan(
                          text: "End Location: ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        TextSpan(
                          text: destination!,
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ])),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: mediaquery.width * 0.5,
                child: TextButton(
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.redAccent),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xffF8F4EA)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  onPressed: () async {
                    var reqBody = {
                      'userId': userId,
                    };

                    var response = await http.delete(Uri.parse(cancelTrip),
                        headers: {"Content-Type": "application/json"},
                        body: jsonEncode(reqBody));

                    if (response.statusCode == 200) {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => BottomNavBar()),
                          (route) => false);
                    } else {
                      final snackBar = SnackBar(
                        content: const Text('Something went wrong'),
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
                  },
                  child: const Text(
                    'Cancel Ride',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: mediaquery.width * 0.5,
                child: TextButton(
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Color(0xffF8F4EA)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xff6750a4)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  onPressed: () async {
                    var reqBody = {
                      'userId': userId,
                    };

                    var response = await http.post(Uri.parse(completeTrip),
                        headers: {"Content-Type": "application/json"},
                        body: jsonEncode(reqBody));

                    if (response.statusCode == 200) {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => BottomNavBar()),
                          (route) => false);
                    } else {
                      final snackBar = SnackBar(
                        content: const Text('Something went wrong'),
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
                  },
                  child: Text(
                    'End Ride',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
