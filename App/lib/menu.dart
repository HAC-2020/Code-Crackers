import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifeline/home.dart';
import 'package:lifeline/profile.dart';
import 'package:lifeline/search.dart';

class Menu extends StatelessWidget {
  String fname, phone, dob, blood;
  bool bldon = false, platdon = false, plasdon = false;

  Menu({
    this.bldon,
    this.blood,
    this.dob,
    this.fname,
    this.phone,
    this.plasdon,
    this.platdon,
  });

  TextStyle textStyle = GoogleFonts.lobsterTwo(
    textStyle: TextStyle(
        fontSize: 40.0, color: Colors.white, fontWeight: FontWeight.bold),
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.red,
            Colors.redAccent,
            Colors.deepOrange,
            Colors.deepOrangeAccent,
            Colors.orange,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                ),
                child: Text(
                  "Home",
                  style: textStyle,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Profile(
                              fname: fname,
                              dob: dob,
                              bldon: bldon,
                              blood: blood,
                              phone: phone,
                              plasdon: plasdon,
                              platdon: platdon,
                            )),
                  );
                },
                child: Text(
                  "Profile",
                  style: textStyle,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Search()),
                  );
                },
                child: Text(
                  "Search Donor",
                  style: textStyle,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              GestureDetector(
                onTap: () => exit(1),
                child: Text(
                  "Log Out",
                  style: textStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
