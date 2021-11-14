import 'package:chatchy/provider/authProvider.dart';
import 'package:chatchy/provider/preferencesProvider.dart';
import 'package:chatchy/ui/homePage.dart';
import 'package:chatchy/ui/registerPage.dart';
import 'package:chatchy/ui/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chatchy/ui/customTheme.dart';
import 'languages.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;
  String errorMessage = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
            child: Consumer<PreferencesProvider>(
              builder: (ctx, prefProvider, child){
                String selectedLanguage = prefProvider.selectedLanguage;
                  return Directionality(
                    textDirection: selectedLanguage == Languages.Arabic? TextDirection.rtl : TextDirection.ltr,
                    child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                
                children: [
                    Logo(),
                    SizedBox(
                      height: 25,
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
                            return 'enter a valid email';
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
                            fontSize: prefProvider.subTitleFontSize
                          ),
                          labelStyle: TextStyle(
                              color: Colors.white,
                              fontSize: prefProvider.subTitleFontSize,
                              fontWeight: FontWeight.w600),
                          errorStyle: TextStyle(color: Colors.red, fontSize: 14),
                         contentPadding: EdgeInsets.symmetric(vertical: 12),

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
                            fontSize: prefProvider.subTitleFontSize
                            ),
                          labelStyle: TextStyle(
                              color: Colors.white,
                              fontSize: prefProvider.subTitleFontSize,
                              fontWeight: FontWeight.w600),
                        
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
                            fontWeight: FontWeight.w600
                          ),
                        ),  

                        SizedBox(
                      height: 10,
                    ),

                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          
                          if(_formKey.currentState.validate()){
                        login();
    }

                        
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.white.withOpacity(0.5)),
                            shape: MaterialStateProperty.all<OutlinedBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24))),
                            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                                EdgeInsets.symmetric(vertical: 8)),
                            elevation: MaterialStateProperty.all<double>(2)),
                        child: 
                        isLoading ?
                        Container(
                          height: 28,
                          width: 28,
                          child: CircularProgressIndicator(backgroundColor: Colors.white, color: prefProvider.bottomBarSelectedIconColor, strokeWidth: 3.0,)):
                        Text(
                          prefProvider.login,
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
                          prefProvider.notHaveAccount,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: prefProvider.subTitleFontSize,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (ctx) => RegisterPage()));
                          },
                          child: Text(
                            prefProvider.signUp,
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
                  );
              },
              
            ),
          ),
        ),
      ),
    );
  }

  void login() async{

    setState(() {
      isLoading = true;
      errorMessage = "";
    });
   String result = await Provider.of<AuthProvider>(context, listen: false).signIn(_emailController.text, _passwordController.text);

   if(result == "success"){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>HomePage()));
   }else{
     setState(() {
      isLoading = false;
      errorMessage = result;
    });
   }
   }
}
