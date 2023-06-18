import 'package:flutter/material.dart';
import 'package:hitchhop/widgets/availableCarsScreen/rideDetailsSheet.dart';

class SelectCarTile extends StatelessWidget {
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
                    CarDescription(),
                  ],
                ),
                SizedBox(
                  height: 50.0,
                  child: Image.network(
                      'https://imageio.forbes.com/specials-images/imageserve/5d35eacaf1176b0008974b54/2020-Chevrolet-Corvette-Stingray/0x0.jpg?format=jpg&crop=4560,2565,x790,y784,safe&width=960'),
                )
              ],
            ),
            SizedBox(
              height: 12.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 140.0,
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
                      // showModalBottomSheet(
                      //   context: context,
                      //   isScrollControlled: true,
                      //   backgroundColor: Colors.transparent,
                      //   builder: (context) => RideDetailsSheet(),
                      // );
                    },
                    child: Text('Book later'),
                  ),
                ),
                SizedBox(
                  width: 140.0,
                  child: TextButton(
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Color(0xffF8F4EA)),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Color(0xff579BB1)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => Container(
                          height: MediaQuery.of(context).size.height * 0.75,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25.0),
                              topRight: Radius.circular(25.0),
                            ),
                          ),
                          child: const Center(
                            child: Text("Modal content goes here"),
                          ),
                        ),
                      );
                    },
                    child: Text('Ride Now'),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CarDescription extends StatelessWidget {
  const CarDescription({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Car's Name",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        Text(
          "Car specs | Seats Available | Etc",
          style: TextStyle(fontSize: 10.0),
        ),
        Text(
          "800m (5mins away)",
          style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
