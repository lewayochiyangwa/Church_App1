
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iserve_billing/dashboard/home2.dart';
import 'package:iserve_billing/global_constants.dart';
import 'package:iserve_billing/screens/Events.dart';
import 'package:iserve_billing/screens/PrayerRequest.dart';
import 'package:iserve_billing/screens/notes/note_home.dart';
import 'package:iserve_billing/screens/notes/note_home_try.dart';
import 'package:iserve_billing/settings.dart';
import 'package:iserve_billing/sign_ups/login_page.dart';
import 'package:iserve_billing/temp1/ui/widgets/CustomDevider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'navs.dart';



class DrawerClass extends StatefulWidget {
  DrawerClass({Key? key}) : super(key: key);

  @override
  State<DrawerClass> createState() => _DrawerClassState();
}

class _DrawerClassState extends State<DrawerClass> {
  late SharedPreferences logindata;

  late String username;
  late String username1="";
  late String email="";
  late bool check=true;
  @override
  void initState() {
    super.initState();

    initial_state();

  }

  initial_state() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      username=logindata.getString('username')!;
      username1=logindata.getString('username1')!;
      email=logindata.getString('email')!;
      //logindata.setBool('login', true);
    });
  }




  @override
  Widget build(BuildContext context) {
    return  Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(username1, style: TextStyle(color: Colors.black)),
            accountEmail: Text(email, style: TextStyle(color: Colors.black)),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage("assets/images/ghmi.jpg"),
            ),
          /*  decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/basamaoko_logo.png"),
                fit: BoxFit.fill,
              ),
            ),*/
          ),

          ListTile(
            leading: Icon(Icons.home),
            title: Text("Dashboard"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  BottomNavigationExample()),
              );
            },
          ),
    Divider(
    height: 30.0,
    thickness: 2.0,
    color: ThemeColor,
    indent: 20.0,
    endIndent: 20.0,),
          ListTile(
            leading: Icon(Icons.contact_mail),
            title: Text("Request Payer"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PrayerRequest()),// Settings()),
              );

            },
          ),
          CustomDevider(
            height: 30.0,
            thickness: 2.0,
            color: ThemeColor,
            indent: 20.0,
            endIndent: 20.0,
          ),
          ListTile(
            leading: Icon(Icons.contact_mail),
            title: Text("Save Notes"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NoteScreenTry()),// Settings()),NoteScreen
              );
            },
          ),

          CustomDevider(
            height: 30.0,
            thickness: 2.0,
            color: ThemeColor,
            indent: 20.0,
            endIndent: 20.0,
          ),
          ListTile(
            leading: Icon(Icons.logout,color: Colors.red,),
            title: Text(check?"Login":"Logout",style: TextStyle(color: Colors.red),),
            onTap: () {
              print("preparing to set new login");
              logindata.setBool('login', true);
              logindata.setString("function_log_control","");



              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SignInPage(),
                ),
              );

            },
          ),

        ],
      ),
    );
  }
}
