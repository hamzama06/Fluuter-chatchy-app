import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190,
      width: 190,
   
      child: Stack(
        children: [
          Center(child:
          Image.asset("assets/images/logo.png", height: 170, width: 170, fit: BoxFit.fill,),
           ),
         Positioned(
           bottom: 0,
           left: 25,
           child: Text("Chatchy", style: TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold),)
         )
        ],
      ),
    );
  }
}