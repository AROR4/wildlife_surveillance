
import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:random_string/random_string.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:math' as math;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/utils.dart';

class camerashutter extends StatefulWidget {
  const camerashutter({super.key});

  @override
  State<camerashutter> createState() => _camerashutterState();
}

class _camerashutterState extends State<camerashutter> {
  bool loading=false;
 File? _image;
String? userId='';
final _auth=FirebaseAuth.instance.currentUser;
final FirebaseDatabase _firebaseDatabase=FirebaseDatabase.instance;
final FirebaseFirestore _firestore=FirebaseFirestore.instance;
fetchUser() {
  userId = _auth?.uid;
  
  }
final firestore=FirebaseFirestore.instance.collection('users');   











Future<void> captureAndSaveImage(ImageSource image) async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: image);

  if (pickedFile != null) {
    setState(() {
      setState(() {
        loading=true;
      });
      _image = File(pickedFile.path);
    });
     String randomString = randomAlphaNumeric(4);
    final firebase_storage.Reference ref =
        firebase_storage.FirebaseStorage.instance.ref().child('images').child(_auth!.uid).child(randomString);
    final firebase_storage.UploadTask uploadTask = ref.putFile(_image!);
    

    try {
      await uploadTask;

      Utils().toastmessage("Upload Complete");
      setState(() {
        loading=false;
      });
      var newurl = await ref.getDownloadURL();
      await _firestore.collection('users').doc(_auth!.uid).update({
        'photos' : FieldValue.arrayUnion([newurl])
      });
    } catch (error) {
      Utils().toastmessage("Something Went Wrong: $error");
    }
  } else {
    
    Utils().toastmessage("No image selected");
  }
}









void getsource(){
    showCupertinoDialog(context: context, 
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Image Source'),
          content: Text('Select from where you want to upload picture..'),
          actions: [
            TextButton(
              onPressed: () {
                captureAndSaveImage(ImageSource.camera);
                 Navigator.of(context).pop();  
              },
              child: Text('Camera'),
            ),
            TextButton(
              onPressed: () {
                captureAndSaveImage(ImageSource.gallery);
                Navigator.of(context).pop();
              },
              child: Text('Gallery'),
            ),
          ],
      );
    });
    
  }

final dbr=FirebaseDatabase.instance.reference();

  

@override
  void initState() {
    // TODO: implement initState
    fetchUser();
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(bottomOpacity: 100,),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(children: [
              Text("LIVE",style: TextStyle(fontSize: 23,fontFamily: 'PT Sans',color: Color.fromARGB(255, 248, 28, 28)),textAlign: TextAlign.center ,),
              SizedBox(height: 15,),
              Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color: Colors.white12),height: 300,
             child: ElevatedButton(
            child: Text('See Live Cam'),
            onPressed: () async {
              launchUrl(Uri.parse("http://192.168.33.38:8080/browserfs.html"));
            })
// child: WebView(
//               initialUrl: "http://192.168.208.177/", // Use your live stream URL here
//               javascriptMode: JavascriptMode.unrestricted, // Allow JavaScript
//               initialMediaPlaybackPolicy: AutoMediaPlaybackPolicy.always_allow,
// )
),
              SizedBox(height: 40,),
              Container(
                child:  loading? CircularProgressIndicator() :  Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                  
                  CircleAvatar(backgroundColor: Colors.grey, radius: 150,),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                   child: Column(
                     children: [
                      SizedBox(width: 150,),
                      IconButton(onPressed: (){
                        _controlServos('servo_forward1');
                      //  _controlServos('servo_backward1');

                      }, icon: Icon(Icons.arrow_back_ios_new_rounded,color: Colors.white,size: 30,) ),
                      
                     ],
                   ),
                  ),
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                   child: Column(
                     children: [
                      IconButton(onPressed: (){
                        _controlServos('servo_forward2');
                      }, icon: Transform.rotate(
                        angle: -math.pi ,
                        child: Icon(Icons.arrow_back_ios_new_rounded,color: Colors.white,size: 30,)
                      ),),
                      SizedBox(width: 150,),
                     ],
                   ),
                  ),
                  Align(
                    alignment: AlignmentDirectional.topCenter,
                   child: Column(
                     children: [
                      IconButton(onPressed: (){

                       _controlServos('servo_backward1');
                      }, icon: Transform.rotate(
                        angle: math.pi/2 ,
                        child: Icon(Icons.arrow_back_ios_new_rounded,color: Colors.white,size: 30,)
                      ),),
                      SizedBox(height: 210,),
                     ],
                   ),
                  ),
                  
                  CircleAvatar(backgroundColor: Colors.white,radius: 70,),
                  IconButton(
                    onPressed: ()async{
                      _controlServos('click_photo');
                      // getsource();
                    },
                    icon: Icon(Icons.camera,size: 60),
                    ),
                  Align(
                    alignment: AlignmentDirectional.bottomCenter,
                   child: Column(
                     children: [
                      SizedBox(height: 210,),
                      IconButton(onPressed: (){
                        _controlServos('servo_backward2');
                      }, icon: Transform.rotate(
                        angle: -math.pi/2 ,
                        child: Icon(Icons.arrow_back_ios_new_rounded,color: Colors.white,size: 30,)
                      ),),
                     ],
                   ),
                  ),
                ],),
              )
              
            ]),
          ),
        ),
      ),
    );


    
  }
  Future<void> _controlServos(String command) async {
  final Uri uri = Uri.http('192.168.1.1:80', '/' + command); // Change the IP address and path as needed
  try {
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      print('Command sent successfully');
    } else {
      print('Failed to send command');
    }
  } catch (e) {
    print('Error: $e');
  }
}

}



