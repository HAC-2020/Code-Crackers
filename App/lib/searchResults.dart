import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'donorDetails.dart';

class SearchResults extends StatelessWidget {

  String city, state, blood;
  bool bldon = false, platdon= false, plasdon = false;

  SearchResults({
    this.blood,
    this.bldon,
    this.platdon,
    this.plasdon,
    this.city,
    this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffae6ef),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: Container(),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Found Donors",
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
                    .where("City", isEqualTo: city)
                    .where("State", isEqualTo: state)
                    .where('Blood Group', isEqualTo: blood)
                    .where('Blood Donor', isEqualTo: bldon)
                    .where('Platelets Donor', isEqualTo: platdon)
                    .where('Plasma Donor', isEqualTo: plasdon)
                    .orderBy('Registered On', descending: true)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError)
                    return Text('Error: ${snapshot.error}');
                  if (!snapshot.hasData && snapshot.data.documents == null)
                    return Text('No Donors Found!\n\nPlease try using different values...',
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
    );
  }
}
