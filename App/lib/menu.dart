import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  TextStyle textStyle = TextStyle(
      fontSize: 30.0, color: Colors.white, fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Home",
              style: textStyle,
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              "Profile",
              style: textStyle,
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              "Search Donor",
              style: textStyle,
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              "Contact Us",
              style: textStyle,
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              "Log Out",
              style: textStyle,
            ),
          ],
        ),
      ),
    );
  }
}
