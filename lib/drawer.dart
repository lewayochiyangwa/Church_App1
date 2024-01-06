
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iserve_billing/dashboard/home2.dart';
import 'package:iserve_billing/screens/Events.dart';
import 'package:iserve_billing/settings.dart';
import 'package:iserve_billing/sign_ups/login_page.dart';
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
    });
  }




  @override
  Widget build(BuildContext context) {
    return  Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(username1,style: TextStyle(color: Colors.black),),
            accountEmail: Text(email,style: TextStyle(color: Colors.black),),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://appmaking.co/wp-content/uploads/2021/08/appmaking-logo-colored.png"),
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  "https://appmaking.co/wp-content/uploads/2021/08/android-drawer-bg.jpeg",
                ),
                fit: BoxFit.fill,
              ),
            ),
           /* otherAccountsPictures: [
              CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(
                    "https://randomuser.me/api/portraits/women/74.jpg"),
              ),
              CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(
                    "https://randomuser.me/api/portraits/men/47.jpg"),
              ),
            ],*/
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
    color: Colors.orange,
    indent: 20.0,
    endIndent: 20.0,),
          ListTile(
            leading: Icon(Icons.contact_mail),
            title: Text("Jobs Wanted"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  Events()),
              );

            },
          ),
    Divider(
    height: 30.0,
    thickness: 2.0,
    color: Colors.orange,
    indent: 20.0,
    endIndent: 20.0,),
          ListTile(
            leading: Icon(Icons.contact_mail),
            title: Text("Data Load"),
            onTap: () {
            /*  Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),// Settings()),
              );*/
            },
          ),
          Divider(
            height: 30.0,
            thickness: 2.0,
            color: Colors.orange,
            indent: 20.0,
            endIndent: 20.0,),
          ListTile(
            leading: Icon(Icons.logout,color: Colors.red,),
            title: Text("Logout"),
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
