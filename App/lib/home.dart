import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifeline/menu.dart';
import 'package:url_launcher/url_launcher.dart';

import 'donorDetails.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        exit(1);
        return false;
      },
      child: Scaffold(
        backgroundColor: Color(0xfffae6ef),
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: Container(),
          actions: <Widget>[
            IconButton(
              onPressed: () => Navigator.of(context).push(
                PageTransition(
                  type: PageTransitionType.rippleRightDown,
                  child: Menu(),
                  duration: Duration(milliseconds: 500),
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
      ),
    );
  }
}
