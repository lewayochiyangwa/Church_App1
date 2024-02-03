import 'package:flutter/material.dart';
import 'package:iserve_billing/global_constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:iserve_billing/models/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventsContainer extends StatelessWidget {
  const EventsContainer({
    Key? key,
   // required this.iconUrl,
    required this.title,
    required this.description,
    required this.fromTime,
    required this.toTime,
    required this.location,
    required this.onTap,
    required this.id,
  }) : super(key: key);
  final  title, fromTime, toTime, location,description;//String iconUrl,
  final int id;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:(){},
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(9.0),
          boxShadow: [
            BoxShadow(
                color: Colors.grey, blurRadius: 5.0, offset: Offset(0, 3))
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
               /* ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child:ClipRRect(child: Image.asset(logo,width: 80,height: 80,))
                ),*/
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(
                        child: Text(
                          "$title",
                            style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: ThemeColor)
                        ),
                      ),
                      SizedBox(height: 10,),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              "Time :",
                              style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.grey.shade400)
                          ),
                          SizedBox(width: 10,),
                          Text(
                            "$fromTime",
                              style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.grey.shade400)
                          ),
                          SizedBox(width: 10,),
                          Text(
                              "-",
                              style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.grey.shade400)
                          ),
                          SizedBox(width: 10,),
                          Text(
                            "$toTime",
                              style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.grey.shade400)
                          ),

                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 5),
            Text(
              "$description",
            ),
            SizedBox(height: 9),
            Row(
              children: [
                Icon(Icons.location_on,color: ThemeColor,),
                SizedBox(width: 10,),
                Text("$location",
                    style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.grey.shade400)
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}