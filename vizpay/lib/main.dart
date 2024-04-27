import 'package:flutter/material.dart';
import 'package:vizpay/HomePage.dart';
import 'package:local_auth/local_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure widgets are initialized
  // await Firebase.initializeApp(); // Uncomment and use if Firebase is needed
  runApp(MyApp());
}

// Define 'auth' as an instance of LocalAuthentication
final LocalAuthentication auth = LocalAuthentication();

Future<bool> _authenticate() async {
  bool canCheckBiometrics = await auth.canCheckBiometrics;
  if (!canCheckBiometrics) {
    print("Biometrics not available or not enrolled.");
    return false;
  }

  try {
    return await auth.authenticate(
      localizedReason: 'Scan your fingerprint to authenticate',
      options: const AuthenticationOptions(biometricOnly: true),
    );
  } catch (e) {
    print(e);
    return false;
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _authenticate().then((isAuthenticated) {
      if (!isAuthenticated) {
        // Navigate to UnauthenticatedApp or show an error message
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VizPay',
      theme: ThemeData.dark(),
      home: HomePage(), // Make sure HomePage is ready to handle the case where authentication hasn't occurred yet
    );
  }
}