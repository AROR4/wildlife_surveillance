import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wildlife_surveillance/firebase_services/splash_services.dart';

class splashscreen extends StatefulWidget {
  const splashscreen({super.key});

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
List<String> images = [
  "https://images.pexels.com/photos/1435517/pexels-photo-1435517.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
 "https://images.pexels.com/photos/17932025/pexels-photo-17932025/free-photo-of-black-and-white-photograph-of-a-sheep-in-pasture.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
  "https://images.pexels.com/photos/3777622/pexels-photo-3777622.jpeg?auto=compress&cs=tinysrgb&w=1600",
];
@override
  void initState() {
    splashservices splashservice=splashservices();
    // TODO: implement initState
    super.initState();

    splashservice.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    Random random = Random.secure();
  String imageurl = images[random.nextInt(images.length)];
    return Scaffold(
        body: Center(
          child: FutureBuilder(
            future: Future.delayed(Duration(seconds: 0)),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return Image(image: NetworkImage(imageurl),height: double.infinity,
              fit: BoxFit.fitHeight,);
            },
          ),
        ),
      );
  }
}