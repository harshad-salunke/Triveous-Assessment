
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newsapp/allScreens/login_screens/register_screen.dart';
import 'package:provider/provider.dart';

import '../../services/providers/firbase_auth_handler.dart';
import '../../services/providers/news_providers.dart';
import '../../textController/LoginController.dart';
import '../../utils/app_colors.dart';
import '../../utils/global_widgets.dart';
import '../../widgets/global/my_elevated_button.dart';
import '../main_screen.dart';

class LoginScreen extends StatefulWidget {
  static String routePath = "/loginscreen";

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
Logincontroller logincontroller=Logincontroller();
bool _passwordVisible=true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<NewsProvider,FirebaseAuthHandler>(builder: (_,newsProvider,firebaseAuthHandleerProvider,__)
    {
      return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: SingleChildScrollView(

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage('assets/images/logo.png'),
                      height: 80,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      ' Login to get started',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontFamily: 'Brand-Bold',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 400,
                      height: 400,
                      padding: const EdgeInsets.only(bottom: 15),
                      margin: const EdgeInsets.only(bottom: 15 * 4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          TextField(
                            controller: logincontroller.email_Controller,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              prefixIcon: Icon(Icons.email_outlined,size: 25,),
                              filled: false,
                              hintText: "Email",
                              labelText: "Email",
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 22, horizontal: 15),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black
                                  )
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: MyAppColor.primary_color
                                  )
                              ),

                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: MyAppColor.primary_color
                                  )
                              ),
                            ),
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Brand-Bold",
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextField(
                            controller: logincontroller.password_Controller,
                            keyboardType: TextInputType.text,
                            obscureText: _passwordVisible,
                            decoration: InputDecoration(
                              hintText: "Password",
                              labelText: "Password",
                              isDense: true,
                              prefixIcon: Icon(Icons.lock,size: 25,),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                              ),                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 22, horizontal: 15),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black
                                  )
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: MyAppColor.primary_color
                                  )
                              ),

                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: MyAppColor.primary_color
                                  )
                              ),
                            ),
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Brand-Bold",
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),

                          SizedBox(
                            height: 8,
                          ),

                          SizedBox(
                            height: 10,
                          ),
                          MyElevatedButton(
                              title: "Login",
                              height: 55,
                              width: double.infinity,
                              fontsize: 18,
                              radius: 10,
                              bg_color: MyAppColor.primary_color,
                              fontWeight: FontWeight.w600,
                              onPressed: () {
                                loginUserAccount(newsProvider,firebaseAuthHandleerProvider);
                              }),
                          SizedBox(
                            height: 10,
                          ),

                          Text(
                            "OR",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Brand-Bold",
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),


                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, RegisterScreen.routePath);
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(double.infinity, 55),
                              side: BorderSide(
                                  color: MyAppColor.primary_color), // Border color
                              // Customize other button appearance here

                              // backgroundColor: Color(0xffd6e2ea),

                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(
                                  image: AssetImage('assets/images/google_logo.png'),
                                  height: 30,
                                  width: 30,
                                ),
                                SizedBox(width: 10,),
                                Text(
                                  "Create Account ",
                                  style: TextStyle(
                                    color: MyAppColor.primary_color,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Brand-Bold",
                                    fontSize: 18,
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(children: [
                                TextSpan(
                                    text: "Don't have an Account ? ",
                                    style:
                                    TextStyle(color: Colors.black, fontSize: 16)),
                                TextSpan(
                                  text: "Register Now",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pushNamed(
                                          context, RegisterScreen.routePath);
                                    },
                                )
                              ])),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },);
  }



void loginUserAccount(NewsProvider newsProvider,FirebaseAuthHandler firebaseAuthHandler)  async {
  if(logincontroller.isValid()!="true"){
    String input_error=logincontroller.isValid();
    showToast(input_error, ContentType.failure,context);

  }else{
    Map<String,String> login_data=logincontroller.getUserData();
    showProgressBar(context,'LOGIN');
    String auth_response=await firebaseAuthHandler.signInWithEmailAndPassword(login_data['email']!,login_data['password']!);
    if(auth_response=='login'){

      showToast("You Login Successfully ...!", ContentType.success,context);
      newsProvider.fetchUserDetails();
      newsProvider.fetchHomeNews();
      newsProvider.fetchLovedArticle();
      newsProvider.fetchReadingArticle();

      Navigator.pop(context);
      Navigator.of(context).pushNamedAndRemoveUntil(
        MainScreen.routePath,
            (route) => false,
      );
    } else{
      Navigator.pop(context);
      showToast(auth_response, ContentType.failure,context);
    }


  }

}

}
