import 'dart:async';

import 'package:chatchy/provider/authProvider.dart';
import 'package:chatchy/provider/preferencesProvider.dart';
import 'package:chatchy/ui/homePage.dart';
import 'package:chatchy/ui/loginPage.dart';
import 'package:chatchy/ui/widgets/logo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chatchy/ui/customTheme.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  AuthState userState ;
  
  @override
    void initState() {
     super.initState();
      
    Provider.of<PreferencesProvider>(context, listen: false).initPreferences();
    Future.delayed(Duration(seconds: 3), navigateTo);
    }

  navigateTo(){
 
   User user = Provider.of<AuthProvider>(context, listen: false).currentUser;
    if(user != null){
           Navigator.push(context, MaterialPageRoute(builder: (ctx)=> HomePage()));
    } else{
          Navigator.push(context, MaterialPageRoute(builder: (ctx)=> LoginPage()));
    }  
  }  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
                       color: CustomTheme.PrimaryColor,
                        image: DecorationImage(
                          image: AssetImage("assets/images/background.jpg"),
                          fit: BoxFit.fill,
                          colorFilter: new ColorFilter.mode(
                              Colors.black.withOpacity(0.5), BlendMode.dstATop),
                        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          
          children: [
           Logo(),
           SizedBox(height: 5,),  
            Text("We will never leave you alone", style: TextStyle(color: Colors.white60, fontSize: 14),),
            SizedBox(height: 14,),
            Text("Let's chat", style: TextStyle(color: Colors.white, fontSize: 30, fontFamily: "Niconne", fontWeight: FontWeight.w600),)
          ],
        )
        ),
    );
  }


}