import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:vizpay/dashboard.dart';
import 'package:local_auth/local_auth.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final LocalAuthentication auth = LocalAuthentication();

  @override
  void initState() {
    super.initState();
    _authenticateWithBiometrics();
  }

  Future<void> _authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticate(
        localizedReason: 'Scan your fingerprint to authenticate',
        options: const AuthenticationOptions(biometricOnly: true),
      );
    } catch (e) {
      print(e);
    }
    if (!authenticated) {
      // Authentication failed
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Authentication Failed'),
          content: Text('You could not be authenticated. Please try again.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    } else {
      // Navigate to Dashboard or perform other actions upon successful authentication
      Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard()));
    }
  }

  @override
  Widget build(BuildContext context) {
    double hlen = MediaQuery.of(context).size.height;
    double wlen = MediaQuery.of(context).size.width;

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
                  SizedBox(height: 20),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, hlen * 0.25, 0, 0),
                        child: GestureDetector(
                          onTap: () {
                            _authenticateWithBiometrics();
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
                      SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.fromLTRB(40, 0, 10, 0),
                        child: Text(
                          'Voice Assisted Payment System',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Martel',
                            fontWeight: FontWeight.w100,
                            fontStyle: FontStyle.italic,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: hlen * 0.2),
                      SizedBox(height: 20),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}