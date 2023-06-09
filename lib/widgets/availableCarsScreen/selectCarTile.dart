import 'package:flutter/material.dart';
import 'package:hitchhop/widgets/availableCarsScreen/rideDetailsSheet.dart';

class SelectCarTile extends StatelessWidget {
  const SelectCarTile(
      {Key? key,
      required this.name,
      required this.destination,
      required this.source,
      required this.time})
      : super(key: key);

  final String name;
  final String source;
  final String destination;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          //<-- SEE HERE
          side: const BorderSide(
            color: Color(0xffc9c3ba),
          ),
          borderRadius: BorderRadius.circular(10.0)),
      margin: EdgeInsets.symmetric(vertical: 14.0, horizontal: 26.0),
      color: const Color(0xffece8e6),
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CarDescription(
                      name: name,
                      source: source,
                      destination: destination,
                      time: time,
                    ),
                  ],
                ),
                SizedBox(
                  height: 50.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.network(
                        'https://imageio.forbes.com/specials-images/imageserve/5d35eacaf1176b0008974b54/2020-Chevrolet-Corvette-Stingray/0x0.jpg?format=jpg&crop=4560,2565,x790,y784,safe&width=960'),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 12.0,
            ),
            SizedBox(
              width: double.infinity,
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
                onPressed: () {},
                child: Text('Book later'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CarDescription extends StatelessWidget {
  const CarDescription(
      {super.key,
      required this.name,
      required this.source,
      required this.time,
      required this.destination});

  final String name;
  final String source;
  final String destination;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20.0,
          ),
        ),
        Text(
          source + ' ------> ' + destination,
          style: TextStyle(fontSize: 14.0),
        ),
        Text(
          "Detour time: " + time,
          style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
