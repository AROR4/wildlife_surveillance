import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wildlife_surveillance/ui/navbar/navbar.dart';
import 'package:wildlife_surveillance/ui/splash_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor:Color.fromARGB(188, 255, 136, 0)),
        useMaterial3: true,
      ),
      home: splashscreen(),
    );
  }
}