import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifeline/home.dart';
import 'package:lifeline/profile.dart';

class Menu extends StatelessWidget {
  TextStyle textStyle = GoogleFonts.lobsterTwo(
    textStyle: TextStyle(
        fontSize: 40.0, color: Colors.white, fontWeight: FontWeight.bold),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
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
                  MaterialPageRoute(builder: (context) => Profile()),
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
                  MaterialPageRoute(builder: (context) => Home()),
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
    );
  }
}
