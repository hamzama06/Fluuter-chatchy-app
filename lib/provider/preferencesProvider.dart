
import 'package:chatchy/ui/Languages.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



class PreferencesProvider extends ChangeNotifier{

  bool isDarkMode = false;
  SharedPreferences pref;
  String selectedLanguage = Languages.English; 



   ///// theme colors 
   Color get lightPrimaryColor{
     if(isDarkMode) return Color(0xff2C2C2C);
     return Color(0xff2AC573);
   } 

    Color get primaryColor{
     if(isDarkMode) return Colors.black;
     return Color(0xff27734B);
   } 

   Color get backgroundColor{
     if(isDarkMode) return Color(0xff2C2C2C);
     return Colors.grey[100];
   } 

   Color get bubbleColor1{
     return Color(0xff2AC573).withOpacity(0.8);
   } 
   Color get bubbleColor2{
     return Colors.grey[300];
   }
   
   Color get appBarTitleColor{
     return Colors.white;
   }
   
   Color get titleColor{
     if(isDarkMode) return Colors.white;
     return Colors.black;
   } 
  
   Color get subtitleColor{
     if(isDarkMode) return Colors.grey[200];
     return Colors.grey;
   } 
   
   Color get bottombarColor{
     if(isDarkMode) return Colors.black;
     return Colors.white;
   } 
   
   Color get bottomBarSelectedIconColor{
     return Color(0xff2AC573);
   }

    Color get bottomBarUnSelectedIconColor{
     if(isDarkMode) return Colors.grey[200];
     return Colors.grey[400];
   }


   // Languages 

   String get darkMode{
     if(selectedLanguage == Languages.English) return "Dark mode";
     if(selectedLanguage == Languages.Frensh) return "Mode sombre";
     return "الوضع المظلم";
   }
   String get preferences{
     if(selectedLanguage == Languages.English) return "Preferences";
     if(selectedLanguage == Languages.Frensh) return "Préférences";
     return "التفضيلات";
   }  

    String get language{
     if(selectedLanguage == Languages.English) return "Language";
     if(selectedLanguage == Languages.Frensh) return "Langue";
     return "اللغة";
   }
  String get account{
     if(selectedLanguage == Languages.English) return "Account";
     if(selectedLanguage == Languages.Frensh) return "Compte";
     return "الحساب";
   }
   String get changeEmail{
     if(selectedLanguage == Languages.English) return "Change email";
     if(selectedLanguage == Languages.Frensh) return "Changer l'email";
     return "تغيير البريد الإلكتروني";
   }
 String get changePassword{
     if(selectedLanguage == Languages.English) return "Change Password";
     if(selectedLanguage == Languages.Frensh) return "Changer le mots de passe";
     return "تغيير كلمة السر";
   }
   
         String get logOut{
     if(selectedLanguage == Languages.English) return "Log out";
     if(selectedLanguage == Languages.Frensh) return "Déconnecté";
     return "تسجيل الخروج";
   }

      String get editName{
     if(selectedLanguage == Languages.English) return "Edit name";
     if(selectedLanguage == Languages.Frensh) return "Changer le nom";
     return "تغيير الإسم";
   }

    String get friends{
     if(selectedLanguage == Languages.English) return "Friends";
     if(selectedLanguage == Languages.Frensh) return "Amis";
     return "الأصدقاء";
   }

   String get messages{
     if(selectedLanguage == Languages.English) return "Messages";
     if(selectedLanguage == Languages.Frensh) return "Messages";
     return "الرسائل";
   }

   String get search{
     if(selectedLanguage == Languages.English) return "Search";
     if(selectedLanguage == Languages.Frensh) return "Rechercher";
     return "بحث";
   }
   String get imageSended{
     if(selectedLanguage == Languages.English) return "You sent an image";
     if(selectedLanguage == Languages.Frensh) return "Vous avez envoyé une image";
     return "قمت بإرسال صورة";
   }

