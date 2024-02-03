

import 'package:flutter/material.dart';

import '../../../global_constants.dart';

class Footer extends StatelessWidget {
 // const Footer({Key? key}) : super(key: key);
  const Footer({
    Key? key,
    required this.theme,
    required this.subtitle,
    required this.fromTime,
    required this.toTime,
    required this.color,

    required this.theme_color,
    required this.subtitle_color,
    required this.toTime_color,
    required this.fromTime_color,
  }) : super(key: key);
  final String  theme;
  final String subtitle;
  final String fromTime;
  final String toTime;
  final Color color;

  final Color theme_color;
  final Color subtitle_color;
  final Color toTime_color;
  final Color fromTime_color;


  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 180,

      width:double.infinity,
      color: Colors.grey.shade200,
      child: Column(
        children: [
          SizedBox(height:20,),

          Text("JOIN THE WORSHIPPING",//"JOIN THE WORSHIPPING",
              style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color:theme_color)//Colors.grey.shade400
          ),
          SizedBox(height:15,),
          Text(subtitle, style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color:subtitle_color)//"SUNDAY" ThemeColor
          ),
          SizedBox(height:20,),
          Padding(
            padding: const EdgeInsets.only(left: 80.0),
            child: Row(
              children: [
                Text(fromTime,//"9 AM",
                    style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color:fromTime_color)//Colors.grey.shade400
                ),
                SizedBox(width: 120,),
                Text(toTime,//"4 PM",
                    style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color:toTime_color)//Colors.grey.shade400
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}