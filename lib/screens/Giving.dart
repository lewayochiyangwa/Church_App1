import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:iserve_billing/models/response.dart';
import 'package:iserve_billing/services/params_controller.dart';
import 'package:paynow/paynow.dart';
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
  TextEditingController _textPhoneController = TextEditingController();
  TextEditingController _textAmountController = TextEditingController();
  String getPollUrl="";

  // Initial Selected Value
  String dropdownvalue = 'Deposit';
  bool paymentLoader = true;

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
                      //  print("this is the value"+e["id"].toString());
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
                        contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                      ),
                      controller: _textPhoneController,
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

                  MyElevatedButton(
                    onPressed:() async {
                    print("Give Button Clicked");
                    paymentLoader?showDataAlert():null;

                  pay(_value.toString(),_textAmountController.text,_textPhoneController.text);
                    await Future.delayed(Duration(seconds: 12~/2));
                    Navigator.of(context).pop();
                  },
                    text: "Give ", color: ThemeColor,
                    textColor: Colors.white,
                    width: 130,
                    height: 40,
                  ),
                ],
              )
          ),
        )
    );
  }

  showDataAlert() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  20.0,
                ),
              ),
            ),
          /*  contentPadding: EdgeInsets.only(
              top: 10.0,
            ),*/
         /*   title: Text(
              "Processing Giving",
              style: TextStyle(fontSize: 24.0),
            ),*/
            content:Container(
              height: 100,
              child: Container(
                height: 25,
                width: 25,
                child: Center(child: Text("Processing...")),
              ),
            ),
          );
        });
  }
  void pay(String trxnType,String amount,String phone)async{
    print("tapinda mu payment");
    print("trn Type"+trxnType.toString());
    print("amount"+trxnType.toString());
    print("phone number"+trxnType.toString());
    String  _phoneController = phone;


      Paynow paynow = Paynow(integrationKey: "cd69ebc4-3386-4ea5-bf38-0ac17bfdefbb", integrationId: "16938", returnUrl: "http://google.com", resultUrl: "http://google.co");
      Payment payment = paynow.createPayment("user", "leroy.chiyangwa1994@gmail.com");

      payment.add(trxnType,double.parse(amount));

      paynow.sendMobile(payment, _phoneController ?? phone,)
          .then((InitResponse response)async{
        // display results
        print(response());
        print("ndaakuda");
        print('------------------');
        print(response.pollUrl);
        getPollUrl = response.pollUrl;

        var url = Uri.parse(ip_address+'/church_api/api/client/give');

        Map data = {
          'type' : trxnType,
          'amount' : amount,
          'valueDate' :DateTime.now().toString(),
          'device' : 'mobile',
          'callback':getPollUrl
        };
        //encode Map to JSON
        var body = json.encode(data);

        print("this is the body"+body);

        var response1 = await http.post(url,
            headers: {"Content-Type": "application/json"},
            body: body
        );
        print("${response1}");
        print("${response1.body}");
        //   return response;
        //  }



        print('------------------');
        await Future.delayed(Duration(seconds: 20~/2));
        // Check Transaction status from pollUrl
        paynow.checkTransactionStatus(response.pollUrl)
            .then((StatusResponse status) async {
             print(status.paid);
        });
      });




  }
}


