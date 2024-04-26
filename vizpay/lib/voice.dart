import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:permission_handler/permission_handler.dart';



class Voice extends StatefulWidget {
  @override
  _VoiceState createState() => _VoiceState();
}

class _VoiceState extends State<Voice> {
    stt.SpeechToText _speech = stt.SpeechToText();
  String _text = 'Speak Now';
    @override
  void initState() {
    super.initState();
    _listen();
    // _checkFirebase();
  }
  
  int _selectedIndex = -1;
  Future<List<List<dynamic>>>? _marksFuture;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      if (index == 0) {
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => Dashboard()));
      }
      if (index == 1) {}
      if (index == 2) {}
    });
  }


  @override
  Widget build(BuildContext context) {
    double hlen = MediaQuery.of(context).size.height;
    double wlen = MediaQuery.of(context).size.width;

    // Return your widget here using the data
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // this will hide the back button
        title: Center(
          child: Text('Voice'), // replace 'Marks' with your desired title
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
                  SizedBox(
                    height: 20,
                  ),
                 SizedBox(
  height: 500.0, // Specify your desired height
  child: Card(
        color: Color.fromARGB(255, 17, 5, 44).withOpacity(0.2), // make the Card semi-transparent
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
                    _text, // display the percentage
                    style: TextStyle(
                          fontFamily: 'Manrope',
                          color: Color.fromARGB(
                              255, 94, 183, 255), // make the text blue
                          fontSize: 24, // make the text a little big
                        ),

                  ),// add some spacing
                 
                ],
              ),
            ),
          ),
        ),
      ),
                 ),
                 SizedBox(
  height: 50.0, // Specify your desired height
                 ),
                   GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) => Voice()));
                        // Add your onTap functionality here
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: ClipOval(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 11000.0),
                            child: Container(
                              width: 100.0,
                              height: 100.0,
                              child: Container(
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.mic,
                                  size: 45,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                    
                ],
              ),
            ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
              // borderRadius: BorderRadius.only(
              //   topLeft: Radius.circular(30.0),
              //   topRight: Radius.circular(30.0),
              // ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 90, sigmaY: 130),
                child: BottomNavigationBar(
                  backgroundColor: Color.fromARGB(255, 31, 0, 102).withOpacity(
                      0), // make the BottomNavigationBar semi-transparent
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Container(
                        child: Icon(
                          Icons.home,
                          size: 30,
                        ), // replace with your custom icon
                      ),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: Container(
                        
                        child: Icon(
                          Icons.medical_information,
                          size: 30,
                        ), // replace with your custom icon
                      ),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: Container(
                        child: Icon(
                          Icons.person,
                          size: 30,
                        ), // replace with your custom icon
                      ),
                      label: '',
                    ),
                  ],
                  currentIndex: _selectedIndex < 0 ? 0 : _selectedIndex,
                  selectedItemColor: Colors.amber[800],
                  onTap: _onItemTapped,
                  showSelectedLabels:
                      false, // do not show labels for selected items
                  showUnselectedLabels:
                      false, // do not show labels for unselected items
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
    Future<void> _listen() async {
      var status = await Permission.microphone.status;
  if (!status.isGranted) {
    await Permission.microphone.request();
  }else{
    debugPrint('Permission Granted');
  }
    bool available = await _speech.initialize(
      onStatus: (val) => print('onStatus: $val'),
      onError: (val) => print('onError: $val'),
    );
    if (available) {
      _speech.listen(
        onResult: (val) => setState(() {
          _text = val.recognizedWords;
        }),
      );
    }
  }
}
