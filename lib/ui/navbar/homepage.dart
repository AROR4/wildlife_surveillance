import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:wildlife_surveillance/ui/camera.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _auth=FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;

  
  String firstName='';
  String lastName='';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(188, 255, 136, 0),
    
      body: Column(
        
        children: [
          StreamBuilder(
            stream: _firestore.collection('users').doc(_auth!.uid).snapshots(),
            builder: (context,  snapshot){
              if(!snapshot.hasData){
                return Center(child: CircularProgressIndicator());
              }else{
              return HomeAppBar(userName: "${snapshot.data!.get('First Name')} ${snapshot.data!.get('Last Name')}", userId: snapshot.data!.get('id'));
              }
            }),
              
            Expanded(
              child: Container(
                        
                        decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 240, 240, 240),
                        borderRadius: BorderRadius.vertical(top: Radius.circular(50.0)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 30,),
                            Text("Recent Activity",style: TextStyle(fontFamily: 'PT Sans',fontSize:20 ,color: Colors.black,fontWeight: FontWeight.w700),),
                      20.heightBox,
                            Container(
                              width: double.infinity,
                              height: 150,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color: Colors.white),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 0),
                                child: Row(
                                    children: [
                                       CircleAvatar(
                                        radius: 50,
                                        backgroundImage: NetworkImage('https://images.unsplash.com/photo-1618588507085-c79565432917?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8YmVhdXRpZnVsJTIwbmF0dXJlfGVufDB8fDB8fHww&w=1000&q=80'),),
                                        
                                      
                                      SizedBox(width: 20),
                                      Padding(
                                        padding: EdgeInsets.all(16.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            "Activity Observed".text.bold.size(16).make(),
                                            10.heightBox,
                                          ],
                                        ).py4(),
                                      ),
                                    ],
                                  ),
                              ),
                            ),
                            40.heightBox,
                            Text("Cameras",style: TextStyle(fontFamily: 'PT Sans',fontSize:20 ,color: Colors.black,fontWeight: FontWeight.w700),),
                            20.heightBox,
                            Container(
                              width: 500,
                              height: 200,
                        
                              child: 
                              ListView.builder(
                              
                                scrollDirection: Axis.horizontal,
                      
                                itemCount: 2, // Number of containers
                                itemBuilder: (context, index) {
                                  
                                  return Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 0),
                                    child: Card(
                                      child: InkWell(
                                        onTap: (){
                                          Navigator.push(context,MaterialPageRoute(builder: (context)=> camerashutter()));
                                        },
                                        child: Container(
                                          width: 240,
                                          height: 100,
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color: Colors.white),
                                          child: index==0 ? CircleAvatar(child: Icon(Icons.camera_enhance,size: 50,),radius: 30,):
                                          CircleAvatar(child: Icon(Icons.add),),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
                ],
              ),
        );
  }
}

class HomeAppBar extends StatelessWidget {
  final String userName;
  final String userId;

  HomeAppBar({required this.userName, required this.userId});

  @override
  Widget build(BuildContext context) {
    String greeting = _getGreeting();
    return Container(
      height: 240,
      decoration: BoxDecoration(
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        

        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.heightBox,
              Text(
                greeting,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ).px4(),
              SizedBox(height: 0),
              Text(
                userName,
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(width: MediaQuery.of(context).size.width*0.15,),
          Column(
            children: [
              IconButton(
                icon: Icon(
                  Icons.person,
                  size: 50,
                  color: Colors.black,
                ),
                onPressed: () {
                  
                },
              ),
              
              Text(
                'ID: $userId',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ).py(70).px8(),
    );
  }

  String _getGreeting() {
    final now = DateTime.now();
    if (now.hour < 12) {
      return 'Good Morning';
    } else if (now.hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }
}