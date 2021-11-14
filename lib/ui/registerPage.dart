import 'dart:io';

import 'package:chatchy/provider/authProvider.dart';
import 'package:chatchy/provider/preferencesProvider.dart';
import 'package:chatchy/provider/userProvider.dart';
import 'package:chatchy/ui/homePage.dart';
import 'package:chatchy/ui/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chatchy/ui/customTheme.dart';

import 'languages.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  String name, email, pass;
  bool isLoading = false;
  String errorMessage = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(body: Consumer2<UserProvider, PreferencesProvider>(
          builder: (_, userProvider, prefProvider, child) {
        return WillPopScope(
          onWillPop: (){
            userProvider.clearImageFile();
            Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) => LoginPage()));
            return Future.value(false);
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: CustomTheme.PrimaryColor,
                image: DecorationImage(
                  image: AssetImage("assets/images/background.jpg"),
                  fit: BoxFit.fill,
                  colorFilter: new ColorFilter.mode(
                      Colors.black.withOpacity(0.5), BlendMode.dstATop),
                )),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Directionality(
                  textDirection: prefProvider.selectedLanguage == Languages.Arabic
                      ? TextDirection.rtl
                      : TextDirection.ltr,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          userProvider.getImage();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.black),
                              color: Colors.grey[300]),
                          width: 110,
                          height: 110,
                          child: ClipOval(
                            child: userProvider.imageFile == null
                                ? Center(
                                    child: Icon(
                                      Icons.add_a_photo,
                                      size: 45,
                                      color: Colors.grey,
                                    ),
                                  )
                                : Image.file(
                                    userProvider.imageFile,
                                    fit: BoxFit.fill,
                                  ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                
                        child: TextFormField(
                          keyboardType: TextInputType.name,
                          style: TextStyle(color: Colors.white),
                          controller: _nameController,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return prefProvider.nameRequired;
                            }
        
                            return null;
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.white60,
                            ),
                            hintText: prefProvider.nameLabel,
                            hintStyle: TextStyle(
                                color: Colors.white54,
                                fontSize: prefProvider.subTitleFontSize),
                            labelStyle: TextStyle(
                                color: Colors.white,
                                fontSize: prefProvider.subTitleFontSize,
                                fontWeight: FontWeight.w600),
                            errorStyle: TextStyle(
                                color: Colors.red,
                                fontSize: prefProvider.subTitleFontSize),
                       
                            focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 1.5
                  ),
                ),

                     enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 1.0,
                  ),
                ),
                 contentPadding: EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                     
                    
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(color: Colors.white),
                          controller: _emailController,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return prefProvider.emailRequired;
                            }
                            Pattern pattern =
                                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                            RegExp regex = new RegExp(pattern);
                            if (!regex.hasMatch(value)) {
                              return prefProvider.errorValidEmail;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.alternate_email,
                              color: Colors.white60,
                            ),
                            hintText: prefProvider.email,
                            hintStyle: TextStyle(
                                color: Colors.white54,
                                fontSize: prefProvider.subTitleFontSize),
                            labelStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                            errorStyle: TextStyle(
                                color: Colors.red,
                                fontSize: prefProvider.subTitleFontSize),
                         
                           focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 1.5
                  ),
                ),

                     enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 1.0,
                  ),
                ),
                 contentPadding: EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                  
                        child: TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          style: TextStyle(color: Colors.white),
                          controller: _passwordController,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return prefProvider.passRequired;
                            }
                            if (value.length < 6) {
                              return prefProvider.errorSmallPass;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.white60,
                            ),
                            hintText: prefProvider.pass,
                            hintStyle: TextStyle(
                                color: Colors.white54,
                                fontSize: prefProvider.subTitleFontSize),
                            labelStyle: TextStyle(
                                color: Colors.white,
                                fontSize: prefProvider.titleFontSize,
                                fontWeight: FontWeight.w600),
                            errorStyle: TextStyle(
                                color: Colors.red,
                                fontSize: prefProvider.subTitleFontSize),
                         
                            focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 1.5
                  ),
                ),

                     enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 1.0,
                  ),
                ),
                 contentPadding: EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                     Text(
                            errorMessage,
                            style: TextStyle(
                                color: Colors.orange,
                                fontSize: prefProvider.subTitleFontSize,
                                fontWeight: FontWeight.w600),
                          ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState.validate() &&
                                userProvider.imageFile != null) {
                              registerUser(userProvider);
                            }
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white.withOpacity(0.5)),
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24))),
                              padding:
                                  MaterialStateProperty.all<EdgeInsetsGeometry>(
                                      EdgeInsets.symmetric(vertical: 8)),
                              elevation: MaterialStateProperty.all<double>(2)),
                          child:
                          isLoading? 
                         Container(
                          height: 28,
                          width: 28,
                          child: CircularProgressIndicator(backgroundColor: Colors.white, color: prefProvider.bottomBarSelectedIconColor, strokeWidth: 3.0,)):
                           Text(
                            prefProvider.signUp,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: prefProvider.titleFontSize,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            prefProvider.haveAccount,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: prefProvider.subTitleFontSize,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              userProvider.clearImageFile();
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) => LoginPage()));
                            },
                            child: Text(
                              prefProvider.login,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: prefProvider.subTitleFontSize,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      })),
    );
  }

  void registerUser(UserProvider userProvider) async{

     setState(() {
      isLoading = true;
      errorMessage = "";
    });

   String result =  await Provider.of<AuthProvider>(context, listen: false)
        .signUp(_emailController.text, _passwordController.text,
            _nameController.text);

    if(result == "success"){
     userProvider.uploadImage().whenComplete(() {
       userProvider.clearImageFile();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (ctx) => HomePage()));
      });
   }else{
     setState(() {
      isLoading = false;
      errorMessage = result;
    });
   }
  }
}
