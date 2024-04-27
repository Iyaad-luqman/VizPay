import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:permission_handler/permission_handler.dart';
import 'package:vizpay/Prompt.dart';
import 'package:vizpay/qr.dart';

class Voice extends StatefulWidget {
  @override
  _VoiceState createState() => _VoiceState();
}

class _VoiceState extends State<Voice> {
  stt.SpeechToText _speech = stt.SpeechToText();
  String _text = 'Speak Now';
  int _selectedIndex = -1;

  @override
  void initState() {
    super.initState();
    _listen();
  }

  @override
  Widget build(BuildContext context) {
    double hlen = MediaQuery.of(context).size.height;
    double wlen = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text('Voice'),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 90, sigmaY: 130),
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 31, 0, 102).withOpacity(0),
              ),
            ),
          ),
        ),
      ),
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
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 20),
                SizedBox(
                  height: 500.0,
                  child: Card(
                    color: Color.fromARGB(255, 17, 5, 44).withOpacity(0.2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    elevation: 7,
                    margin: EdgeInsets.all(20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30.0),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 70, sigmaY: 10),
                        child: Container(
                          alignment: Alignment.center,
                          color: Color.fromARGB(5, 40, 43, 91).withOpacity(0.1),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                _text,
                                style: TextStyle(
                                  fontFamily: 'Manrope',
                                  color: Color.fromARGB(255, 94, 183, 255),
                                  fontSize: 24,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50.0),
                GestureDetector(
                    onTap: () {
                  _sendTextAndNavigate(_text);
                },
                  child: Container(
                    alignment: Alignment.center,
                    child: ClipOval(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 5.0),

                        child: Container(
                          width: 100.0,
                          height: 100.0,
                          child: Icon(
  Icons.mic,
  color: Color.fromARGB(255, 144, 202, 255), // Lighter shade
  size: 45,
),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

// Ensure _listen is a Future<void> function
Future<void> _listen() async {
  var status = await Permission.microphone.status;
  if (!status.isGranted) {
    await Permission.microphone.request();
  }
  bool available = await _speech.initialize(
    onStatus: (val) => print('onStatus: $val'),
    onError: (val) => print('onError: $val'),
  );
  if (available) {
    await _speech.listen(
      onResult: (val) => setState(() {
        _text = val.recognizedWords;
      }),
    );
    // Assuming _speech.listen is asynchronous and you wait for it to finish
    // You might need to adjust this based on how your speech to text package signals completion
  }
}
  Future<void> _sendTextAndNavigate(String text) async {
    final url = Uri.parse('http://192.168.89.198:5000/nlp_process/$text');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['action'] == 'to_pay') {
        debugPrint('Navigating to Pay');
        Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentConfirmationPage()));
      } else if (result['action'] == 'open_scanner') {
        debugPrint('Navigating to Scanner');
        Navigator.push(context, MaterialPageRoute(builder: (context) => QRScanPage()));
      } else if (result['action'] == 'open_keypad') {
        debugPrint('Navigating to Keypad');
        Navigator.push(context, MaterialPageRoute(builder: (context) => QRScanPage()));
        
      }
    } else {
      // Handle the error
      print('Failed to load data');
    }
  }
}

// Define Page1, Page2, Page3 classes here