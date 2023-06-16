import 'package:flutter/material.dart';
import 'package:hitchhop/constants.dart';

class SelectRideSheet extends StatelessWidget {
  const SelectRideSheet({Key? key}) : super(key: key);

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
      height: mediaquery.width * 0.96,
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
              Row(
                children: [
                  Text(
                    'Recent places',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.0,
                    ),
                  ),
                  Spacer(),
                ],
              ),
              // Todo: Listview
              GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: mediaquery.width * 0.04,
                  ),
                  itemCount: 10,
                  itemBuilder: (BuildContext ctx, index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(
                        12.0,
                        12.0,
                        12.0,
                        0,
                      ),
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(
                                30.0,
                              ),
                              child: Image.network(
                                loginImage,
                              ),
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            Text(
                              //myTiles[index]["name"],
                              'John Doe',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 14.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
