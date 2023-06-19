import 'package:flutter/material.dart';
import 'package:hitchhop/constants.dart';

import 'package:hitchhop/dont_commit.dart';
import 'package:hitchhop/location_service.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:hitchhop/screens/bottomNavBar.dart';
import 'package:hitchhop/screens/landingScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  late final String? source;
  late final String? destination;
  late final String? name;

  void getLocation() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var startLocation = prefs.getString('startLocation');
    var endLocation = prefs.getString('endLocation');
    var driverName = prefs.getString('name');

    setState(() {
      source = startLocation;
      destination = endLocation;
      name = driverName!;
    });
  }

  void handleShowRoute() async {
    var directions = await LocationService().getDirections(
      source!,
      destination!,
    );

    // @TODO @sarthak - take these start and end location and send it to the api call in availableCarsScreen.dart
    var start_latLng = directions['start_location'];
    var end_latLng = directions['end_location'];

    var boundsNe= directions['bounds_ne'];
    var boundsSw= directions['bounds_sw'];


    _setPolyline(directions['polyline_decoded']);
    _setMarker(LatLng(start_latLng['lat'], start_latLng['lng']), 'startLocation');
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

  @override
  Widget build(BuildContext context) {
    LatLng point = LatLng(27.6602292, 85.308027);
    getLocation();
    handleShowRoute();
    final mediaquery = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(
                top: mediaquery.height * 0.1,
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
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
                      ),
                    ),
                    TextSpan(
                      text: name,
                    ),
                  ])),
                  Text.rich(TextSpan(children: [
                    TextSpan(
                      text: "Start Location: ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: source!,
                    ),
                  ])),
                  Text.rich(TextSpan(children: [
                    TextSpan(
                      text: "End Location: ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: destination!,
                    ),
                  ])),
                ],
              ),
            ),
            SizedBox(
              width: mediaquery.width * 0.5,
              child: TextButton(
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Color(0xff579BB1)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xffF8F4EA)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => BottomNavBar()),
                      (route) => false);
                },
                child: Text('End Ride'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
