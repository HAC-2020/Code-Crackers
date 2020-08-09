import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifeline/menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'donorDetails.dart';

class Home extends StatelessWidget {

  String password, fname, phone, dob, blood;
  bool bldon = false, platdon = false, plasdon = false;

  Home({
    this.bldon,
    this.blood,
    this.dob,
    this.fname,
    this.password,
    this.phone,
    this.plasdon,
    this.platdon,
  });

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
                child: StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance
                      .collection('Users')
                      // .where("Enrollment No", isEqualTo: enroll)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError)
                      return Text('Error: ${snapshot.error}');
                    if (!snapshot.hasData && snapshot.data.documents == null)
                      return Text('Please try again later...',
                          style: TextStyle(fontSize: 15));
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Text(
                          'Retrieving Donors...',
                          style: TextStyle(fontSize: 20),
                        );
                      default:
                        return ListView(
                          children: snapshot.data.documents
                              .map((DocumentSnapshot document) {
                            return Details(
                              email: document.documentID,
                              blood: document['Blood Group'],
                              name: document['Name'],
                              city: document['City'],
                              state: document['State'],
                              bldon: document['Blood Donor'],
                              platdon: document['Platelets Donor'],
                              plasdon: document['Plasma Donor'],
                              number: document['Phone Number'],
                              point: document['Points'],
                            );
                          }).toList(),
                        );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
