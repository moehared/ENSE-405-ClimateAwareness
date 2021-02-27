import 'package:app/auth/auth_service.dart';
import 'package:app/route/router.dart' as route;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth/auth_wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

DatabaseReference userRef =
    FirebaseDatabase.instance.reference().child('users');

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (ctx) => ctx.read<AuthService>().authState,
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Color(0xFF512da8),
          accentColor: Color(0xffc2185b),
          primaryColorDark: Color(0xff140078),
          accentIconTheme: IconThemeData(color: Color(0xffc2185b)),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: AuthWrapper.routeName,
        onGenerateRoute: route.Router.generateRoute,
      ),
    );
  }
}
