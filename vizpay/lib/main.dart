import 'package:flutter/material.dart';
import 'package:vizpay/HomePage.dart';
import 'package:local_auth/local_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure widgets are initialized
  // await Firebase.initializeApp(); // Uncomment and use if Firebase is needed

  final isAuthenticated = await _authenticate(); // Ensure authentication before running the app
  if (isAuthenticated) {
    runApp(MyApp());
  } else {
    // Handle the case when the user is not authenticated, e.g., exit the app or show an error message
    runApp(UnauthenticatedApp()); // You need to define UnauthenticatedApp or handle this scenario appropriately
  }
}

final LocalAuthentication auth = LocalAuthentication();

Future<bool> _checkBiometrics() async {
  bool canCheckBiometrics = await auth.canCheckBiometrics;
  return canCheckBiometrics;
}

Future<bool> _authenticate() async {
  bool authenticated = false;
  try {
    authenticated = await auth.authenticate(
      localizedReason: 'Scan your fingerprint to authenticate',
      options: const AuthenticationOptions(
        biometricOnly: true,
      ),
    );
  } catch (e) {
    print(e);
  }
  return authenticated; // Return the authentication status
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VizPay',
      theme: ThemeData.dark(),
      home: HomePage(),
    );
  }
}

// Define UnauthenticatedApp or handle unauthenticated scenario appropriately
class UnauthenticatedApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Authentication Required'),
        ),
      ),
    );
  }
}