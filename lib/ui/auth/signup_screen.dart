

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:wildlife_surveillance/ui/auth/login_screen.dart';
import 'package:wildlife_surveillance/ui/navbar/navbar.dart';

import '../../utils/utils.dart';
import '../../widgets/roundbutton.dart';
import 'package:icons_plus/icons_plus.dart';
class sign_upscreen extends StatefulWidget {
  const sign_upscreen({super.key});

  @override
  State<sign_upscreen> createState() => _sign_upscreenState();
}

class _sign_upscreenState extends State<sign_upscreen> {

  bool loading=false;
  final _FormKey=GlobalKey<FormState>();
  final TextEditingController firstnamecontroller=TextEditingController();
  final TextEditingController lastnamecontroller=TextEditingController();
  final TextEditingController emailcontroller= TextEditingController();
  final TextEditingController passwordcontroller=TextEditingController();
  final _auth=FirebaseAuth.instance;
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;
  final databaseref= FirebaseDatabase.instance.ref('Users');
  
  void signup(){
    Random random = Random();

    setState(() {
      loading=true;
    });
    _auth.createUserWithEmailAndPassword(email: emailcontroller.text.toString(), password: passwordcontroller.text.toString()).then((value) async {
      setState(() {
        loading=false;
      });
      int randomnumber=random.nextInt(1000);
      await _firestore.collection('users').doc(_auth.currentUser!.uid).set(
      {
        'First Name' : firstnamecontroller.text.toString(),
        'Last Name' : lastnamecontroller.text.toString(),
        'photos': [],
        'id': randomnumber.toString()
      } 

      
      );
      Navigator.push(context,MaterialPageRoute(builder: (context)=> navbar()));
    }).onError((error, stackTrace){
      setState(() {
        loading=false;

      });
      Utils().toastmessage(error.toString());
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    
    return WillPopScope(
      onWillPop: ()async{
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        backgroundColor: Color.fromARGB(237, 255, 136, 0),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image(image: AssetImage('images/Group 1.png'),height: 120,width: 120,),
                  SizedBox(height: 10,),
                  Text("Register!!",style: TextStyle(fontSize: 45,color: Colors.white),),
                  SizedBox(height: 20,),
                Form(
                  key: _FormKey,
                  child: Container(
                    
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color: Colors.white) ,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  
                          child: Column(children: [
                            SizedBox(height: 30,),
                            TextFormField(
                              controller: firstnamecontroller,
                              validator: (value){
                                  if(value!.isEmpty){
                                    return "Enter First Name";
                                  }
                                  
                                  return null;
                                },
                              decoration: InputDecoration(hintText: "First Name",
                              prefixIcon: Icon(Icons.people),
                              fillColor: Colors.grey.withOpacity(0.1),
                              filled: true,
                               border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                               
                               ),
                              
                              ),
                              SizedBox(height: 25,),
                              TextFormField(
                              controller: lastnamecontroller,
                              validator: (value){
                                  if(value!.isEmpty){
                                    return "Enter Last Name";
                                  }
                                  
                                  return null;
                                },
                              decoration: InputDecoration(hintText: "Last Name",
                              prefixIcon: Icon(Icons.people_rounded),
                              fillColor: Colors.grey.withOpacity(0.1),
                              filled: true,
                               border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                               
                               ),
                              
                              ),
                              SizedBox(height: 25,),
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              validator: (value){
                                  if(value!.isEmpty){
                                    return "Enter E-mail";
                                  }
                                  if(!(value.contains("@") && (value.contains(".com") || value.contains(".in") || value.contains(".org")|| value.contains(".co.in")))){
                                    return "Enter Valid E-mail id";
                                  }
                                  return null;
                                },
                              controller: emailcontroller,
                              decoration: InputDecoration(hintText: "Email",
                              prefixIcon: Icon(Icons.email_outlined),
                              fillColor: Colors.grey.withOpacity(0.1),
                              filled: true,
                               border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                               
                               ),
                              
                              ),
                              SizedBox(height: 25,),
                              TextFormField(
                              controller: passwordcontroller,
                              obscureText: true,
                              validator: (value){
                                  if(value!.isEmpty){
                                    return "Enter Password";
                                  }
                                  
                                  return null;
                                },
                              decoration: InputDecoration(hintText: "Password",
                              prefixIcon: Icon(Icons.lock),
                              fillColor: Colors.grey.withOpacity(0.1),
                              filled: true,
                               border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                               
                               ),
                              
                              ),
                              SizedBox(height: 50,),
                              Roundbutton(Title: "Sign Up",
                              loading: loading,
                              onTap: (){
                                if(_FormKey.currentState!.validate()){
                                  signup();
                                }
                              },),
                              SizedBox(height: 20,),
                              Text("OR",style: TextStyle(fontSize: 18),),
                              SizedBox(height: 20,),
                              Container(
                                decoration: BoxDecoration(border: Border.all(),borderRadius: BorderRadius.circular(12),color: Colors.white),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                    Logo(Logos.google),
                                    SizedBox(width: 15,),
                                    Text("Sign in with Google",style: TextStyle(color: Colors.black,fontSize: 16),)
                                  ]),
                                ),
                                ),
                                SizedBox(height: 20,),
                                Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                Text("Already have an account? ",style: TextStyle(fontSize: 16),),
                                InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=> loginscreen()));
                                  },
                                  child: Text("Log in",style: TextStyle(color: Color.fromARGB(237, 255, 136, 0),decoration: TextDecoration.underline,fontSize: 16),))
                              ],),
                  
                  
                  
                              
                            
                          ]),
                        ),
                  ),
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}