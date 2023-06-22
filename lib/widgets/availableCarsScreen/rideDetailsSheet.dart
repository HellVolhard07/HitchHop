import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../screens/swipeToContinue.dart';

class RideDetailsSheet extends StatefulWidget {
  const RideDetailsSheet(
      {Key? key,
      // required this.source,
      // required this.destination,
      required this.type,
      required this.sourceLatLng,
      required this.destinationLatLng,
      required this.destination,
      required this.source})
      : super(key: key);

  // final String source;
  // final String destination;
  final String type;
  final LatLng sourceLatLng;
  final LatLng destinationLatLng;
  final String source;
  final String destination;

  @override
  State<RideDetailsSheet> createState() => _RideDetailsSheetState();
}

class _RideDetailsSheetState extends State<RideDetailsSheet> {
  final TextEditingController _dateEditingController = TextEditingController();
  final TextEditingController _startTimeEditingController =
      TextEditingController();
  final TextEditingController _endTimeEditingController =
      TextEditingController();

  final FocusNode _eventDate = FocusNode();
  final FocusNode _eventStartTime = FocusNode();
  final FocusNode _eventEndTime = FocusNode();

  late DateTime eventDate;
  late DateTime selectedDate;
  String eventStartTime = "";
  String eventEndTime = "";

  @override
  void dispose() {
    _dateEditingController.dispose();
    _startTimeEditingController.dispose();
    _endTimeEditingController.dispose();
    _eventDate.dispose();
    _eventStartTime.dispose();
    _eventEndTime.dispose();
    super.dispose();
  }

  String source = "";
  String destination = "";

  bool isLoading = false;

  Future<void> getLocation() async {
    setState(() {
      isLoading = true;
    });
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var startLocation = prefs.getString('startLocation');
    var endLocation = prefs.getString('endLocation');

    setState(() {
      source = startLocation!;
      destination = endLocation!;
      isLoading = false;
    });

    print(source);
    print(destination);
  }

