import 'package:chatchy/models/userModel.dart';
import 'package:chatchy/provider/preferencesProvider.dart';
import 'package:chatchy/provider/userProvider.dart';
import 'package:chatchy/ui/languages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chatchy/ui/customTheme.dart';

import 'chatPage.dart';
import 'custom_shapes/customShape1.dart';

class FriendsPage extends StatefulWidget {
  @override
  _FriendsPageState createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage>
  //  with SingleTickerProviderStateMixin
     {
  TextEditingController _searchController = TextEditingController();
  var  _allFriendsListController = ScrollController();
  int selectedTabIndex = 0;
  List<UserModel> allFriends = [];
  List<UserModel> filtredFriends = [];

  @override
  void initState() {
 
    super.initState();
   
  }

  @override
  void dispose() {
    super.dispose();
   _searchController.dispose();
   _allFriendsListController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
    Consumer<PreferencesProvider>(builder: (ctx, theme, child){
    return  Scaffold(
      backgroundColor: theme.backgroundColor,
      body:  Column(
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
                    top: 16,
                    left: 20,
                    child: Container(
                      width: MediaQuery.of(context).size.width - 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            theme.friends,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                     
                        ],
                      ),
                    )),
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
                        border:
                            Border.all(color: Colors.grey[400], width: 0.8)),
                    child: TextField(
                      keyboardType: TextInputType.text,
                      style: TextStyle(color: Colors.black),
                      controller: _searchController,
                      onChanged: (text){
                                     setState(() {
                                       filtredFriends = allFriends.where((element) => element.name.toString().toLowerCase().contains(text.toLowerCase())).toList();                                
                                                                          });   
                                  },
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.grey[400],
                          size: 20,
                        ),

                        hintText: theme.search,
                        hintStyle:
                            TextStyle(color: Colors.grey[400], fontSize: 14),
                        labelStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                        errorStyle: TextStyle(color: Colors.red, fontSize: 14),
                        border: InputBorder.none,
                       contentPadding: EdgeInsets.symmetric(vertical: 4),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),

      Expanded(
              child:
              allFreinds(theme)
        
          ),

          
        ],
      )
     );
    });
  }

  Widget allFreinds(PreferencesProvider theme) {

    return Padding(
      padding: const EdgeInsets.all(10),
      child:
      FutureBuilder<List<UserModel>>(
        future: Provider.of<UserProvider>(context, listen: false).getAllUsers(),
        builder: (ctx, friends){

         if(friends.connectionState == ConnectionState.waiting){
           return Center(child: CircularProgressIndicator());
         } 
          allFriends = friends.data;
                if(_searchController.text.isEmpty) filtredFriends = friends.data; 
        return 
        _searchController.text.isNotEmpty && filtredFriends.length == 0 ?
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
          controller: _allFriendsListController,
          itemCount: filtredFriends.length,
          itemBuilder: (context, index) {
            return friendItem(filtredFriends[index]);
          });
        } ,)
      
       
    );
  }

  Widget friendItem(UserModel user) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (ctx) => ChatPage(userId: user.id, userName: user.name, userImage: user.imageUri,)));
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          children: [
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Colors.grey[300]),
              child: ClipOval(
              child: 
                user.imageUri.toString().isEmpty? 
                Center(child: Icon(Icons.person, size: 18, color: Colors.grey,),):
               Image.network(user.imageUri,
               fit: BoxFit.fill,
             
               ),
                ),
            ),
            SizedBox(
              width: 16,
            ),
            Expanded(
                child: Text(
              user.name,
              
              style: TextStyle(fontWeight: FontWeight.w600,
               fontSize: 15,
               color: Provider.of<PreferencesProvider>(context).titleColor
               ),
            )),
            Container(
              height: 6,
              width: 6,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: CustomTheme.LightPrimaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
