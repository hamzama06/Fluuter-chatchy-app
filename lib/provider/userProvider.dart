
import 'dart:io';

import 'package:chatchy/models/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

 


class UserProvider extends ChangeNotifier{

  FirebaseAuth _auth = FirebaseAuth.instance;
  var usersDatabase=  FirebaseFirestore.instance.collection("users");
  String errorMessage;
  var profilesImagesStorage = FirebaseStorage.instance.ref('images/profiles');
  String name;
  String imageUri;
  File imageFile;
  
User get currentUser => _auth.currentUser;

Future<UserModel> getUserData() async{

UserModel userData;
try {
 await  usersDatabase.doc(currentUser.uid).get().then((documentSnapshot){
             if(documentSnapshot.exists){
               userData = UserModel.fromMap(documentSnapshot.data());
             name = userData.name;
               imageUri = userData.imageUri;
              }
             
  });
} catch (e) {
  
}
 return userData;
}

Future<UserModel> getUserDataById(String uid) async{

UserModel userData;
try {
 await  usersDatabase.doc(uid).get().then((documentSnapshot){
             if(documentSnapshot.exists){
               print("${documentSnapshot.data()}");
              userData = UserModel.fromMap(documentSnapshot.data());
               print(" name: ${userData.name}");
             
              }
             
  });
} catch (e) {
  
}
 return userData;
}



Future<List<UserModel>> getAllUsers() async{
    
    List<UserModel> users = [];
    try {
     await usersDatabase.where('id', isNotEqualTo: currentUser.uid).get().then((QuerySnapshot snapshot){
         snapshot.docs.forEach((userData) { 
          var user = UserModel.fromMap(userData.data());
          users.add(user);
         });
     });
} catch (e) {
  print(e.toString());
}
return users;
}

  Future updateName(String newName) async{
  var userId = _auth.currentUser.uid;
  name = newName;
  await usersDatabase.doc(userId).update({
    'name': newName
  });
  
  notifyListeners();
}

  Future getImage() async {
    ImagePicker imagePicker = ImagePicker();
    
    XFile pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery, imageQuality: 25);
    if (pickedImage != null) {
      
      imageFile = File(pickedImage.path);
      
      notifyListeners();
     
    }
  }



Future uploadImage() async{
 
 String fileName = DateTime.now().millisecondsSinceEpoch.toString();
   
    try {
       Reference reference = profilesImagesStorage.child(fileName);
       await reference.putFile(imageFile).then(( TaskSnapshot  snapshot) async{
     
     snapshot.ref.getDownloadURL().then((url){
        
  imageUri = url; 
   usersDatabase.doc(currentUser.uid).update({
     "imageUri": url
   });

  notifyListeners();
     });
    
    
    });
 } on FirebaseException catch (e) {
   print(e.message);
   }
  }

Future<void> changeEmail(String newEmail, String password) async{
     
     User user = _auth.currentUser;
 try {
   AuthCredential credential =  EmailAuthProvider.credential(email: user.email, password: password);
  
  await FirebaseAuth.instance.currentUser.reauthenticateWithCredential(credential).then((userCredential){
     
     user.updateEmail(newEmail).then((value){
        usersDatabase.doc(currentUser.uid).update({
    'email': newEmail
  });
     });
      
  });
 } catch (e) {
   print(e.toString());
 }
 
 
}

Future<void> changePassword(String currentPassword, String newPassword) async{
  
       User user = _auth.currentUser;
 try {
   AuthCredential credential =  EmailAuthProvider.credential(email: user.email, password: currentPassword);
  
  await FirebaseAuth.instance.currentUser.reauthenticateWithCredential(credential).then((userCredential){
     
        currentUser.updatePassword(newPassword);
      
  });
 } catch (e) {
   print(e.toString());
 }
 }

  void clearImageFile(){
    imageFile = null;
    notifyListeners();
  }

 }