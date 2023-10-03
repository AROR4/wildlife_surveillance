import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';import 'package:flutter/material.dart';

import 'package:velocity_x/velocity_x.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({Key? key}) : super(key: key);

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  String? userId='';
   
  final _auth=FirebaseAuth.instance.currentUser;
  late Stream<DocumentSnapshot<Map<String, dynamic>>> DocRef;

  late DatabaseReference databaseref;
  late DatabaseReference dataref;
  fetchUser() {
  userId = _auth?.uid;
  DocRef=FirebaseFirestore.instance.collection('users').doc(userId.toString()).snapshots();
  }
  
  




  @override
  void initState() {
    // TODO: implement initState
    fetchUser();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
  appBar: AppBar(
    title: Center(
      child: Text(
        "Gallery",
        style: TextStyle(
          fontFamily: "PT Sans",
          fontWeight: FontWeight.w500,
          fontSize: 30,
        ),
      ),
    ),
    backgroundColor: Color.fromARGB(188, 255, 136, 0),
    automaticallyImplyLeading: false,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(30),
      ),
    ),
  ),
  backgroundColor: Color.fromARGB(255, 240, 240, 240),
  body: StreamBuilder<DocumentSnapshot>(
    stream: DocRef,
    builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      } else if (!snapshot.hasData || !snapshot.data!.exists) {
        // Handle the case where the document doesn't exist or is empty
        return Center(child: Text("Gallery is empty", style: TextStyle(fontSize: 25)));
      } else {
        final photos = snapshot.data!.get('photos') as List<dynamic>;
        List<String> urls=[];
         for (var item in photos) {
                              urls.add(item);
                            }
        
        return Center(
          child: urls.isNotEmpty
              ? GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 25.0,
                    crossAxisSpacing: 10.0,
                  ),
                  itemCount: urls.length,
                  itemBuilder: (context, index) {
                    String fieldValue = urls[index];
                    return GestureDetector(
                      onLongPress: () {
                        // Handle long press actions if needed
                      },
                      child: Padding(
                        padding: index % 2 == 0 ? const EdgeInsets.only(left: 20, right: 12) : const EdgeInsets.only(right: 20, left: 12),
                        child: Container(
                          child: Image.network(
                            fieldValue,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes != null
                                        ? loadingProgress.cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    );
                  },
                )
              : Center(child: Text("Gallery is empty", style: TextStyle(fontSize: 25))),
        ).py64();
      }
    },
  ),
);
  } 
}