  Future<void> init() async {
    await getLocation();
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaquery = MediaQuery.of(context).size;

    return isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(
                  35,
                ),
                topRight: Radius.circular(
                  35,
                ),
              ),
            ),
            height: mediaquery.height * 0.54,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: mediaquery.width * 0.052,
                vertical: mediaquery.width * 0.0156,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(
                          30,
                        ),
                      ),
                      height: 3,
                      width: mediaquery.width * 0.34,
                    ),
                    SizedBox(
                      height: mediaquery.width * 0.036,
                    ),
                    const Text(
                      "Ride Details",
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(),
                    SizedBox(
                      height: mediaquery.width * 0.02,
                    ),
                    Container(
                      width: mediaquery.width * 0.96,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          10.0,
                        ),
                        color: Colors.white,
                      ),
                      child: TextFormField(
                        initialValue: source,
                        style: TextStyle(
                          fontSize: mediaquery.width * 0.05,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "From",
                          hintStyle: TextStyle(
                            fontSize: mediaquery.width * 0.05,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: mediaquery.width * 0.025,
                          ),
                          prefixIcon: const Icon(
                            Icons.my_location,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: mediaquery.width * 0.026,
                    ),
                    Container(
                      width: mediaquery.width * 0.96,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          10.0,
                        ),
                        color: Colors.white,
                      ),
                      child: TextFormField(
                        initialValue: destination,
                        style: TextStyle(
                          fontSize: mediaquery.width * 0.05,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "To",
                          hintStyle: TextStyle(
                            fontSize: mediaquery.width * 0.05,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: mediaquery.width * 0.025,
                          ),
                          prefixIcon: const Icon(
                            Icons.location_on_outlined,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: mediaquery.width * 0.026,
                    ),
                    const Divider(),
                    SizedBox(
                      height: mediaquery.width * 0.026,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          10.0,
                        ),
                        color: Colors.white,
                      ),
                      child: TextFormField(
                        controller: _dateEditingController,
                        readOnly: true,
                        onTap: () async {
                          selectedDate = (await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2100),
                          ))!;
                          eventDate = selectedDate;
                          _dateEditingController.text =
                              DateFormat.yMMMd().format(selectedDate);
                        },
                        onSaved: (date) {
                          setState(() {
                            eventDate = selectedDate;
                            eventDate = DateTime(
                              eventDate.year,
                              eventDate.month,
                              eventDate.day,
                              23,
                              59,
                              59,
                            );
                          });
                        },
                        focusNode: _eventDate,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Required";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Date",
                          hintStyle: TextStyle(
                            fontSize: mediaquery.width * 0.05,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: mediaquery.width * 0.03,
                              horizontal: mediaquery.width * 0.03),
                          suffixIcon: const Icon(
                            Icons.calendar_today_outlined,
                          ),
                        ),
                        onFieldSubmitted: (date) {
                          _eventDate.unfocus();
                          FocusScope.of(context).requestFocus(_eventStartTime);
                        },
                      ),
                    ),
                    SizedBox(
                      height: mediaquery.width * 0.025,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                10.0,
                              ),
                              color: Colors.white,
                            ),
                            child: TextFormField(
                              controller: _startTimeEditingController,
                              readOnly: true,
                              onSaved: (startTime) {
                                setState(() {
                                  eventStartTime =
                                      _startTimeEditingController.text;
                                });
                              },
                              onTap: () async {
                                TimeOfDay selectedStartTime =
                                    (await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                ))!;
                                var dt = DateTime(
                                  DateTime.now().year,
                                  DateTime.now().month,
                                  DateTime.now().day,
                                  selectedStartTime.hour,
                                  selectedStartTime.minute,
                                );
                                _startTimeEditingController.text =
                                    DateFormat("jm").format(dt);
                                eventStartTime =
                                    _startTimeEditingController.text;
                              },
                              focusNode: _eventStartTime,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Required";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Pickup Time",
                                hintStyle: TextStyle(
                                  fontSize: mediaquery.width * 0.04,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: mediaquery.width * 0.04,
                                    horizontal: mediaquery.width * 0.03),
                                suffixIcon: const Icon(
                                  Icons.more_time,
                                ),
                              ),
                              onFieldSubmitted: (_) {
                                _eventStartTime.unfocus();
                                FocusScope.of(context)
                                    .requestFocus(_eventEndTime);
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          width: mediaquery.width * 0.025,
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                10.0,
                              ),
                              color: Colors.white,
                            ),
                            child: TextFormField(
                              controller: _endTimeEditingController,
                              readOnly: true,
                              onSaved: (endTime) {
                                setState(() {
                                  eventEndTime = _endTimeEditingController.text;
                                });
                              },
                              onTap: () async {
                                TimeOfDay selectedEndTime =
                                    (await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                ))!;
                                var dt = DateTime(
                                  DateTime.now().year,
                                  DateTime.now().month,
                                  DateTime.now().day,
                                  selectedEndTime.hour,
                                  selectedEndTime.minute,
                                );
                                _endTimeEditingController.text =
                                    DateFormat("jm").format(dt);
                                eventEndTime = _startTimeEditingController.text;
                              },
                              focusNode: _eventEndTime,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Required";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Drop Time",
                                hintStyle: TextStyle(
                                  fontSize: mediaquery.width * 0.04,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: mediaquery.width * 0.04,
                                    horizontal: mediaquery.width * 0.03),
                                suffixIcon: const Icon(
                                  Icons.more_time,
                                ),
                              ),
                              onFieldSubmitted: (_) {
                                _eventEndTime.unfocus();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: mediaquery.width * 0.026,
                    ),
                    const Divider(),
                    SizedBox(
                      height: mediaquery.width * 0.026,
                    ),
                    SwipeToContinue(
                        type: widget.type,
                        sourceLatLng: widget.sourceLatLng,
                        destinationLatLng: widget.destinationLatLng,
                        source: widget.source,
                        destination: widget.destination),
                    // SizedBox(
                    //   width: double.infinity - 20.0,
                    //   child:
                    //   ElevatedButton(
                    //     onPressed: () {},
                    //     style: ButtonStyle(
                    //       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    //         RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(10.0),
                    //         ),
                    //       ),
                    //       padding: MaterialStateProperty.all<EdgeInsets>(
                    //         const EdgeInsets.all(14.0),
                    //       ),
                    //     ),
                    //     child: const Text(
                    //       'Confirm Location',
                    //       style: TextStyle(
                    //         fontSize: 16.0,
                    //       ),
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              ),
            ),
          );
  }
}
