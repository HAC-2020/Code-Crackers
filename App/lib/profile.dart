import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffae6ef),
      appBar: AppBar(
        leading: Container(),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Profile",
          style: GoogleFonts.lobsterTwo(
            textStyle: TextStyle(
              color: Colors.black,
              fontSize: MediaQuery.of(context).size.width / 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Profile()),
            ),
            icon: Icon(
              FontAwesomeIcons.pen,
              size: 20.0,
              color: Colors.black54,
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            "images/superhero.jpg",
            height: MediaQuery.of(context).size.height / 2.5,
          ),
          Expanded(
            child: ScrollConfiguration(
              behavior: new ScrollBehavior()
                ..buildViewportChrome(context, null, AxisDirection.down),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: <Widget>[
                    profileData(
                      data: "Name: Abhishek Doshi",
                      icon: Icon(
                        FontAwesomeIcons.user,
                        color: Colors.blue,
                      ),
                    ),
                    profileData(
                      data: "Mobile: +917818044311",
                      icon: Icon(
                        FontAwesomeIcons.phone,
                        color: Colors.blue,
                      ),
                    ),
                    profileData(
                      data: "DOB: 26/01/1999",
                      icon: Icon(
                        FontAwesomeIcons.calendar,
                        color: Colors.green,
                      ),
                    ),
                    profileData(
                      data: "Blood Group: O+",
                      icon: Icon(
                        FontAwesomeIcons.tint,
                        color: Colors.red,
                      ),
                    ),
                    profileData(
                      data: "Donor Type: Blood Donor",
                      icon: Icon(FontAwesomeIcons.quoteRight),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class profileData extends StatelessWidget {
  String data;
  Icon icon;
  profileData({this.data, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      child: Card(
        child: Center(
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 20.0,
              ),
              icon,
              SizedBox(
                width: 10.0,
              ),
              Text(
                data,
                style: TextStyle(fontSize: 20.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
