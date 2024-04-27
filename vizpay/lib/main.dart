import 'package:flutter/material.dart';
import 'package:vizpay/HomePage.dart';
import 'package:local_auth/local_auth.dart';
void main() async {

// WidgetsFlutterBinding.ensureInitialized();

// await Firebase.initializeApp();

runApp(MyApp());

}
class MyApp extends StatelessWidget {
   MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VizPay',
      theme: ThemeData.dark(),
      home:  HomePage(),
    );
  }
}