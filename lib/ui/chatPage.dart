import 'dart:io';

import 'package:chatchy/models/messageModel.dart';
import 'package:chatchy/provider/messagesProvider.dart';
import 'package:chatchy/provider/preferencesProvider.dart';
import 'package:chatchy/ui/languages.dart';
import 'package:chatchy/ui/widgets/fullImageScreen.dart';
import 'package:flutter/material.dart';
import 'package:chatchy/ui/customTheme.dart';
import 'package:provider/provider.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class ChatPage extends StatefulWidget {
  final String userId, userName, userImage;
  ChatPage({this.userId, this.userName, this.userImage });
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController _messageController = TextEditingController();
  var _messagesListController = ScrollController();
  bool messagefieldEmpty = true;
  var _key = GlobalKey();
  bool isKeyboardVisible = false;


    @override
  void initState() {
    super.initState();
   

    var keyboardVisibilityController = KeyboardVisibilityController();
    keyboardVisibilityController.onChange.listen((bool keyboardVisible) {
      setState(() {
        isKeyboardVisible = keyboardVisible;
       
      });

      
    });
   
  }
  
@override
  Widget build(BuildContext context) {
    PreferencesProvider theme = Provider.of<PreferencesProvider>(context);
    return SafeArea(
      child: 
      
      Directionality(
        textDirection:theme.selectedLanguage == Languages.Arabic? TextDirection.rtl: TextDirection.ltr,
        child: Scaffold(
            backgroundColor: Provider.of<PreferencesProvider>(context).backgroundColor,
            body: Column(
             crossAxisAlignment: CrossAxisAlignment.end,   
          children: [
            appBar(),
            Expanded(child: messagesList()),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        children: [
                        
                           
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: TextField(
                              key: _key,
                              keyboardType: TextInputType.multiline,
                              style: TextStyle(color: Colors.black),
                              maxLines: null,
                              onChanged: (text) {
                                setState(() {
                                  if (text.isEmpty) {
                                    messagefieldEmpty = true;
                                  } else {
                                    messagefieldEmpty = false;
                                  }
                                });
                              },
                              controller: _messageController,
                              decoration: InputDecoration(
                                hintText: Provider.of<PreferencesProvider>(context).typeMessage,
                                hintStyle:
                                    TextStyle(color: Colors.grey, fontSize: 14),
                                labelStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                                errorStyle:
                                    TextStyle(color: Colors.red, fontSize: 14),
                                border: InputBorder.none,
                                //border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                                contentPadding: EdgeInsets.symmetric(vertical: 8),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          if (messagefieldEmpty)
                            IconButton(
                                icon: Icon(
                                  Icons.image,
                                  color: Colors.grey,
                                  size: 28,
                                ),
                                onPressed: () {
                                  Provider.of<MessagesProvider>(context, listen: false)
                                              .getImage(
                                               friendId: widget.userId,
                                               friendName: widget.userName,
                                               friendImage: widget.userImage
                                                   );
                                }),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    height: 48,
                    width: 48,
                    child: ElevatedButton(
                        onPressed: messagefieldEmpty ? null : () {
                          if (!messagefieldEmpty) {
                            setState(() {
                                    messagefieldEmpty = true;                        
                                                          });
                            Provider.of<MessagesProvider>(
                              context,
                              listen: false,
                            ).sendNewMessage(
                                message: _messageController.text,
                                friendId: widget.userId,
                                friendName: widget.userName,
                                friendImage: widget.userImage,
                                type: "text"
                                );
                          _messageController.clear();
                          FocusScope.of(context).unfocus();      
                          }
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                            messagefieldEmpty ? Colors.grey[350] : CustomTheme.LightPrimaryColor),
                            elevation: MaterialStateProperty.all<double>(2),
                            shape: MaterialStateProperty.all<OutlinedBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25))),
                            padding:
                                MaterialStateProperty.all<EdgeInsetsGeometry>(
                                    EdgeInsets.only(
                                      right: theme.selectedLanguage == Languages.Arabic? 5: 0,
                                       left: theme.selectedLanguage == Languages.Arabic? 0: 5))),
                        child: Center(
                          child: Icon(Icons.send,
                              color: Colors.white, size: 25),
                        )),
                  ),
                ],
              ),
            ),
        
          ],
        )),
      ),
    );
  }

  Widget appBar() {
    return Container(
      height: 80,
      color: Provider.of<PreferencesProvider>(context).primaryColor,
      padding: EdgeInsets.only(
        right: 16,
        left: 10,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          Container(
            height: 35,
            width: 35,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.grey[300]),
            child: ClipOval(
              child: 
               
               Image.network(widget.userImage,
               fit: BoxFit.fill,
            
               ),
                ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child:  Text(
                  widget.userName,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
          ),
          IconButton(
              icon: Icon(Icons.more_vert, color: Colors.white, size: 30),
              onPressed: () {
                
              }),
          SizedBox()
        ],
      ),
    );
  }

  Widget messagesList() {
    
    return Container(
      
      child: 
      FutureBuilder<List<MessageModel>>(
        future: Provider.of<MessagesProvider>(context).allChatroomMessages(widget.userId),
        initialData: [],
        builder: (ctx, messages){
          return  ListView.builder(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          reverse: true,
          controller: _messagesListController,
          itemCount: messages.data.length,
          itemBuilder: (context, index) {
            if(messages.data[index].type == "text") return buildBubbleMessage(messages.data[index]);
    return 
      buildImageViewer(messages.data[index]);
    
          });
        },
      )
      
     
    );
  }


  Widget buildBubbleMessage(MessageModel message){

    bool isMyMessage = message.userId == message.senderId;

    return Container(
     
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: isMyMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isMyMessage)
            Container(
              height: 25,
              width: 25,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Colors.grey[300]),
              child: ClipOval(
              child: 
                
               Image.network(widget.userImage,
               fit: BoxFit.fill,
                ),
                ),
            ),
          SizedBox(
            width: 5,
          ),

          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: isMyMessage 
                      ? CustomTheme.LightPrimaryColor.withOpacity(0.8)
                      : Colors.grey[300],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(isMyMessage ? 16 : 0),
                      bottomLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                      bottomRight: Radius.circular(isMyMessage ? 0 : 16))),
              child: Text(
                message.content,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: isMyMessage ?Colors.white  : Colors.grey[600],
                  fontSize: 14,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildImageViewer(MessageModel message) {

    bool isMyMessage = message.userId == message.senderId;

    return InkWell(
      onTap: (){
           Navigator.push(context, MaterialPageRoute(builder: (context) => FullImageScreen(message.content)));
      },
      child: Container(
        width: 150,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: isMyMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            if (!isMyMessage )
              Container(
                height: 25,
                width: 25,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.grey[300]),
                child: ClipOval(
              child: 
              
               Image.network(message.friendImage,
               fit: BoxFit.fill,
            
               ),
                ),
              ),
            SizedBox(
              width: 5,
            ),

            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Container(
                padding: EdgeInsets.all(10),
               
                child: Image.network(
                            message.content,
                            width: 150,
                            loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Container(
                                width: 150,
                                height: 200,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8.0),
                                  ),
                                ),
                               
                                child: Center(
                                  child: CircularProgressIndicator(
                                   
                                  ),
                                ),
                              );
                            },
                           
                          
                            fit: BoxFit.fill,
                          ),
              ),
            )
          ],
        ),
      ),
    );
 }





}
