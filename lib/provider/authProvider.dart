import 'package:chatchy/models/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

 
enum AuthState { unAuthenticated, authentecating, authenticated }

class AuthProvider extends ChangeNotifier{

  FirebaseAuth _auth = FirebaseAuth.instance;
  var usersDatabase=  FirebaseFirestore.instance.collection("users");
  

  AuthState _authState = AuthState.unAuthenticated;
  
  
  AuthState get authState => _authState;
  User get currentUser => _auth.currentUser;
 
  Future<String> signUp(String email, String password, String name) async{
     String result = "";
    try{

      _authState = AuthState.authentecating;
      notifyListeners();
       await _auth.createUserWithEmailAndPassword(email: email, password: password).then((data) async {
         
         
         UserModel user = UserModel(data.user.uid, email, name,"");
          await  usersDatabase.doc(data.user.uid).set(user.toMap()).whenComplete(() {
            
          _authState = AuthState.authenticated;
          notifyListeners();
          result = "success";
         
          });
});
    }on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        result = "Your email is invalid";
    
      }
      if (e.code == 'email-already-in-use') {
        result = "Email Already in Use";
      
      } else if (e.code == 'weak-password') {
        result = "Your password is weak";
      }
      else if (e.code == 'operation-not-allowed') {
        result = "Your operation not allowed";
      }
      _authState = AuthState.unAuthenticated;
      notifyListeners();
      
    }
    return result;
    
  }

    Future<String> signIn(String email, String password) async{
     String result = "";
    try{
       await _auth.signInWithEmailAndPassword(email: email, password: password).whenComplete((){
         
      });
     result = "success";
    }
    on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        result = "Your email is invalid";
        
      }
      if (e.code == 'user-not-found') {
        result = "User not found";
      
      } else if (e.code == 'wrong-password') {
        result = "Your password is not correct";
      }
      _authState = AuthState.unAuthenticated;
      notifyListeners();
      
    }
    return result;
   }

 Future<void> signOut() async{
 
  await _auth.signOut();
  _authState = AuthState.unAuthenticated;
  notifyListeners();
}

 bool getAuthState() {
    try {
      final user =  _auth.currentUser;
      if (user != null) {
        return true ;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
 }

 String getUserId() {
   try {
     final userId = _auth.currentUser.uid;
     
     return userId;
   } catch (e) {
   }
   return null;
 }

}