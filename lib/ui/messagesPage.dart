import 'package:chatchy/models/messageModel.dart';
import 'package:chatchy/provider/messagesProvider.dart';
import 'package:chatchy/provider/preferencesProvider.dart';
import 'package:chatchy/ui/chatPage.dart';
import 'package:chatchy/ui/custom_shapes/customShape1.dart';
import 'package:chatchy/ui/languages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessagesPage extends StatefulWidget {
  @override
  _MessagesPageState createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  TextEditingController _searchController = TextEditingController();
  var _messagesListController = ScrollController();
  List<MessageModel> allMessages = [];
  List<MessageModel> filtredMessages = [];
  

  @override
    void initState() {

      super.initState();
    }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
    _messagesListController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferencesProvider>(builder: (ctx, theme, child) {
      return Scaffold(
          backgroundColor: theme.backgroundColor,
          body: Column(
            children: [
              Container(
                color: Colors.transparent,
                child: Stack(
                  children: [
                    CustomPaint(
                      size: Size(MediaQuery.of(context).size.width, 120),
                      painter: CustomShape1(theme.primaryColor),
                    ),
                    Positioned(
                      top: 22,
                      left: theme.selectedLanguage == Languages.Arabic
                          ? null
                          : 20,
                      right: theme.selectedLanguage == Languages.Arabic
                          ? 20
                          : null,
                      child: Text(
                        theme.messages,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Positioned(
                      bottom: 5,
                      left: 25,
                      right: 25,
                      child: Container(
                        width: MediaQuery.of(context).size.width - 50,
                        height: 45,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                                color: Colors.grey[400], width: 0.8)),
                        child: TextField(
                          keyboardType: TextInputType.name,
                          style: TextStyle(color: Colors.black),
                          onChanged: (text) {
                            setState(() {
                              filtredMessages = allMessages
                                  .where((element) => element.friendName  
                                      .toString()
                                      .toLowerCase()
                                      .contains(text.toLowerCase()))
                                  .toList();
                            });
                          },
                          controller: _searchController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.grey[400],
                              size: 20,
                            ),

                            hintText: theme.search,
                            hintStyle: TextStyle(
                                color: Colors.grey[400], fontSize: 14),
                            labelStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                            errorStyle:
                                TextStyle(color: Colors.red, fontSize: 14),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 4),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(10),
                    child:
                    FutureBuilder<List<MessageModel>>(
                      future:
                          Provider.of<MessagesProvider>(context).allMessages(),
                          initialData: [],
                      builder: (ctx, messages) {
                       
                         
                          
                        allMessages = messages.data;
                        if (_searchController.text.isEmpty)
                          filtredMessages = allMessages ;
                        return 
                        _searchController.text.isNotEmpty && filtredMessages.length == 0 ?
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  Icon(Icons.search_off, size: 50, color: theme.subtitleColor,),
                  Text(theme.noResults, style: TextStyle(fontSize: 22, color: theme.subtitleColor),)
              ],
            ),
          )
        :
                        ListView.builder(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            controller: _messagesListController,
                            itemCount: filtredMessages.length,
                            itemBuilder: (context, index) {
                              return messagesItem1(filtredMessages[index]);
                            });
                      },
                    )
                    
                    

                    
                    ),
              )
            ],
          ));
    });
  }



  Widget messagesItem1(MessageModel messageData) {
    String time = Provider.of<MessagesProvider>(context)
        .sendedMessageDate(messageData.timestamp);
    PreferencesProvider theme = Provider.of<PreferencesProvider>(context);
    bool isMyMessage = messageData.senderId == messageData.userId;
       return ListTile(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (ctx) => ChatPage(
                    userId: messageData.friendId,
                    userName: messageData.friendName,  
                    userImage: messageData.friendImage))); 
      },
      minVerticalPadding: 5,
      title: Row(
        children: [
          Expanded(
            child: Text(
              messageData.friendName,   
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: theme.titleColor),
            ),
          ),
          Text(time, style: TextStyle(color: theme.subtitleColor, fontSize: 12))
        ],
      ),
      subtitle: Text(
        messageData.type == "text" ?
        isMyMessage?
         "${theme.you} ${messageData.content}" :
         
         messageData.content
         :
         isMyMessage?
          theme.imageSended:
          "${messageData.friendName} ${theme.imageRecieved}",
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            fontWeight: FontWeight.normal,
            color: theme.subtitleColor),
      ),
      leading: Container(
        height: 35,
        width: 35,
        decoration:
            BoxDecoration(shape: BoxShape.circle, color: Colors.grey[300]),
        child: ClipOval(
          child:Image.network(
                  messageData.friendImage,
                  fit: BoxFit.fill,
               
                ),
        ),
      ),
    );
         
      
     
   
    
  
  }
}
