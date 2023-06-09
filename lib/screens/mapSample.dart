import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hitchhop/dont_commit.dart';
import 'package:hitchhop/location_service.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/availableCarsScreen/rideDetailsSheet.dart';

class MapSample extends StatefulWidget {
  const MapSample({Key? key, required this.type}) : super(key: key);
  final String type;

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  // Completer<GoogleMapController> _controller = Completer();

  String googleApikey = api_key;
  GoogleMapController? mapController;

  Set<Marker> _markers = Set<Marker>();
  Set<Polygon> _polygons = Set<Polygon>();
  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polygonLatLngs = <LatLng>[];

  CameraPosition? cameraPosition;
  LatLng startLocation = LatLng(27.6602292, 85.308027);
  LatLng endLocation = LatLng(27.6602292, 85.308027);

  String startLocationString = "";
  String endLocationString = "";

  int _polylineIdCounter = 1;

  @override
  void initState() {
    super.initState();
    _setMarker(startLocation, 'startLocation');
  }

  void showSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => RideDetailsSheet(
          sourceLatLng: startLocation,
          destinationLatLng: endLocation,
          source: startLocationString,
          destination: endLocationString,
          type: widget.type),
    );
  }

  Future<void> handleSearch() async {
    await handleOnPressSearch();
  }

  Future<void> handleOnPressSearch() async {
    var directions = await LocationService().getDirections(
      startLocationString,
      endLocationString,
    );

    // @TODO @sarthak - take these start and end location and send it to the api call in availableCarsScreen.dart
    var start_location = directions['start_location'];
    var end_location = directions['end_location'];

    print('hehehehehehehehe ${directions['start_location']}');

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('startLocation');
    await prefs.remove('endLocation');
    await prefs.setString('startLocation', startLocationString);
    await prefs.setString('endLocation', endLocationString);
    print("MAPSAMPLE: " + startLocationString);
    print("MAPSAMPLE: " + endLocationString);

    // _goToPlace(
    //   directions['start_location']['lat'],
    //   directions['start_location']['lng'],
    //   directions['bounds_ne'],
    //   directions['bounds_sw'],
    // );

    _setPolyline(directions['polyline_decoded']);
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: Text(
              widget.type == 'give' ? 'Give Ride' : 'Take Ride',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.chevron_left),
              onPressed: () {
                Navigator.pop(context);
              },
            )),
        floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          child: const Icon(
            Icons.arrow_right_alt_outlined,
            size: 40.0,
          ),
          onPressed: () {
            showSheet();
          },
        ),
        body: Stack(
          children: [
            GoogleMap(
              compassEnabled: true,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              mapType: MapType.normal,
              markers: _markers,
              polygons: _polygons,
              polylines: _polylines,
              initialCameraPosition: CameraPosition(
                //inital position in map
                target: startLocation, //initial position
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

            //Source - search autocomplete input
            Positioned(
              //search input bar
              top: 10,
              child: Column(
                children: [
                  InkWell(
                    onTap: () async {
                      var place = await PlacesAutocomplete.show(
                          context: context,
                          apiKey: googleApikey,
                          mode: Mode.overlay,
                          types: [],
                          strictbounds: false,
                          components: [Component(Component.country, 'in')],
                          //google_map_webservice package
                          onError: (err) {
                            print(err);
                          });

                      if (place != null) {
                        setState(() {
                          startLocationString = place.description.toString();
                          if (endLocationString != "") {
                            handleSearch();
                          }
                        });

                        //form google_maps_webservice package
                        final plist = GoogleMapsPlaces(
                          apiKey: googleApikey,
                          apiHeaders:
                              await const GoogleApiHeaders().getHeaders(),
                          //from google_api_headers package
                        );
                        String placeid = place.placeId ?? "0";
                        final detail = await plist.getDetailsByPlaceId(placeid);
                        final geometry = detail.result.geometry!;
                        final lat = geometry.location.lat;
                        final lang = geometry.location.lng;
                        var newlatlang = LatLng(lat, lang);
                        //move map camera to selected place with animation
                        _setMarker(newlatlang, 'startLocation');
                        mapController?.animateCamera(
                            CameraUpdate.newCameraPosition(
                                CameraPosition(target: newlatlang, zoom: 17)));
                      }
                    },
                    //Destination
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Card(
                        child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 10.0,
                            ),
                            width: MediaQuery.of(context).size.width - 40,
                            child: ListTile(
                              title: Text(
                                startLocationString,
                                style: TextStyle(fontSize: 18),
                              ),
                              leading: Icon(Icons.search),
                              dense: true,
                            )),
                      ),
                    ),
                  ),
                  InkWell(
                      onTap: () async {
                        var place = await PlacesAutocomplete.show(
                            context: context,
                            apiKey: googleApikey,
                            mode: Mode.overlay,
                            types: [],
                            strictbounds: false,
                            components: [Component(Component.country, 'in')],
                            //google_map_webservice package
                            onError: (err) {
                              print(err);
                            });

                        if (place != null) {
                          setState(() {
                            endLocationString = place.description.toString();
                            if (startLocationString != "") {
                              handleSearch();
                            }
                          });

                          //form google_maps_webservice package
                          final plist = GoogleMapsPlaces(
                            apiKey: googleApikey,
                            apiHeaders:
                                await const GoogleApiHeaders().getHeaders(),
                            //from google_api_headers package
                          );
                          String placeid = place.placeId ?? "0";
                          final detail =
                              await plist.getDetailsByPlaceId(placeid);
                          final geometry = detail.result.geometry!;
                          final lat = geometry.location.lat;
                          final lang = geometry.location.lng;
                          var newlatlang = LatLng(lat, lang);
                          //move map camera to selected place with animation
                          _setMarker(newlatlang, 'endLocation');
                          mapController?.animateCamera(
                              CameraUpdate.newCameraPosition(CameraPosition(
                                  target: newlatlang, zoom: 17)));
                        }
                        showSheet();
                      },
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Card(
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.0,
                                vertical: 10.0,
                              ),
                              width: MediaQuery.of(context).size.width - 40,
                              child: ListTile(
                                title: Text(
                                  endLocationString,
                                  style: TextStyle(fontSize: 18),
                                ),
                                leading: Icon(Icons.search),
                                dense: true,
                              )),
                        ),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

// Future<void> _goToPlace(
//   // Map<String, dynamic> place,
//   double lat,
//   double lng,
//   Map<String, dynamic> boundsNe,
//   Map<String, dynamic> boundsSw,
// ) async {
//   // final double lat = place['geometry']['location']['lat'];
//   // final double lng = place['geometry']['location']['lng'];
//
//   // final GoogleMapController mapController = await _controller.future;
//   mapController?.animateCamera(
//     CameraUpdate.newCameraPosition(
//       CameraPosition(target: LatLng(lat, lng), zoom: 12),
//     ),
//   );
//
//   mapController?.animateCamera(
//     CameraUpdate.newLatLngBounds(
//         LatLngBounds(
//           southwest: LatLng(boundsSw['lat'], boundsSw['lng']),
//           northeast: LatLng(boundsNe['lat'], boundsNe['lng']),
//         ),
//         25),
//   );
//   _setMarker(LatLng(lat, lng));
// }
}
