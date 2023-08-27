

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wildlife_surveillance/ui/navbar/navbar.dart';
import 'dart:async';

import '../ui/auth/login_screen.dart';

class splashservices{
  void isLogin(BuildContext context){
    final auth=FirebaseAuth.instance;

    final user=auth.currentUser;
    if(user != null){

    
    Timer(Duration(seconds: 3),()=> Navigator.push(context,
     MaterialPageRoute(builder: ((context) => navbar() ))));}
     else{
      Timer(Duration(seconds: 3),()=> Navigator.push(context,
     MaterialPageRoute(builder: ((context) => loginscreen() ))));
     }
  }
  
}