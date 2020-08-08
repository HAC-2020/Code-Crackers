import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifeline/menu.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffae6ef),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: () => Navigator.of(context).push(
              PageTransition(
                type: PageTransitionType.rippleRightDown,
                child: Menu(),
                duration: Duration(seconds: 1),
              ),
            ),
            icon: Icon(
              FontAwesomeIcons.ellipsisV,
              color: Colors.black54,
              size: 20.0,
            ),
          ),
        ],
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Our Heroes!",
          style: GoogleFonts.lobsterTwo(
            textStyle: TextStyle(
              color: Colors.black,
              fontSize: MediaQuery.of(context).size.width / 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: ScrollConfiguration(
              behavior: new ScrollBehavior()
                ..buildViewportChrome(context, null, AxisDirection.down),
              child: ListView(
                children: <Widget>[
                  Details(
                    blood: "O+",
                    name: "Abhishek Doshi",
                    city: "Valsad",
                    state: "Gujarat",
                    type: "Blood Donor",
                    number: "+917818044311",
                    point: "100",
                  ),
                  Details(
                    blood: "O+",
                    name: "Abhishek Doshi",
                    city: "Valsad",
                    state: "Gujarat",
                    type: "Blood Donor",
                    number: "+917818044311",
                    point: "100",
                  ),
                  Details(
                    blood: "O+",
                    name: "Abhishek Doshi",
                    city: "Valsad",
                    state: "Gujarat",
                    type: "Blood Donor",
                    number: "+917818044311",
                    point: "100",
                  ),
                  Details(
                    blood: "O+",
                    name: "Abhishek Doshi",
                    city: "Valsad",
                    state: "Gujarat",
                    type: "Blood Donor",
                    number: "+917818044311",
                    point: "100",
                  ),
                  Details(
                    blood: "O+",
                    name: "Abhishek Doshi",
                    city: "Valsad",
                    state: "Gujarat",
                    type: "Blood Donor",
                    number: "+917818044311",
                    point: "100",
                  ),
                  Details(
                    blood: "O+",
                    name: "Abhishek Doshi",
                    city: "Valsad",
                    state: "Gujarat",
                    type: "Blood Donor",
                    number: "+917818044311",
                    point: "100",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Details extends StatelessWidget {
  String blood, name, type, city, state, number, point, message, del;
  Details({
    this.name,
    this.blood,
    this.type,
    this.city,
    this.state,
    this.number,
    this.point,
  });
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          name,
                          style: TextStyle(fontSize: 22.0),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              city + ", " + state,
                              style: TextStyle(
                                color: Colors.black45,
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              type,
                              style: TextStyle(
                                color: Colors.black45,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 0.5,
                        ),
                        Row(
                          children: <Widget>[
                            IconButton(
                              icon: Icon(
                                FontAwesomeIcons.phoneAlt,
                                color: Colors.green,
                                size: 18.0,
                              ),
                              onPressed: () => launch("tel: $number"),
                            ),
                            IconButton(
                              icon: Icon(
                                FontAwesomeIcons.commentDots,
                                color: Colors.blue,
                                size: 18.0,
                              ),
                              onPressed: () => launch("sms: $number"),
                            ),
                            IconButton(
                              icon: Icon(
                                FontAwesomeIcons.whatsapp,
                                color: Colors.green,
                                size: 18.0,
                              ),
                              onPressed: () => launch(
                                  "whatsapp://send?phone=$number&text=$message"),
                            ),
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
