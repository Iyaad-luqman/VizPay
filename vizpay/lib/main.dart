import 'package:flutter/material.dart';
import 'package:vizpay/HomePage.dart';
import 'package:local_auth/local_auth.dart';
void main() async {

// WidgetsFlutterBinding.ensureInitialized();

// await Firebase.initializeApp();

runApp(MyApp());
_authenticate();

}
final LocalAuthentication auth = LocalAuthentication();
Future<bool> _checkBiometrics() async {
  bool canCheckBiometrics = await auth.canCheckBiometrics;
  return canCheckBiometrics;
}
Future<void> _authenticate() async {
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
  if (!authenticated) {
    // Handle the case when the user is not authenticated
  }
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