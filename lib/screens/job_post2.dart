import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:iserve_billing/services/params_controller.dart';

import '../global_constants.dart';
import 'faqs.dart';

class JobPosting2 extends StatefulWidget {
  const JobPosting2({Key? key}) : super(key: key);

  @override
  State<JobPosting2> createState() => _JobPostingState2();
}

class _JobPostingState2 extends State<JobPosting2> {

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

  // Default language selection
  String selectedLanguage = 'English';



  List data = [];
  List partime_data = [];
  List online_data = [];
  var _value =1;
  var _valuePartime =1;
  var _valueOnline =1;
  var _valueLocation=1;

  TextEditingController _trxnTypeController = TextEditingController();
  TextEditingController _textFieldController = TextEditingController();
  TextEditingController _textAmountController = TextEditingController();
  String getPollUrl="";

  // Initial Selected Value
  String dropdownvalue = 'Deposit';


  @override
  Widget build(BuildContext context) {
    final params_controller =  Get.put<ParamsController>(ParamsController());
    return  Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue.shade300,
          //
          // leading: Icon(Icons.help_outline),
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
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(15),
                    child:DropdownButtonFormField(
                      decoration: InputDecoration(
                        labelText: 'Job Type',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100.0),
                          // borderSide: BorderSide(color: Colors.blue, width: 1),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                      ),
                      value:_value,//_value !=null ? _value : null,//
                      items:params_controller.data.map((e){
                        return DropdownMenuItem(
                          // child: Text(e["username"]),
                          child: Text(e["job_name"]),
                          value:int.parse(e["id"]),);
                      }).toList(),
                      onChanged: (v){
                        // _value = v as int;
                        setState(() {
                          _value = v as int;
                          print('this is the job id'+_value.toString());
                        });
                      },
                      //isExpanded: true, //make true to take width of parent widget
                      //underline: Container(), //empty line
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      dropdownColor: Colors.white,

                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child:DropdownButtonFormField(
                      decoration: InputDecoration(
                        labelText: 'Part Time/Permanent',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100.0),
                          // borderSide: BorderSide(color: Colors.blue, width: 1),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                      ),
                      value:_valuePartime,//_value !=null ? _value : null,//
                      items:params_controller.partime_data.map((e){
                        return DropdownMenuItem(
                          // child: Text(e["username"]),
                          child: Text(e["name"]),
                          value:int.parse(e["id"]),);
                      }).toList(),
                      onChanged: (v){
                        // _value = v as int;
                        setState(() {
                          _valuePartime = v as int;
                        });
                      },
                      //isExpanded: true, //make true to take width of parent widget
                      //underline: Container(), //empty line
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      dropdownColor: Colors.white,

                    ),
                  ),
                  //job type online or
                  Padding(
                    padding: EdgeInsets.all(15),
                    child:DropdownButtonFormField(
                      decoration: InputDecoration(
                        labelText: 'Online/Onsite',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100.0),
                          // borderSide: BorderSide(color: Colors.blue, width: 1),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                      ),
                      value:_valueOnline,//_value !=null ? _value : null,//
                      items:params_controller.online_data.map((e){
                        return DropdownMenuItem(
                          // child: Text(e["username"]),
                          child: Text(e["name"]),
                          value:int.parse(e["id"]),);
                      }).toList(),
                      onChanged: (v){
                        // _value = v as int;
                        setState(() {
                          _valueOnline = v as int;
                        });
                      },
                      //isExpanded: true, //make true to take width of parent widget
                      //underline: Container(), //empty line
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      dropdownColor: Colors.white,

                    ),
                  ),
                  //location
                  Padding(
                    padding: EdgeInsets.all(15),
                    child:DropdownButtonFormField(
                      decoration: InputDecoration(
                        labelText: 'Location',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100.0),
                          // borderSide: BorderSide(color: Colors.blue, width: 1),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                      ),
                      value:_valueLocation,//_value !=null ? _value : null,//
                      items:params_controller.location_data.map((e){
                        return DropdownMenuItem(
                          // child: Text(e["username"]),
                          child: Text(e["location_name"]),
                          value:int.parse(e["id"]),);
                      }).toList(),
                      onChanged: (v){
                        // _value = v as int;
                        setState(() {
                          _valueLocation = v as int;
                        });
                      },
                      //isExpanded: true, //make true to take width of parent widget
                      //underline: Container(), //empty line
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      dropdownColor: Colors.white,

                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.all(15),
                    child:TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration:  InputDecoration(
                        labelText: 'Salary',
                        hintText: 'Salary',
                        hintStyle: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey,
                          fontFamily: "Roboto",
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          //  borderSide: BorderSide(color: Colors.blue, width: 1)
                        ),
                        /**   focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue, width: 1)),
                            enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue, width: 1)
                            ),*/
                        contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                      ),
                      controller: _textAmountController,
                      readOnly: false,
                      onTap: () async {

                      },
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a value';
                        }
                        final int? intValue = int.tryParse(value);
                        if (intValue == null) {
                          return 'Please enter value';
                        }
                        return null;
                      },

                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child:TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,

