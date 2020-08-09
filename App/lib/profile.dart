import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifeline/update.dart';

class Profile extends StatelessWidget {
  String fname, phone, dob, blood;
  bool bldon = false, platdon = false, plasdon = false;

  Profile({
    this.bldon,
    this.blood,
    this.dob,
    this.fname,
    this.phone,
    this.plasdon,
    this.platdon,
  });

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
              MaterialPageRoute(builder: (context) => Update()),
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
                    ProfileData(
                      data: "Name: Abhishek Doshi",
                      icon: Icon(
                        FontAwesomeIcons.user,
                        color: Colors.blue,
                      ),
                    ),
                    ProfileData(
                      data: "Mobile: +917818044311",
                      icon: Icon(
                        FontAwesomeIcons.phone,
                        color: Colors.blue,
                      ),
                    ),
                    ProfileData(
                      data: "DOB: 26 / 1 / 1999",
                      icon: Icon(
                        FontAwesomeIcons.calendar,
                        color: Colors.green,
                      ),
                    ),
                    ProfileData(
                      data: "Blood Group: O+",
                      icon: Icon(
                        FontAwesomeIcons.tint,
                        color: Colors.red,
                      ),
                    ),
                    Container(
                      height: 100.0,
                      child: Card(
                        child: Center(
                          child: Row(
                            children: <Widget>[
                              SizedBox(width: 20.0),
                              Icon(FontAwesomeIcons.quoteRight),
                              SizedBox(width: 20.0),
                              Text(
                                'Donor Type: Blood Donor',
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                              ),
                              // Visibility(
                              //   visible: bldon,
                              //   child: Text(
                              //     'Blood Donor',
                              //     style: TextStyle(
                              //       fontSize: 20.0,
                              //     ),
                              //   ),
                              // ),
                              // Visibility(
                              //   visible: platdon,
                              //   child: Text(
                              //     'Platelets Donor',
                              //     style: TextStyle(
                              //       fontSize: 20.0,
                              //     ),
                              //   ),
                              // ),
                              // Visibility(
                              //   visible: plasdon,
                              //   child: Text(
                              //     'Plasma Donor',
                              //     style: TextStyle(
                              //       fontSize: 20.0,
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ),
                    )
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

class ProfileData extends StatelessWidget {
  String data;
  Icon icon;
  ProfileData({this.data, this.icon});

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