   String get imageRecieved{
     if(selectedLanguage == Languages.English) return "sent an image";
     if(selectedLanguage == Languages.Frensh) return "a envoyé une image";
     return "قام بإرسال صورة";
   }

   String get chooseLang{
     if(selectedLanguage == Languages.English) return "Choose Language";
     if(selectedLanguage == Languages.Frensh) return "Choiser la langue";
     return "إختيار اللغة";
   }

   String get english{
     if(selectedLanguage == Languages.English) return "English";
     if(selectedLanguage == Languages.Frensh) return "Anglais";
     return "الإنجليزية";
   }

   String get frensh{
     if(selectedLanguage == Languages.English) return "Frensh";
     if(selectedLanguage == Languages.Frensh) return "Français";
     return "الفرنسية";
   }

   String get arabic{
     if(selectedLanguage == Languages.English) return "Arabic";
     if(selectedLanguage == Languages.Frensh) return "Arabe";
     return "العربية";
   }

   String get desplayedLanguage{
     if(selectedLanguage == Languages.English) return "English";
     if(selectedLanguage == Languages.Frensh) return "Français";
     return "العربية";
   }
   String get save{
     if(selectedLanguage == Languages.English) return "Save";
     if(selectedLanguage == Languages.Frensh) return "Sauvegarder";
     return "حفظ";
   }
   String get cancel{
     if(selectedLanguage == Languages.English) return "Cancel";
     if(selectedLanguage == Languages.Frensh) return "Annuler";
     return "إلغاء";
   }

   String get nameLabel{
     if(selectedLanguage == Languages.English) return "Name";
     if(selectedLanguage == Languages.Frensh) return "Nom";
     return "الإسم";
   }
   String get nameHint{
     if(selectedLanguage == Languages.English) return "Enter your name";
     if(selectedLanguage == Languages.Frensh) return "Entrer votre nom";
     return "أدخل إسمك";
   }

   String get enterName {
     if(selectedLanguage == Languages.English) return "Please enter name";
     if(selectedLanguage == Languages.Frensh) return "Entre votre nom, svp";
     return "رجاء أدخل إسمك";
   }

   String get typeMessage {
     if(selectedLanguage == Languages.English) return "Type a message";
     if(selectedLanguage == Languages.Frensh) return "taper une message";
     return "أكتب رسالة";
   }

   String get email {
     if(selectedLanguage == Languages.English) return "Email address";
     if(selectedLanguage == Languages.Frensh) return "Adresse email";
     return "البريد الالكتروني";
   }

    String get currentPass {
     if(selectedLanguage == Languages.English) return "Current password";
     if(selectedLanguage == Languages.Frensh) return "Mots de passe actuale";
     return "كلمة السر الحالية";
   }

   String get pass {
     if(selectedLanguage == Languages.English) return "Password";
     if(selectedLanguage == Languages.Frensh) return "Mots de passe";
     return "كلمة السر";
   }


   String get login {
     if(selectedLanguage == Languages.English) return "Login";
     if(selectedLanguage == Languages.Frensh) return "Connexion";
     return "تسجيل الدخول";
   }

   String get notHaveAccount {
     if(selectedLanguage == Languages.English) return "Don't have an account ?";
     if(selectedLanguage == Languages.Frensh) return "Tu n'as pas de compte ?";
     return  "ليس لديك حساب ؟";
   }
    String get haveAccount {
     if(selectedLanguage == Languages.English) return "You already have an account ?";
     if(selectedLanguage == Languages.Frensh) return "Avez vous déja un compte ?";
     return  " لديك حساب ؟";
   }

   String get signUp {
     if(selectedLanguage == Languages.English) return "Sign up";
     if(selectedLanguage == Languages.Frensh) return "S'inscrire";
     return  "إنشاء حساب جديد";
   }

