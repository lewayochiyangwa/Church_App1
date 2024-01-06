import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iserve_billing/screens/Sermons.dart';
import 'package:iserve_billing/screens/extras.dart';
import 'package:iserve_billing/screens/faqs.dart';

import 'package:iserve_billing/screens/Giving.dart';
import 'package:iserve_billing/screens/Events.dart';
import 'package:iserve_billing/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';



import 'dashboard/home2.dart';

import 'drawer.dart';
import 'global_constants.dart';


class BottomNavigationExample extends StatefulWidget {
  const BottomNavigationExample({Key? key}) : super(key: key);

  @override
  _BottomNavigationExampleState createState() =>
      _BottomNavigationExampleState();
}

class _BottomNavigationExampleState extends State {
  int _selectedTab = 0;

  List _pages = [
    DashboardScreen(),// Home(),
    Events(),
    //DashboardScreen2(),
    Giving(),
    Sermons(),

  ];

  _changeTab(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  // List of available languages
  final List<String> languages = ['English', 'Spanish', 'French', 'German'];

  Map<String, String> myMap = {
    'en': 'US',
    'sn': 'ZW',
  };
  Map<String, String> languageMap = {
    'en': 'English',
    'sn': 'Shona'

  };

@override
 initState() {
    // TODO: implement initState
  userfunction_log_control();
    super.initState();
  }

 void userfunction_log_control() async {
    SharedPreferences logindata = await SharedPreferences.getInstance();
    logindata.getString("function_log_control");
    print("this is it the null we want"+logindata.getString("function_log_control").toString());
}
  // Default language selection
  String selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.shade900,
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
                        MaterialPageRoute(builder: (context) => FaqPage()),// Settings()),
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
      ),
     /** appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),*/
      drawer: DrawerClass(),
      body: _pages[_selectedTab],
      bottomNavigationBar: BottomNavigationBar(
        //backgroundColor: Colors.red,
        currentIndex: _selectedTab,
        onTap: (index) => _changeTab(index),
        selectedItemColor:ThemeColor,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.work), label: "Events"),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle,), label: "Give"),
          BottomNavigationBarItem(
              icon: Icon(Icons.location_on_sharp), label: "Sermons"),
          /*BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: "Extras"),*/
        ],
      ),
    );
  }
}