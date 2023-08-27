import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wildlife_surveillance/ui/auth/login_screen.dart';

class settings extends StatefulWidget {
  const settings({super.key});

  @override
  State<settings> createState() => _settingsState();
}

class _settingsState extends State<settings> {
  final _auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.1),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text("Settings",style: TextStyle(color: Colors.black,fontSize: 40,fontWeight: FontWeight.w600,fontFamily: 'PT Sans'),),
            SizedBox(height: 15,),
            Container(decoration: BoxDecoration(color: Color.fromARGB(237, 255, 136, 0),borderRadius: BorderRadius.circular(12)),
                width: double.infinity,
                height: 150,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.people_outlined,size: 50,),),
                ),
            ),
            SizedBox(height: 15,),
            Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color: Colors.white),
            child: Column(children: [
              SizedBox(height: 5,),
              ListTile(
                leading: Icon(Icons.draw,size: 40,),
                title: Text("Appearance",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,fontFamily: 'PT Sans'),),
                trailing: Icon(Icons.arrow_right,size: 40,),
              ),
              SizedBox(height: 5,),
              Divider(),
              SizedBox(height: 5,),
              ListTile(
                leading: Icon(Icons.info,size: 40,),
                title: Text("About Us",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,fontFamily: 'PT Sans'),),
                trailing: Icon(Icons.arrow_right,size: 40,),
              ),
              SizedBox(height: 5,),
              Divider(),
              SizedBox(height: 5,),
              ListTile(
                leading: Icon(Icons.feedback,size: 40,),
                title: Text("Send Feedback",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,fontFamily: 'PT Sans'),),
                trailing: Icon(Icons.arrow_right,size: 40,),
              ),
              SizedBox(height: 5,),

            ]),
            ),
            SizedBox(height: 10,),
            Text("Accounts",style: TextStyle(color: Colors.black,fontSize: 40,fontWeight: FontWeight.w600,fontFamily: 'PT Sans'),),
            SizedBox(height: 15,),
            Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color: Colors.white),
            child: Column(children: [
              SizedBox(height: 5,),
              ListTile(
                onTap: (){
                  _auth.signOut().then((value){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>loginscreen()));
                  });
                },
                leading: Icon(Icons.logout,size: 40,),
                title: Text("Sign out",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,fontFamily: 'PT Sans'),),
                trailing: Icon(Icons.arrow_right,size: 40,),
              ),
              SizedBox(height: 5,),
              
              

            ]),
            ),
          ]),
        ),
      ),
    );
  }
}