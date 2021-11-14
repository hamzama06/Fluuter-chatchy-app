import 'package:chatchy/models/userModel.dart';
import 'package:chatchy/provider/authProvider.dart';
import 'package:chatchy/provider/preferencesProvider.dart';
import 'package:chatchy/provider/userProvider.dart';
import 'package:chatchy/ui/Languages.dart';
import 'package:chatchy/ui/editEmailPage.dart';
import 'package:chatchy/ui/editPasswordPage.dart';
import 'package:chatchy/ui/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'custom_shapes/customShape1.dart';
import 'package:chatchy/ui/customTheme.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool enableDarkMode = false;
  var _formKey = GlobalKey<FormState>();
  TextEditingController nameController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<PreferencesProvider, UserProvider>(
        builder: (ctx, themeProvider, userProvider, child) {
      return Scaffold(
        backgroundColor: themeProvider.backgroundColor,
        body: SingleChildScrollView(
            child: FutureBuilder<UserModel>(
                future: Provider.of<UserProvider>(context, listen: false)
                    .getUserData(),
                builder: (ctx, snapshot) {
                  UserModel user = snapshot.data;
                  if (!snapshot.hasData) return loadingScreen();

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: Colors.transparent,
                        child: Stack(
                          children: [
                            CustomPaint(
                              size:
                                  Size(MediaQuery.of(context).size.width, 240),
                              painter: CustomShape1(themeProvider.primaryColor),
                            ),
                            Positioned(
                              top: 25,
                              right: 0,
                              left: 0,
                              child: Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.black),
                                      color: Colors.grey[300]),
                                  width: 120,
                                  height: 120,
                                  child: ClipOval(
                                    child: Image.network(
                                      user.imageUri,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 150,
                              left: 0,
                              right: 0,
                              child: Text(
                                user.name,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 5),
                        child: Text(
                          themeProvider.preferences,
                          style: TextStyle(
                              fontSize: themeProvider.titleFontSize,
                              fontWeight: FontWeight.bold,
                              color: themeProvider.titleColor),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              themeProvider.darkMode,
                              style: TextStyle(
                                  color: themeProvider.titleColor,
                                  fontSize: themeProvider.subTitleFontSize,
                                  fontWeight: FontWeight.w600),
                            ),
                            Switch(
                              value: themeProvider.isDarkMode,
                              onChanged: (value) {
                                Provider.of<PreferencesProvider>(context,
                                        listen: false)
                                    .switchMode(value);
                                setState(() {
                                  enableDarkMode = value;
                                });
                              },
                              activeColor: CustomTheme.LightPrimaryColor,
                            )
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 0.8,
                        height: 0.8,
                        color: themeProvider.isDarkMode
                            ? Colors.grey[600]
                            : Colors.grey[300],
                      ),
                      InkWell(
                        onTap: () {
                          showLanguaguePicker();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                themeProvider.language,
                                style: TextStyle(
                                    color: themeProvider.titleColor,
                                    fontSize: themeProvider.subTitleFontSize,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                themeProvider.desplayedLanguage,
                                style: TextStyle(
                                    color: themeProvider.subtitleColor,
                                    fontSize: themeProvider.subTitleFontSize),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(
                          thickness: 0.8,
                          height: 0.8,
                          color: themeProvider.isDarkMode
                              ? Colors.grey[600]
                              : Colors.grey[300]),
                      SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          themeProvider.account,
                          style: TextStyle(
                              fontSize: themeProvider.titleFontSize,
                              fontWeight: FontWeight.bold,
                              color: themeProvider.titleColor),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) => EditEmailPage(
                                      userProvider.currentUser.email)));
                        },
                        title: Text(
                          themeProvider.changeEmail,
                          style: TextStyle(
                              color: themeProvider.titleColor,
                              fontSize: themeProvider.subTitleFontSize,
                              fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(
                          userProvider.currentUser.email,
                          style: TextStyle(
                              color: themeProvider.subtitleColor, fontSize: 12),
                        ),
                        dense: true,
                      ),
                      Divider(
                          thickness: 0.8,
                          height: 0.8,
                          color: themeProvider.isDarkMode
                              ? Colors.grey[600]
                              : Colors.grey[300]),
                      ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) => EditPasswordPage()));
                        },
                        title: Text(
                          themeProvider.changePassword,
                          style: TextStyle(
                              color: themeProvider.titleColor,
                              fontSize: themeProvider.subTitleFontSize,
                              fontWeight: FontWeight.w600),
                        ),
                        dense: true,
                      ),
                      Divider(
                          thickness: 0.8,
                          height: 0.8,
                          color: themeProvider.isDarkMode
                              ? Colors.grey[600]
                              : Colors.grey[300]),
                      ListTile(
                        onTap: () {
                          Provider.of<AuthProvider>(context, listen: false)
                              .signOut()
                              .whenComplete(() {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) => LoginPage()));
                          });
                        },
                        title: Align(
                            alignment: Alignment(
                                themeProvider.selectedLanguage ==
                                        Languages.Arabic
                                    ? 1.2
                                    : -1.2,
                                0),
                            child: Text(
                              themeProvider.logOut,
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: themeProvider.subTitleFontSize,
                                  fontWeight: FontWeight.bold),
                            )),
                        leading: Icon(
                          Icons.logout,
                          color: Colors.red,
                        ),
                        dense: true,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      )
                    ],
                  );
                })),
      );
    });
  }

  Widget loadingScreen() {
    return Container(
      child: Shimmer.fromColors(
        baseColor: Colors.grey[200],
        highlightColor: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              height: 220,
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10)),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 180,
                height: 24,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                height: 24,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                height: 24,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: 180,
                height: 24,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                height: 24,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                height: 24,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  showDialogEditName(name) {
    PreferencesProvider prefProvider =
        Provider.of<PreferencesProvider>(context, listen: false);
    nameController = TextEditingController(text: name);

    Widget cancelButton = TextButton(
      child: Text(
        prefProvider.cancel,
        style: TextStyle(color: Colors.red),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget submitButton = TextButton(
      child: Text(
        prefProvider.save,
        style: TextStyle(color: CustomTheme.PrimaryColor),
      ),
      onPressed: () {
        if (_formKey.currentState.validate()) {
          Provider.of<UserProvider>(context, listen: false)
              .updateName(nameController.text)
              .whenComplete(() {
            Navigator.of(context).pop();
          });
        }
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text(
        prefProvider.editName,
        style: TextStyle(
            fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
      ),
      content: Form(
        key: _formKey,
        child: Padding(
            padding: EdgeInsets.only(top: 16, bottom: 16),
            child: TextFormField(
              keyboardType: TextInputType.text,
              style: TextStyle(fontSize: 12),
              controller: nameController,
              validator: (text) {
                if (text.isEmpty) return prefProvider.enterName;
                return null;
              },
              decoration: InputDecoration(
                labelText: prefProvider.nameLabel,
                hintText: prefProvider.nameHint,
                errorStyle: TextStyle(color: Colors.red, fontSize: 12.0),
              ),
            )),
      ),
      actions: [
        cancelButton,
        submitButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showLanguaguePicker() {
    PreferencesProvider prefProvider =
        Provider.of<PreferencesProvider>(context, listen: false);

    AlertDialog alert = AlertDialog(
        title: Text(
          prefProvider.chooseLang,
          style: TextStyle(
              fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              onTap: () {
                prefProvider.chooseLanguage(Languages.English);
                Navigator.pop(context);
              },
              title: Text(
                prefProvider.english,
                style: TextStyle(color: Colors.black, fontSize: 14),
              ),
            ),
            Divider(
              thickness: 0.8,
              height: 0.8,
            ),
            ListTile(
              onTap: () {
                prefProvider.chooseLanguage(Languages.Frensh);
                Navigator.pop(context);
              },
              title: Text(
                prefProvider.frensh,
                style: TextStyle(color: Colors.black, fontSize: 14),
              ),
            ),
            Divider(
              thickness: 0.8,
              height: 0.8,
            ),
            ListTile(
              onTap: () {
                prefProvider.chooseLanguage(Languages.Arabic);
                Navigator.pop(context);
              },
              title: Text(
                prefProvider.arabic,
                style: TextStyle(color: Colors.black, fontSize: 14),
              ),
            ),
            Divider(
              thickness: 0.8,
              height: 0.8,
            ),
          ],
        ),
        actions: [
          TextButton(
            child: Text(
              prefProvider.cancel,
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ]);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
