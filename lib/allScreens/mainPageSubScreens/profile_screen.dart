import 'dart:io';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../services/providers/firbase_auth_handler.dart';
import '../../services/providers/news_providers.dart';
import '../../utils/app_colors.dart';
import '../../utils/global_widgets.dart';
import '../../widgets/global/my_brand_bold_text.dart';
import '../login_screens/login_screen.dart';
import '../profile_related_screens/notification_screen.dart';
import '../profile_related_screens/profile_details_screen.dart';
import '../profile_related_screens/profile_edit_screen.dart';
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<NewsProvider,FirebaseAuthHandler>(builder: (_,newsProvider,firebaseAuthHandleerProvider,__)
    {
      return Container(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MyBoldText(text: 'Profile', fontsize: 28, fontWeight: FontWeight.w700, color: MyAppColor.primary_color),
            SizedBox(height: 5,),
            headingWidget(newsProvider),
            divider(),
            Expanded(
              child: ListView(
                children: [

                  colorTiles(firebaseAuthHandleerProvider),
                  bwTiles(),
                ],
              ),
            )

          ],
        ),
      );
    });
  }

  Widget divider() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Divider(
        thickness: 1.5,
      ),
    );
  }

  Widget headingWidget(NewsProvider newsProvider) {
    return Row(
      children: [

        CircleAvatar(
          backgroundImage: AssetImage(newsProvider.userData.gender=='Male'?"assets/images/college_boy.png":"assets/images/college_girl.png"),
          radius: 50,
        ),
        SizedBox(width: 10,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 5,),
            Text("${newsProvider.userData.name}",
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                )),
            Text("${newsProvider.userData.email}",
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                )),
            SizedBox(height: 5,),
            Container(
              height: 40,
              width: 200,
              child: ElevatedButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileEditScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyAppColor.primary_color,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: EdgeInsets.zero
                  ),
                  child: Row(
                children: [
                  SizedBox(width: 15,),

                  Icon(Icons.edit_note,color: Colors.white,),
                  SizedBox(width: 30,),
                  Text('Edit Profile',style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white
                  ),)
                ],
              )),
            )
          ],
        )

      ],
    );
  }

  Widget colorTiles(FirebaseAuthHandler firebaseAuthHandler) {
    return Column(
      children: [
        InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (centext)=>ProfileDetailsScreen()));

            },
            child: colorTile(
                Icons.person_outline, Colors.deepPurple, "Personal data")),

        InkWell(
            onTap: () {
              Navigator.pushNamed(context, NotificationScreen.routePath);

            },
            child: colorTile(
                Icons.notifications_none_sharp, Colors.red, "Notifications")),


        InkWell(
          child: colorTile(
              Icons.contact_emergency_rounded, Colors.orange, "Contact us"),
          onTap: () async {
            _launchPhoneCall();
          },
        ),

        InkWell(
          child: colorTile(Icons.add_reaction, Colors.green, "Invite Friends"),
          onTap: () async {


          },
        ),

        InkWell(
          child: colorTile(Icons.info,Color(0xff166ddb), "About us"),
          onTap: () async {

          },
        ),


        InkWell(
            onTap: () async{

              showProgressBar(context,'Please Wait');
              await firebaseAuthHandler.signOut();
              Navigator.of(context).pushNamedAndRemoveUntil(
                LoginScreen.routePath,
                    (route) => false,
              );

            },
            child: colorTile(Icons.logout, Colors.pink, "Logout")),
      ],
    );
  }

  Widget bwTiles() {
    return Column(
      children: [
        InkWell(
          onTap: (){
            _launchPlayStore();

          },
            child: bwTile(Icons.star_rate_outlined, "Rate Us")),
        InkWell(
            onTap: () {
              exit(0);
            },
            child: bwTile(Icons.exit_to_app, "Exit")),
      ],
    );
  }

  Widget bwTile(IconData icon, String text) {
    return colorTile(icon, Colors.black, text, blackAndWhite: true);
  }

  Widget colorTile(IconData icon, Color color, String text,
      {bool blackAndWhite = false}) {
    Color pickedColor = Colors.white;
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,

          borderRadius: BorderRadius.circular(13)
      ),
      margin: EdgeInsets.fromLTRB(0, 4, 0, 4),
      padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
      child: ListTile(
        leading: Container(
          child: Icon(icon, color: color),
          height: 45,
          width: 45,
          decoration: BoxDecoration(
            color: blackAndWhite ? pickedColor : color.withOpacity(0.09),
            borderRadius: BorderRadius.circular(18),

          ),
        ),
        title: Text(text,
          textScaleFactor: 1,
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.black, size: 20),
      ),
    );
  }

  void _launchPhoneCall() async {
    String phoneNumber = 'tel:+918007453007'; // Replace with the desired phone number
    if (await canLaunch(phoneNumber)) {
      await launch(phoneNumber);
    } else {
      // Handle error, for example, show an error dialog
      print('Could not launch $phoneNumber');
    }
  }

  void _launchPlayStore() async {
    const String url = 'https://play.google.com/store/apps/details?id=com.harshad.finixmulti_user';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }



}
