import 'package:flutter/material.dart';

class NewCarSelectTile extends StatelessWidget {
  const NewCarSelectTile(
      {Key? key,
      required this.name,
      required this.destination,
      required this.source,
      required this.time,
      required this.reviews,
      required this.stars})
      : super(key: key);

  final String name;
  final String source;
  final String destination;
  final String time;
  final String stars;
  final String reviews;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 10.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.grey[100],
      ),
      child: Column(
        children: [
          ListTile(
            title: Text(source),
            subtitle: Text("Lorem ipsum dolores"),
            leading: Icon(Icons.location_on_outlined, color: Colors.red),
          ),
          ListTile(
            title: Text(destination),
            subtitle: Text("Lorem ipsum dolores"),
            leading: Icon(
              Icons.location_on,
              color: Colors.green,
            ),
            trailing: SizedBox(
              height: 50.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.asset('assets/images/Car.png'),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14.0),
              border: Border.all(
                color: Color(0xff6750a4),
              ),
              color: Colors.grey[300],
            ),
            child: ListTile(
              title: Text(name),
              subtitle: Text(stars + " stars (" + reviews + " reviews)"),
              trailing: Text(
                time + ' mins',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
