import 'package:chatchy/provider/preferencesProvider.dart';
import 'package:chatchy/provider/userProvider.dart';
import 'package:chatchy/ui/customTheme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'languages.dart';

class EditEmailPage extends StatefulWidget {
  final email;
  EditEmailPage(this.email);
  @override
  _EditEmailPageState createState() => _EditEmailPageState();
}

class _EditEmailPageState extends State<EditEmailPage> {

  var _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;


  @override
  void initState() {

    super.initState();
   _emailController.text = widget.email;
  }

  @override
  Widget build(BuildContext context) {
    PreferencesProvider theme = Provider.of<PreferencesProvider>(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.backgroundColor,
        appBar: AppBar(
            backgroundColor: theme.primaryColor,
            centerTitle: true,
            title: Text(theme.changeEmail,
                textDirection: TextDirection.rtl,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            
          ),
          body: editEmailWidget()),
    );
  }

  editEmailWidget() {
    PreferencesProvider theme = Provider.of<PreferencesProvider>(context);
    return Padding(
      padding: EdgeInsets.all(10),
      child: Form(
        key: _formKey,
        child: Directionality(
          textDirection: theme.selectedLanguage == Languages.Arabic? TextDirection.rtl: TextDirection.ltr,
          child: Column(
           
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.only(right: 10, left: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border:
                        Border.all(color: CustomTheme.PrimaryColor, width: 0.8)),
                child: TextFormField(
                  controller: _passwordController,
                 keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12.0,
                  ),
                validator: (text){
                     if(text.isEmpty) return theme.enterPass;
                     
                     return null;
                   },
                  decoration: InputDecoration(
                    hintText: theme.enterPass,
                    hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 12.0,
                        ),
                    border: InputBorder.none,
                    labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                        ),
                  ),
                ),
              ),

               SizedBox(
                height: 10,
              ),

              Container(
                padding: EdgeInsets.only(right: 10, left: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border:
                        Border.all(color: CustomTheme.PrimaryColor, width: 0.8)),
                child: TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12.0,
                  ),
                 
                 validator: (text){
                     if(text.isEmpty) return theme.enterEmail;
                     return null;
                   },
                  decoration: InputDecoration(
                    hintText: theme.email,
                    hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 12.0,
                        ),
                    border: InputBorder.none,
                    labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                        ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                      onPressed: (){
                       
                          setState(() {
                                                  isLoading = true;
                                                });
                          Provider.of<UserProvider>(context, listen: false).changeEmail(_emailController.text, _passwordController.text).whenComplete((){
                            setState(() {
                                                      isLoading = false;
                                                      Navigator.pop(context);
                                                    });
                          }).onError((error, stackTrace){
                             setState(() {
                                                      isLoading = false;
                                                    });
                          });
                        
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(CustomTheme.LightPrimaryColor),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)
                          )),
                          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(vertical:8 )),
                          elevation: MaterialStateProperty.all<double>(2)
                     
                      ),
                       child: 
                       isLoading? CircularProgressIndicator():
                       Text(theme.save,
                         style: TextStyle(color: Colors.white,
                          fontSize: 16,
                           fontWeight: FontWeight.bold),),),
              ),
            ],
          ),
        ),
      ),
    );
  }


}
