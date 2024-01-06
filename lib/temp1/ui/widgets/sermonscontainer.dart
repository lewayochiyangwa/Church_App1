import 'package:flutter/material.dart';
import 'package:iserve_billing/global_constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:iserve_billing/models/response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
class SermonsContainer extends StatelessWidget {
  const SermonsContainer({
    Key? key,
   // required this.iconUrl,
    required this.title,
    required this.verse,
    required this.description,
    required this.time_date,
    required this.id,
  }) : super(key: key);
  final  title, verse, description,time_date;//String iconUrl,
  final int id;
 // final Function onTap;
  String formatDate(String dateString) {
    DateTime date = DateTime.parse(dateString);
    final DateFormat formatter = DateFormat('d MMM yyyy');
    final String formattedDate = formatter.format(date);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    var inputFormat = DateFormat('dd/MM/yyyy');

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
            Text(
              "$title",
            ),
            SizedBox(height: 5),
            Row(
              children: [
               // Icon(Icons.calendar_today,color: ThemeColor,),
                Icon(Icons.book_outlined,color: ThemeColor,),
                Text(
                  "$verse",
                ),
              ],
            ),
            SizedBox(height: 9),
            Container(
              width: 300,
              child: Text("$description",
                style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold,color: Colors.grey.shade400),
                softWrap: true,
              ),
            ),
            SizedBox(height: 9),
            Row(
              children: [
                Text(
                  "Date Posted: ",
                ),
                Text(
                  formatDate(time_date),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}