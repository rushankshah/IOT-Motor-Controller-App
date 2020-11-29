import 'package:control_pad/control_pad.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final dbRef = FirebaseDatabase.instance.reference();
  int out = 0;
  final String child = 'Direction';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'IOT Motor Controller',
          style: GoogleFonts.montserrat(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: JoystickView(
          // interval: Duration(seconds: 1),
          size: 300,
          onDirectionChanged: (double degrees, double distance) {
            print('Degrees ' +
                degrees.toStringAsFixed(2) +
                'Distance ' +
                distance.toStringAsFixed(2));
            if (distance > 0.5) {
              if(degrees.ceil()>40 && degrees.ceil()<=140){
                dbRef.child(child).set(2);
              } else if (degrees.ceil() > 140 && degrees.ceil() <= 230){
                dbRef.child(child).set(3);
              } else if (degrees.ceil() > 230 && degrees.ceil() <=310){
                dbRef.child(child).set(4);
              } else{
                dbRef.child(child).set(1);
              }
            } else {
                dbRef.child(child).set(0);
            }
          },
        ),
      ),
    );
  }
}
