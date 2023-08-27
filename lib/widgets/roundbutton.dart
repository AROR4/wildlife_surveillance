import 'package:flutter/material.dart';

class Roundbutton extends StatelessWidget {
  final String Title;
  final VoidCallback onTap;
  final bool loading;
  const Roundbutton({super.key,
  required this.Title,
   required this.onTap,this.loading=false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        child: Center(child: loading? CircularProgressIndicator(strokeWidth: 3,color: Colors.white,):
         Text(Title,style: TextStyle(color: Colors.white,fontSize: 20))),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color: Color.fromARGB(237, 255, 136, 0)),
      ),
    );
  }
}