                      decoration:  InputDecoration(
                        errorStyle: TextStyle(
                          color: Colors.red,
                        ),
                        labelStyle: TextStyle(
                          fontFamily: "OpenSans",
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.black,
                        ),

                        hintText: 'Job Description',
                        hintStyle: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey,
                          fontFamily: "Roboto",
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0)

                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                      ),
                      controller: _textFieldController,
                      readOnly: false,
                      onTap: () async {
                      },
                      keyboardType: TextInputType.text,
                      maxLines: 4,
                      /*validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a phone number';
                        }
                        final RegExp phoneRegex = RegExp(r'(0)7[7-8|1|3][0-9]{7}$'); // Define the regular expression
                        if (!phoneRegex.hasMatch(value)) { // Check if the phone number matches the pattern
                          return 'Please enter a valid phone number';
                        }
                        return null;
                      },*/
                    ),
                  ),
                  ElevatedButton(
                    child: Text('Submit',
                      style:  TextStyle(
                        fontSize: 12.0,
                        color: Colors.white,
                        fontFamily: "Roboto",
                      ),

                    ),
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(150,15),
                      primary: Colors.blue,
                      //  onPrimary: Colors.white,

                      textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontStyle: FontStyle.normal),
                    ),
                    onPressed: () async{
                      print("value from amount"+_textAmountController.text.toString());
                      print("value from drop down"+_trxnTypeController.text.toString());
                      //  void pay(String id,String _valuePartime,String _valueOnline,String _value,String description,String _valueLocation,String salary)
                      pay('9',_valuePartime,_valueOnline,_value,_textFieldController.text,_valueLocation,double.parse(_textAmountController.text));
                    },
                  )
                ],
              )
          ),
        )
    )/*Scaffold(
      appBar: AppBar(),
      body: Center(
        child:Container(
          width: 300,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue),
            borderRadius: BorderRadius.circular(10),
          ),
          child: DropdownButton(
            value:_value,//_value !=null ? _value : null,//
            items:data.map((e){
              return DropdownMenuItem(
               // child: Text(e["username"]),
                child: Text(e["job_name"]),
                value:int.parse(e["id"]),);
            }).toList(),
            onChanged: (v){
             // _value = v as int;
                setState(() {
                  _value = v as int;
                });
            },
            //isExpanded: true, //make true to take width of parent widget
            underline: Container(), //empty line
            style: TextStyle(fontSize: 18, color: Colors.black),
            dropdownColor: Colors.green,

          ),
        ),
      ),
    )*/;
  }

  void pay(String id,int _valuePartime,int _valueOnline,int _value,String description,int _valueLocation,double salary)async{
    print("tapinda mu payment");
    print("_valuePartime "+_valuePartime.toString());
    print("_valueOnline"+_valueOnline.toString());
    print("_valueLocation"+_valueLocation.toString());
    // String  _phoneController = phone;

    // if(trxnType=="Deposit"){
    var url = Uri.parse('http://'+ip_address+':93/basamaoko_api/api/client/postJob');

    Map data = {
      'user_id' :78,
      'jobtypea_id' :_valuePartime,
      'jobtypeb_id' :_valueOnline,
      'jobtitle_id' :_value,
      'description' :description,
      'location':_valueLocation,
      'salary':salary,
      'jobstatus':1
    };
    //encode Map to JSON
    var body = json.encode(data);

    print("this is the body"+body);

    var response1 = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: body
    );
    print("${response1.statusCode}");
    print("${response1.body}");
    //  }



  }
}


