import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:vizpay/HomePage.dart';
import 'package:vizpay/Prompt.dart';
import 'package:vizpay/qr.dart';
import 'package:vizpay/voice.dart';



class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
    @override
  void initState() {
    super.initState();
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

  Widget cardWidget(String title, Widget routeBuilder) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => routeBuilder));
      },
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
                    '$title', // display the percentage
                    style: TextStyle(
                          fontFamily: 'Manrope',
                          color: Color.fromARGB(
                              255, 94, 183, 255), // make the text blue
                          fontSize: 27, // make the text a little big
                        ),

                  ),// add some spacing
                 
                ],
              ),
            ),
          ),
        ),
      ),
    );
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
          child: Text('Vizpay'), // replace 'Marks' with your desired title
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 0, 5),
                    child: Text(
                      'Hello User!',
                      style: TextStyle(
                          fontSize: 23,
                          fontFamily: 'Manrope',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                    
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Text(
                          'User',
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Manrope',
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // Add a GridView.builder
                  Container(
                    height: hlen * 0.6, // specify the height of the GridView
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,// number of items per row
                              childAspectRatio: 7/6, 
                      ),
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        // Define your data
                        List<String> titles = [
                          'Split',
                          'Pay',
                          'Track',
                          'History',

                        ];
                       

                        List<Widget> routes = [
                          PaymentConfirmationPage(),
                          Voice(),
                          HomePage(),
                          QRScanPage(),

                        ];

                        // Pass the data to the cardWidget function
                        return cardWidget(
                          titles[index],
                          routes[index],
                        );
                      },
                    ),
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
                          Icons.home_rounded,
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
}

