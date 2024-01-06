
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iserve_billing/dashboard/responsive.dart';
import 'package:iserve_billing/dashboard/starage_details.dart';
import 'package:iserve_billing/screens/Giving.dart';
import 'package:iserve_billing/screens/job_post2.dart';

import 'package:iserve_billing/services/params_controller.dart';
import 'package:iserve_billing/temp2/theme/colors.dart';
import 'package:iserve_billing/temp2/theme/images.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

import '../drawer.dart';
import '../global_constants.dart';

import '../temp1/ui/widgets/Footer.dart';
import '../temp1/ui/widgets/MyElevatedButtton.dart';
import '../temp1/ui/widgets/VideoComponent.dart';
import 'constants.dart';



class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
 // final database = MetersDatabase();



  late SharedPreferences logindata;
  late int userId;
  //late String clientID;

  List<Widget> jobCards = [Text(
    'recents'.tr,
    style: TextStyle(fontWeight: FontWeight.bold, color: KColors.title),
  )];



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

    for (var job in params_controller.recentPosts_data) {
      // print('ma locations'+job['location_name']);
      jobCards.add(_jobCard(context,
        //img: job['img']==null?'':'',
        title: job['location_name'],
        subtitle: job['job_name'],
        // salery: job['salery']==null?'':'',
      ));
    }//
    return params_controller.loading.value?Center(
      child: Container(
        constraints: BoxConstraints(maxHeight: 80), // Set a maximum height for the container
        margin: EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Align the content vertically
          children: [
            CircularProgressIndicator(
              strokeWidth: 4.0,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              backgroundColor: Colors.red,
            ),
            SizedBox(height: 5),
            Text(
              "Loading......",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    )
  : Scaffold(
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
                           // color: Colors.orange,
                            child:VideoComponent(),
                          ),
                          SizedBox(height: defaultPadding),

                          Container(
                          //  color: Colors.grey.shade200,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 50.0,right: 50.0),
                              child: Row(

                                children: [

                               MyElevatedButton(onPressed:(){
                                 print("Events Button Clicked");
                               },
                                   text: "Events", color: Colors.red.shade900,
                                   textColor: Colors.white,
                                   width: 100,
                                   height: 40,
                               ),
                                Spacer(),
                                  MyElevatedButton(onPressed:(){
                                    print("Give Button Clicked");
                                  },
                                      text: "Give ", color: Colors.red.shade900,
                                      textColor: Colors.white,
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
                            height: 150,
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
                                                "7:30PM",
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
                                                '13',
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
                                                "MARCH",
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
                                            child: Text("Wednesday Bible Study",
                                                style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color:ThemeColor)

                                            ),
                                          ),
                                          SizedBox(height: 15,),
                                          Icon(Icons.book),
                                          SizedBox(height: 15,),
                                          Padding(
                                            padding: const EdgeInsets.only(left:10.0),
                                            child: Text("1233 tafara",
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









  Widget _jobCard(
      BuildContext context, {
       // required String img,
        required String title,
        required String subtitle,
       // required String salery,
      }) {
    return GestureDetector(
      onTap: () {
      //  Navigator.push(context, JobDetailPage.getJobDetail());
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        margin: EdgeInsets.symmetric(vertical: 6),
        //decoration: BoxDecoration(color: Colors.white),
       //=========================
       // margin: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
       // padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(9.0),
          boxShadow: [
            BoxShadow(
                color: Colors.grey, blurRadius: 5.0, offset: Offset(0, 3))
          ],
        ),
      //  ==========================
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: KColors.lightGrey,
                borderRadius: BorderRadius.circular(4),
              ),
            //  child: Image.asset(""),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 12, color: KColors.subtitle),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                      fontSize: 14,
                      color: KColors.title,
                      fontWeight: FontWeight.bold),
                )
              ],
            )
          ],
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