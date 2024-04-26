import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:vizpay/dashboard.dart';
//import 'package:vizpay/home.dart';



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


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
                            'VizPay',
                            style: TextStyle(
                              fontSize: 60,
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
                          child: Text(
                            'Bridging the gap,closer than ever',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Martel',
                              fontWeight: FontWeight.w100,
                              fontStyle: FontStyle.italic,
                              color: Colors.white,
                            ),
                          ),
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
