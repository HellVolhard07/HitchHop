import 'package:flutter/material.dart';
import 'package:hitchhop/constants.dart';

class ConfirmRideSheet extends StatelessWidget {
  const ConfirmRideSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaquery = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        color: Colors.lightGreen,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            35,
          ),
          topRight: Radius.circular(
            35,
          ),
        ),
      ),
      height: mediaquery.width * 0.8,
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
              Text(
                "Select Address",
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Divider(),
              SizedBox(
                height: mediaquery.width * 0.02,
              ),
              Container(
                width: mediaquery.width * 0.96,
                child: TextFormField(
                  style: TextStyle(
                    fontSize: mediaquery.width * 0.054,
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
                    prefixIcon: Icon(
                      Icons.my_location,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    10.0,
                  ),
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: mediaquery.width * 0.026,
              ),
              Container(
                width: mediaquery.width * 0.96,
                child: TextFormField(
                  style: TextStyle(
                    fontSize: mediaquery.width * 0.054,
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
                    prefixIcon: Icon(
                      Icons.location_on_outlined,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    10.0,
                  ),
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: mediaquery.width * 0.026,
              ),
              Divider(),
              SizedBox(
                height: mediaquery.width * 0.026,
              ),
              SizedBox(
                width: double.infinity - 20.0,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.all(14.0),
                    ),
                  ),
                  child: Text(
                    'Confirm Location',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
