import 'package:chatchy/provider/preferencesProvider.dart';
import 'package:chatchy/ui/FriendsPage.dart';
import 'package:chatchy/ui/languages.dart';
import 'package:chatchy/ui/messagesPage.dart';
import 'package:chatchy/ui/settingsPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

    int _currentScreenIndex = 0;

  final List<Widget> _screens = [
    MessagesPage(),
    FriendsPage(),
    SettingsPage()
  ];

 @override
  Widget build(BuildContext context) {
    PreferencesProvider theme = Provider.of<PreferencesProvider>(context);
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Directionality(
          textDirection: theme.selectedLanguage == Languages.Arabic? TextDirection.rtl : TextDirection.ltr,
          child: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.forum_rounded),
                label: "Messages"
                ),
              BottomNavigationBarItem(
                icon: Icon(Icons.group_rounded),
                label: "friends"
                
                ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: "settings"
                ),

            ],
            currentIndex: _currentScreenIndex,
            selectedItemColor: theme.bottomBarSelectedIconColor,
            unselectedItemColor: theme.bottomBarUnSelectedIconColor,
            showUnselectedLabels: false,
            showSelectedLabels: false,
            backgroundColor: theme.bottombarColor,
           
            onTap: (index){
              setState(() {
                          _currentScreenIndex = index;
                        });
            }, 
            ),
        ),
        body:
        Directionality(textDirection: theme.selectedLanguage == Languages.Arabic? TextDirection.rtl : TextDirection.ltr,
         child: _screens[_currentScreenIndex])
         ,
      ),
    );
  }
}