   String get enterEmail {
     if(selectedLanguage == Languages.English) return "Please enter the email";
     if(selectedLanguage == Languages.Frensh) return "Entrer l'email";
     return "أدخل البريد الالكتروني";
   }
   String get errorValidEmail {
     if(selectedLanguage == Languages.English) return "enter a valid email";
     if(selectedLanguage == Languages.Frensh) return "Entrer une adresse email valide";
     return "أدخل بريدًا الكترونيًا صحيحًا";
   }

   String get enterPass {
     if(selectedLanguage == Languages.English) return "Please enter your password";
     if(selectedLanguage == Languages.Frensh) return "Entrer votre mot passe, svp";
     return "الرجاء إدخال كلمة السر";
   }

   String get newPassHint {
     if(selectedLanguage == Languages.English) return "New Password";
     if(selectedLanguage == Languages.Frensh) return "Nouveau mot de passe";
     return "كلمة السر الجديدة";
   }

   String get confirmPass {
     if(selectedLanguage == Languages.English) return "Confirm password";
     if(selectedLanguage == Languages.Frensh) return "Confirmer le mot de passe";
     return "تأكيد كلمة السر";
   }
   
   String get passRequired {
     if(selectedLanguage == Languages.English) return "Password is required";
     if(selectedLanguage == Languages.Frensh) return "Mot de passe requis";
     return "كلمة المرور مطلوبة";
   }
    String get emailRequired {
     if(selectedLanguage == Languages.English) return "Email is required";
     if(selectedLanguage == Languages.Frensh) return "L'email requis";
     return "البريد الإلكتروني مطلوب";
   }

   String get errorEnterNewPass {
     if(selectedLanguage == Languages.English) return "Please enter the new Password";
     if(selectedLanguage == Languages.Frensh) return "Entrer le nouveau mots de passe";
     return "الرجاء إدخال كلمة السر الجديدة";
   }

   String get errorSmallPass {
     if(selectedLanguage == Languages.English) return "Password must be at least 6 chsracters";
     if(selectedLanguage == Languages.Frensh) return "mot pass doit étre d'au moins 6 charactère";
     return "كلمة السر يجب أن تتكون من 6 أحرف على الأقل";
   }

   String get passNotmatch {
     if(selectedLanguage == Languages.English) return "Password does not match";
     if(selectedLanguage == Languages.Frensh) return "Le mot pass ne correspond pas";
     return "كلمة السر غير متطابقة";
   }
    String get nameRequired {
     if(selectedLanguage == Languages.English) return "Name requied";
     if(selectedLanguage == Languages.Frensh) return "Le nom requis";
     return "الإسم مطلوب";
   }
   String get noResults {
     if(selectedLanguage == Languages.English) return "No results";
     if(selectedLanguage == Languages.Frensh) return "Aucun résultat";
     return "لا توجد نتائج ";
   }

      String get you{
     if(selectedLanguage == Languages.English) return "You:";
     if(selectedLanguage == Languages.Frensh) return "Toi:";
     return "أنت:";
   }

   double get titleFontSize{
     if(selectedLanguage == Languages.Arabic) return 15;
      return 16;
   }

   double get subTitleFontSize{
     if(selectedLanguage == Languages.Arabic) return 12;
      return 14;
   }

   void switchMode(bool isDark){
     
     if(isDark){


    isDarkMode = true;
    pref.setBool("isDarkMode", true);
    notifyListeners();
     }else{

    isDarkMode = false;
    pref.setBool("isDarkMode", false);
    notifyListeners();
     }
   }

   initPreferences() async{
     pref = await SharedPreferences.getInstance();
     if(pref.containsKey("isDarkMode")){
       isDarkMode = pref.getBool("isDarkMode");
     }
      if(pref.containsKey(Languages.LanguagePreferneces)){
        selectedLanguage = pref.getString(Languages.LanguagePreferneces);     
     }  
     notifyListeners();
   }

   chooseLanguage(String language){
        selectedLanguage = language;
        pref.setString(Languages.LanguagePreferneces, language);
        notifyListeners();
   }


}