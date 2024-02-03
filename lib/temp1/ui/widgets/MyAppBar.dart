

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../global_constants.dart';
import '../../../screens/faqs.dart';

class MyAppBar extends StatefulWidget {
 // const Footer({Key? key}) : super(key: key);
   MyAppBar({
    Key? key
   /*required this.height,
    required this.thickness,
    required this.color,
    required this.indent,
    required this.endIndent,*/


  }) : super(key: key);

  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
 /* final double height;
  final double thickness;

  final Color color;
  final double indent;
  final double endIndent;*/
  final List<String> languages = ['English', 'Spanish', 'French', 'German'];

  Map<String, String> myMap = {
    'en': 'US',
    'sn': 'ZW',
  };

  Map<String, String> languageMap = {
    'en': 'English',
    'sn': 'Shona'

  };

  String selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return  AppBar(
      backgroundColor:ThemeColor ,//Colors.red.shade900
      //

      actions: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [

              Text('Privacy'),
              SizedBox(width: 15,),
              InkWell(
                child: Icon(Icons.help_outline),
                onTap:(){

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>FaqPage()),// Settings()),
                  );
                },
              ),
              PopupMenuButton<String>(
                onSelected: (String result) {
                  setState(() {
                    var locale;
                    selectedLanguage = result;
                    print("is this"+selectedLanguage.toString());
                    if(selectedLanguage.toString()=="en")
                      locale  = Locale('en','US');

                    /* if(selectedLanguage.toString()=="hi")
                           locale = Locale('hi','IN');*/

                    if(selectedLanguage.toString()=="sn")
                      locale = Locale('sn','ZW');
                    Get.updateLocale(locale);
                  });
                },
                itemBuilder: (BuildContext context) {
                  return languageMap.keys.map((String key) {
                    return PopupMenuItem<String>(
                      value: key,
                      child: Text(languageMap[key]!),
                    );
                  }).toList();
                },
              ),
            ],
          ),
        )
      ],
      title: Text(
        NavTitle,style: TextStyle(fontSize:15,fontWeight: FontWeight.bold,color: Colors.white),


      ),
    );
  }
}