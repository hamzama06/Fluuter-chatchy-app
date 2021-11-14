import 'dart:io';

import 'package:chatchy/models/messageModel.dart';
import 'package:chatchy/models/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class MessagesProvider extends ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  var usersDatabase = FirebaseFirestore.instance.collection("users");
  var messagesDatabase = FirebaseFirestore.instance.collection("messages");
  var messagesStorage = FirebaseStorage.instance.ref('images');
  List<MessageModel> messagesList = [];
  

  String errorMessage;
  File imageFile;


 User get currentUser => _auth.currentUser;

 Future sendNewMessage(
      {@required String message,
      @required String friendId,
      @required String friendName,
      @required String friendImage,
      @required String type
      }) async {
    try {
      await usersDatabase
          .doc(currentUser.uid)
          .get()
          .then((documentSnapshot) async {
        if (documentSnapshot.exists) {
        
          var currentUserData = UserModel.fromMap(documentSnapshot.data());

       int timestamp = Timestamp.now().millisecondsSinceEpoch;
      
       MessageModel newMessage = MessageModel(
              "id",
              message,
              currentUser.uid,
              currentUser.uid,
              friendId, 
              friendName,
              friendImage,
              timestamp,
              type,
              );

          await messagesDatabase
              .doc(currentUser.uid)
              .collection("friends id")
              .doc(friendId)
              .collection("messages id")
              .add(newMessage.toMap())
              .then((snapshot) {

            var messageId = snapshot.id;
            snapshot.update({'messageId': messageId});
            messagesDatabase
                .doc(currentUser.uid)
                .collection("friends id")
                .doc(friendId)
                .set({
              'lastMessageId': messageId,
              'content': message,
              'userId': currentUser.uid,
              'senderId': currentUser.uid,
              'friendId': friendId,
              'friendName': friendName,
              'friendImage': friendImage,
              'timestamp': timestamp,
              'type': type,
            });
          });


        MessageModel newMessage2 = MessageModel(
              "id",
              message,
              friendId,
              currentUser.uid,
              currentUserData.id, 
              currentUserData.name,
              currentUserData.imageUri,
              timestamp,
              type,
              );
          await messagesDatabase
              .doc(friendId)
              .collection("friends id")
              .doc(currentUser.uid)
              .collection("messages id")
              .add(newMessage2.toMap())
              .then((snapshot) {
            var messageId = snapshot.id;
            snapshot.update({'messageId': messageId});
            messagesDatabase
                .doc(friendId)
                .collection("friends id")
                .doc(currentUser.uid)
                .set({
              'lastMessageId': messageId,
              'content': message,
              'userId': friendId,
              'senderId': currentUser.uid,
              'friendId': currentUser.uid,
              'friendName': currentUserData.name,
              'friendImage': currentUserData.imageUri,
              'timestamp': timestamp,
              'type': type,
              
            });
          });
        }
      });
    } catch (e) {
      print(e.toString());
    }

  }

  Future<List<MessageModel>> allMessages() async {
    List<MessageModel> messages = [];

    try {
      await messagesDatabase
          .doc(currentUser.uid)
          .collection("friends id")
          .get()
          .then((snapshot) {
        snapshot.docs.forEach((element)  async {
          MessageModel message = MessageModel.fromMap(element.data());
            
            
            messages.add(message);
          notifyListeners();

   
        });
       });
    } catch (e) {}

    return messages;
      }


  Future<List<MessageModel>> allChatroomMessages(String friendId) async {
    List<MessageModel> messages = [];

  await messagesDatabase
        .doc(currentUser.uid)
        .collection("friends id")
        .doc(friendId)
        .collection("messages id")
        .orderBy('timestamp', descending: true)
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((element) {
        MessageModel message = MessageModel.fromMap(element.data());
        messages.add(message);
        notifyListeners();
      });
    });

    return messages;
  }



  String sendedMessageDate(int timestamp) {
    var dt = DateTime.fromMillisecondsSinceEpoch(timestamp);
    var dateFormat = DateFormat('dd/MM/yyyy, HH:mm').format(dt);
    List<String> time = dateFormat.split(",");
    var now = DateTime.now();
    var cuurentDateFormat = DateFormat('dd/MM/yyyy').format(now);

    if (time[0] == cuurentDateFormat) {
      return time[1].trim();
    }
    return time[0];
  }

  Future getImage(
    {
      @required String friendId,
      @required String friendName,
      @required String friendImage,
      }
  ) async {
    ImagePicker imagePicker = ImagePicker();

    XFile pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery, imageQuality: 25);
    if (pickedImage != null) {
   
      imageFile = File(pickedImage.path);
      notifyListeners();
      if (imageFile != null) {
      
        uploadFile(
          friendId: friendId,
          friendName: friendName,
          friendImage: friendImage
           );
      }
    }
  }

    Future uploadFile ({
       @required String friendId,
       @required String friendName,
       @required String friendImage,
      }) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
   

    try {
       Reference reference = messagesStorage.child(fileName);
       await reference.putFile(imageFile).then(( TaskSnapshot  snapshot) async{
     
     snapshot.ref.getDownloadURL().then((url){
             sendNewMessage(
          message:url,
          friendId: friendId,
          friendName: friendName,
          friendImage: friendImage,
          type: "image"
         ); 
     });
    
    
    });

    } on FirebaseException catch (e) {
   
    }
  }
}
