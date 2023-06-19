import 'package:flutter/material.dart';
import 'package:hitchhop/widgets/selectCarTile.dart';

class MyRidesScreen extends StatelessWidget {
  const MyRidesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> tripData = [
      {
        "name": "Pulkit Asri",
        "src": "USICT",
        "dest": "Unique Apartments",
      },
      {
        "name": "Dhruv Pasricha",
        "src": "Karnal",
        "dest": "USICT",
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
            'My Trips',
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
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: tripData.length,
                  itemBuilder: (context, index) {
                    return MyTripTile(
                        name: tripData[index]["name"].toString(),
                        source: tripData[index]["src"],
                        destination: tripData[index]["dest"]);
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

class MyTripTile extends StatelessWidget {
  const MyTripTile(
      {Key? key,
      required this.name,
      required this.source,
      required this.destination})
      : super(key: key);

  final String name;
  final String? source;
  final String? destination;

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
                    TripDescription(
                        name: name, source: source, destination: destination),
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
          ],
        ),
      ),
    );
  }
}

class TripDescription extends StatelessWidget {
  const TripDescription(
      {super.key,
      required this.name,
      required this.source,
      required this.destination});

  final String name;
  final String? source;
  final String? destination;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          'From: ' + source! + ' | ',
          style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold),
        ),
        Text(
          'To: ' + destination!,
          style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
