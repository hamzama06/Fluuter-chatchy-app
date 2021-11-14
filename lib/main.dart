import 'package:chatchy/provider/authProvider.dart';
import 'package:chatchy/provider/messagesProvider.dart';
import 'package:chatchy/provider/preferencesProvider.dart';
import 'package:chatchy/provider/userProvider.dart';
import 'package:chatchy/ui/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
          ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
          ChangeNotifierProvider<MessagesProvider>(
              create: (_) => MessagesProvider()),
          ChangeNotifierProvider<PreferencesProvider>(create: (_) => PreferencesProvider())
        ],
        child: MaterialApp(
            title: 'Chatchy',
            
            debugShowCheckedModeBanner: false,
            theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Cairo'),
            home: SplashScreen()));
  }
}
