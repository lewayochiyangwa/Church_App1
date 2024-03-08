

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:iserve_billing/dashboard/responsive.dart';

import 'package:iserve_billing/services/params_controller.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../global_constants.dart';

import '../adverts/AdMob.dart';
import '../screens/Events2.dart';
import '../screens/Giving2.dart';
import '../screens/PrayerRequest.dart';
import '../screens/text_to_speech.dart';
import '../temp1/ui/widgets/Footer.dart';
import '../temp1/ui/widgets/MyElevatedButtton.dart';
import '../temp1/ui/widgets/VideoComponent.dart';
import 'constants.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';


class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
 // final database = MetersDatabase();

  late SharedPreferences logindata;
  late SharedPreferences logindata2;
  late int userId;
  //late String clientID;





  @override
  void initState() {
    super.initState();
    initial_state();


  }

 // late VideoPlayerController _controller;


  initial_state() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      userId=logindata.getInt('id')!;
      //clientID=logindata.getString('clientID')!;
    });
  }










  @override
  Widget build(BuildContext context) {
    final params_controller =  Get.put<ParamsController>(ParamsController());


    return Scaffold(
     // backgroundColor: Colors.grey.shade900,
      body:  Container(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(0.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 5,
                      child: Column(
                        children: [
                          Container(
                         // margin: const EdgeInsets.all(8.0),
                          //padding: const EdgeInsets.all(10.0),
                            height: 200,
                            width:double.infinity,
                           // color: ThemeColor,
                            child:VideoComponent(),
                          ),
                          SizedBox(height:5),

                          Container(
                          //  color: Colors.grey.shade200,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 50.0,right: 50.0),
                              child: Row(

                                children: [

                               MyElevatedButton(onPressed:(){
                                 print("Events Button Clicked");


                                 Navigator.push(
                                   context,
                                   MaterialPageRoute(builder: (context) => Events2()),// Settings()),
                                 );
                               },
                                   text: "Events", color:ThemeColor ,//Colors.red.shade900
                                   textColor: ThemeColor2,
                                   width: 100,
                                   height: 40,
                               ),
                                Spacer(),
                                  MyElevatedButton(onPressed:(){
                                    print("Give Button Clicked");
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Giving2()),// Settings()),
                                    );
                                  },
                                      text: "Give ", color:ThemeColor,
                                      textColor: ThemeColor2,
                                      width: 100,
                                      height: 40,
                                  ),
                              ],),
                            ),
                          ),
                        //  SizedBox(height: defaultPadding),
                          Container(
                           // color: Colors.brown,
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            margin: EdgeInsets.symmetric(vertical: 12),
                            height: 130,
                            width: MediaQuery.of(context).size.width,
                            child: Card(
                              color:Colors.black12,
                              child: Container(
                               //color: Colors.purple,
                                child: Row(
                                  children: [
                                    Container(
                                      child: Column(
                                        children: [
                                          SizedBox(height: 10,),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 8.0),
                                            child: Text(
                                              "TODAY",
                                                style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white54)
                                            ),
                                          ),
                                          SizedBox(height:2,),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 8.0),
                                            child: Text(
                                                "20:00 PM",
                                                style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white54)
                                            ),
                                          ),
                                          SizedBox(height:5,),
                                          Container(
                                            width: 30,
                                            height: 30,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: ThemeColor,
                                            ),
                                            child: Center(
                                              child: Text(
                                                '14',
                                                style: TextStyle(
                                                  fontSize: 24,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 7,),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 8.0),
                                            child: Text(
                                                "Feb",
                                                style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color:ThemeColor)

                                            ),
                                          ),
                                        ],
                                      ),

                                    ),
                                    VerticalDivider(
                                      color: Colors.white,
                                    ),
                                    Container(
                                      child: Column(
                                        children: [
                                          SizedBox(height: 10,),

                                          Padding(
                                            padding: const EdgeInsets.only(left:10.0),
                                            child: Text("Wednesday Partners",
                                                style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color:ThemeColor)

                                            ),
                                          ),
                                          SizedBox(height: 15,),
                                          Icon(Icons.book),
                                          SizedBox(height: 15,),
                                          Padding(
                                            padding: const EdgeInsets.only(left:10.0),
                                            child: Text("ZOOM",
                                                style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white54)

                                            ),
                                          ),
                                        ],
                                      ),

                                    )

                                  ],
                                ),
                              ),
                            ),
                          ),
                          MyElevatedButton(
                            onPressed:() async {

                            logindata = await SharedPreferences.getInstance();
                            if(logindata.getBool('login')!){
                           //   logindata2 = await SharedPreferences.getInstance();
                           //   logindata2.setString("login2","granted");

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Login To Submit Prayer Request"),
                                  duration: Duration(seconds: 4),
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(color: Colors.red, width: 2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              );
                            //  print("hmm andisi kuziva");
                            }else{

                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => PrayerRequest()),// Settings()),
                              );
                            }

                          },
                            text: "Prayer Request ", color:ThemeColor,
                            textColor:ThemeColor2,
                            width: 200,
                            height: 30,
                          ),
                          AdmobAdvert(),

                          SizedBox(height:defaultPadding),
                       Footer(
                       theme:"JOIN THE WORSHIPPING",
                        subtitle:"SUNDAY",
                        fromTime:"9 AM",
                        toTime:"4 PM",
                        color:Colors.grey.shade200,
                        theme_color:Colors.grey.shade400,
                        subtitle_color:ThemeColor,
                        toTime_color:Colors.grey.shade400,
                        fromTime_color:Colors.grey.shade400,

                       )

                         // StarageDetails()
                        ],
                      ),
                    ),
                    if (!Responsive.isMobile(context))
                      SizedBox(width: defaultPadding),
                    // On Mobile means if the screen is less than 850 we dont want to show it
                   /** if (!Responsive.isMobile(context))
                      Expanded(
                        flex: 2,
                        child:  ProgressLine(
                          color:Colors.orange,
                          percentage: 40,
                        ),
                      ),*/
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }













}

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: const [
        CircleAvatar(
          backgroundColor: Colors.white,
          radius: 24,
          child: Icon(Icons.check),
        ),
        SizedBox(
          width: 50,
          height: 50,
          child: CircularProgressIndicator(
            color: Colors.grey,
            value: 1,
          ),
        ),
        SizedBox(
          width: 50,
          height: 50,
          child: CircularProgressIndicator(
            color: Colors.blue,
            value: .3, // Change this value to update the progress
          ),
        ),
      ],
    );
  }
}