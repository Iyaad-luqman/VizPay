import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:vizpay/dashboard.dart';
//import 'package:vizpay/home.dart';



class Confirmation extends StatefulWidget {
  @override
  _ConfirmationState createState() => _ConfirmationState();
}

class _ConfirmationState extends State<Confirmation> {


  @override
  Widget build(BuildContext context) {
    double hlen = MediaQuery.of(context).size.height;
    double wlen = MediaQuery.of(context).size.width;

    // Return your widget here using the data
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: hlen,
            width: wlen,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/Dashboard.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                         
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, hlen*0.25,0,0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard()));
                          },
                          child: Text(
                            'Payment Successfully Made',
                            style: TextStyle(
                              fontSize: 40,
                              fontFamily: 'Martel',
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        padding: EdgeInsets.fromLTRB(40, 0, 10, 0),
                        child: GestureDetector(
                          onTap: () {
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));

                          },
                        ),
                      ),
                      SizedBox(
                        height: hlen * 0.2,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  )

                  // Add a GridView.builder
                  
                ],
              ),
            ),
          ),
         ],
      ),
    );
  }
}
