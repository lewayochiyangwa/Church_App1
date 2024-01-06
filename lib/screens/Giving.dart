import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:iserve_billing/models/response.dart';
import 'package:iserve_billing/services/params_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../global_constants.dart';
import '../temp1/ui/widgets/MyElevatedButtton.dart';

class Giving extends StatefulWidget {
  const Giving({Key? key}) : super(key: key);

  @override
  State<Giving> createState() => _GivingState();
}

class _GivingState extends State<Giving> {
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
      /*  appBar: AppBar(
          title: Text('Flutter TextField Example'),
        ),*/
        body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(15),
                    child:Text("No Goods Or Services  Provided \n In Exchange Of Donation. "),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child:DropdownButtonFormField(
                      decoration: InputDecoration(
                        labelText: 'Donation Type',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100.0),
                         //  borderSide: BorderSide(color: Colors.red, width: 1),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                      ),
                      value:_value,//_value !=null ? _value : null,//
                      items:params_controller.location_data.map((e){
                        print("this is the value"+e["id"].toString());
                        return DropdownMenuItem(
                          // child: Text(e["username"]),
                          child: Text(e["type"]),
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
                    child:TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration:  InputDecoration(
                        labelText: 'Donation Amount',
                        hintText: 'Donation Amount',
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
                        labelText: 'Ecocash  Phone',
                        hintText: 'Ecocash  Phone',
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

                 /* ElevatedButton(
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
                  )*/
                  MyElevatedButton(onPressed:(){
                    print("Give Button Clicked");
                  },
                    text: "Give ", color: Colors.red.shade900,
                    textColor: Colors.white,
                    width: 130,
                    height: 40,
                  ),
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
    SharedPreferences logindata = await SharedPreferences.getInstance();

    var userId=logindata.getInt('id')!;

    if(logindata.getString('function_log_control')=="granted"){

      var url = Uri.parse('http://'+ip_address+'/basamaoko_api/api/client/postJob');

      Map data = {
        'user_id' :userId,
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
      final Map<String, dynamic> responseData = jsonDecode(response1.body);
      final LoginResponse loginResponse = LoginResponse.fromJson(responseData);
      print("you must redirect now");
      print(loginResponse.status=="Ok");
      print("get the login response status"+loginResponse.status);
      if(loginResponse.status=="Ok"){
        print("how far");
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Message'),
                content: Text(loginResponse.message),
                actions: <Widget>[
                  TextButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );}
        );

      }else if(loginResponse.status=="Error"){
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Message'),
                content: Text(loginResponse.message),
                actions: <Widget>[
                  TextButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );}
        );
      }else{
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Message'),
                content: Text("Something Went Wrong Contact Admin"),
                actions: <Widget>[
                  TextButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );}
        );
      }

    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Login First To Request For A worker"),
          duration: Duration(seconds: 4),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.red, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }




  }
}


