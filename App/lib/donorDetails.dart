import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Details extends StatelessWidget {
  String email, blood, name, city, state, number, message, del;
  int point;
  bool bldon = false, platdon = false, plasdon = false;
  Details({
    this.email,
    this.name,
    this.blood,
    this.bldon,
    this.platdon,
    this.plasdon,
    this.city,
    this.state,
    this.number,
    this.point,
  });

  _updatePoints() async {
    Map<String, dynamic> data = <String, dynamic>{
      "Points": point + 10,
    };
    await Firestore.instance
        .collection("Users")
        .document(email)
        .updateData(data)
        .whenComplete(() {
      print("Points Updated");
    }).catchError((e) => print(e));
  }

  @override
  Widget build(BuildContext context) {
    if (blood.endsWith("+"))
      del = "%2b";
    else
      del = "";
    message =
        "Hello $name, I need blood of $blood$del at $city, $state. I would be very much thankful to you if you can donate the same!";
    return Padding(
      padding: EdgeInsets.only(left: 2.0, right: 8.0),
      child: Stack(
        children: <Widget>[
          Container(
            height: 140.0,
          ),
          Positioned(
            top: 20.0,
            left: 20.0,
            child: Container(
              height: 120.0,
              width: MediaQuery.of(context).size.width - 35,
              child: Card(
                elevation: 10.0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 30.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 6.0,
                        ),
                        Text(
                          name,
                          style: TextStyle(fontSize: 22.0),
                        ),
                        Text(
                          city + ", " + state,
                          style: TextStyle(
                            color: Colors.black45,
                          ),
                        ),
                        Row(
                          children: [
                            Visibility(
                              visible: bldon,
                              child: Text(
                                "Blood ",
                                style: TextStyle(
                                  color: Colors.black45,
                                ),
                              ),
                            ),
                            Visibility(
                              visible: platdon,
                              child: Text(
                                "Platelets ",
                                style: TextStyle(
                                  color: Colors.black45,
                                ),
                              ),
                            ),
                            Visibility(
                              visible: plasdon,
                              child: Text(
                                "Plasma",
                                style: TextStyle(
                                  color: Colors.black45,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            IconButton(
                                icon: Icon(
                                  FontAwesomeIcons.phoneAlt,
                                  color: Colors.green,
                                ),
                                iconSize: 18.0,
                                onPressed: () {
                                  _updatePoints();
                                  launch("tel: $number");
                                }),
                            IconButton(
                                icon: Icon(
                                  FontAwesomeIcons.commentDots,
                                  color: Colors.blue,
                                ),
                                iconSize: 18.0,
                                onPressed: () {
                                  _updatePoints();
                                  launch("sms: $number");
                                }),
                            IconButton(
                                icon: Icon(
                                  FontAwesomeIcons.whatsapp,
                                  color: Colors.green,
                                ),
                                iconSize: 18.0,
                                onPressed: () {
                                  _updatePoints();
                                  launch(
                                      "whatsapp://send?phone=$number&text=$message");
                                }),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          "images/coin.png",
                          height: 30.0,
                        ),
                        Text(
                          "$point\nPoints",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 50.0,
            right: 270.0,
            child: Container(
              height: 80.0,
              width: 80.0,
              child: Card(
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                color: Colors.red.shade500,
                child: Center(
                  child: Text(
                    blood,
                    style: TextStyle(
                      fontSize: 30.0,
                      color: Colors.white60,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
