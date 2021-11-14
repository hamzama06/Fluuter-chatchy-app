import 'package:chatchy/provider/preferencesProvider.dart';
import 'package:chatchy/provider/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chatchy/ui/customTheme.dart';

import 'languages.dart';

class EditPasswordPage extends StatefulWidget {
  @override
  _EditPasswordPageState createState() => _EditPasswordPageState();
}

class _EditPasswordPageState extends State<EditPasswordPage> {

  var _formKey = GlobalKey<FormState>();
  TextEditingController _currentPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  bool isLoading = false;
 

  @override
    void initState() {
     super.initState();

     
    }

  @override
  Widget build(BuildContext context) {

       
       
    return SafeArea(
      child: Scaffold(
        backgroundColor: Provider.of<PreferencesProvider>(context).backgroundColor,
        appBar: AppBar(
         
          backgroundColor: Provider.of<PreferencesProvider>(context).primaryColor,
          centerTitle: true,
          title: Text(Provider.of<PreferencesProvider>(context).changePassword,
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold)),
        
        ),
        body: editPasswordWidget(),
      ),
    );
  }

  editPasswordWidget() {
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
                    borderRadius: BorderRadius.circular(16),
                    border:
                        Border.all(color: CustomTheme.PrimaryColor, width: 0.8)),
                child: TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  controller: _currentPasswordController,
                  validator: (text){
                    if(text.isEmpty) return theme.enterPass;
                    return null;
                  },
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12.0,
                  ),
                  
                  decoration: InputDecoration(
                    hintText: theme.currentPass,
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
                    borderRadius: BorderRadius.circular(16),
                    border:
                        Border.all(color: CustomTheme.PrimaryColor, width: 0.8)),
                child: TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  controller: _newPasswordController,
                  validator: (text){
                    if(text.isEmpty) return theme.errorEnterNewPass;
                    if(text.length < 6) return theme.errorSmallPass;
                    return null;
                  },
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12.0,
                  ),
                 
                  decoration: InputDecoration(
                    hintText: theme.newPassHint,
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
                    borderRadius: BorderRadius.circular(16),
                    border:
                        Border.all(color: CustomTheme.PrimaryColor, width: 0.8)),
                child: TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  controller: _confirmPasswordController,
                  validator: (text){
                    if(text.isEmpty) return theme.errorEnterNewPass;
                    if(text != _newPasswordController.text) return theme.passNotmatch;
                    return null;
                  },
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12.0,
                  ),
                  
                  decoration: InputDecoration(
                    hintText: theme.confirmPass,
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
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                      onPressed: (){
                        if(_formKey.currentState.validate()){
                         setState(() {
                                  isLoading = true;                
                                                }); 
                          Provider.of<UserProvider>(context, listen: false).changePassword(_currentPasswordController.text, _newPasswordController.text).whenComplete((){
                            Navigator.pop(context);

                          }).onError((error, stackTrace){
                            setState(() {
                                  isLoading = false;                
                                                }); 
                          });
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(CustomTheme.LightPrimaryColor),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)
                          )),
                          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(vertical:8 )),
                          elevation: MaterialStateProperty.all<double>(2)
                     
                      ),
                       child: Text(theme.save,
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
