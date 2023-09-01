
import 'package:flutter/material.dart';
import 'dart:math' as math;

class camerashutter extends StatefulWidget {
  const camerashutter({super.key});

  @override
  State<camerashutter> createState() => _camerashutterState();
}

class _camerashutterState extends State<camerashutter> {
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
              child: Placeholder(),),
              SizedBox(height: 40,),
              Container(
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                  
                  CircleAvatar(backgroundColor: Colors.grey, radius: 150,),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                   child: Column(
                     children: [
                      SizedBox(width: 150,),
                      IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_ios_new_rounded,color: Colors.white,size: 30,) ),
                      
                     ],
                   ),
                  ),
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                   child: Column(
                     children: [
                      IconButton(onPressed: (){}, icon: Transform.rotate(
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
                      IconButton(onPressed: (){}, icon: Transform.rotate(
                        angle: math.pi/2 ,
                        child: Icon(Icons.arrow_back_ios_new_rounded,color: Colors.white,size: 30,)
                      ),),
                      SizedBox(height: 210,),
                     ],
                   ),
                  ),
                  
                  CircleAvatar(backgroundColor: Colors.white,radius: 70,),
                  Icon(Icons.camera,size: 60,),
                  Align(
                    alignment: AlignmentDirectional.bottomCenter,
                   child: Column(
                     children: [
                      SizedBox(height: 210,),
                      IconButton(onPressed: (){}, icon: Transform.rotate(
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
}