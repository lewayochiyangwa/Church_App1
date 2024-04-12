import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:http/http.dart' as http;
import 'package:iserve_billing/models/response.dart';
import 'package:iserve_billing/services/params_controller.dart';
import 'package:paynow/paynow.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../global_constants.dart';
import '../temp1/ui/widgets/MyElevatedButtton.dart';

class PrayerRequest extends StatefulWidget {
  const PrayerRequest({Key? key}) : super(key: key);

  @override
  State<PrayerRequest> createState() => _PrayerRequestState();
}

class _PrayerRequestState extends State<PrayerRequest> {
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


  InterstitialAd? _interstitialAd;


  final String _adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/1033173712'
      : 'ca-app-pub-3940256099942544/4411468910';

@override
  void initState() {


}
  @override
  Widget build(BuildContext context) {
    final params_controller =  Get.put<ParamsController>(ParamsController());
    return  Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: ThemeColor2),
          backgroundColor: ThemeColor,
          title: Text(
            NavTitle,style: TextStyle(fontSize:15,fontWeight: FontWeight.bold,color:ThemeColor2),

          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10),
                    child:Text("No weapon formed against you shall prosper, And every tongue which rises against you in judgment You shall condemn. "
                        "This is the heritage of the servants of the Lord, And their righteousness is from Me,” Says the Lord.",
                      style: TextStyle(fontSize: 10, color: Colors.black),
                    )
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child:DropdownButtonFormField(
                      decoration: InputDecoration(
                        labelText: 'Request Type',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100.0),
                         //  borderSide: BorderSide(color: Colors.red, width: 1),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                      ),
                      value:_value,//_value !=null ? _value : null,//
                      items:params_controller.prayer_data.map((e){
                      //  print("this is the value"+e["id"].toString());
                        return DropdownMenuItem(
                          // child: Text(e["username"]),
                          child: Text(e["prayer_type"]),
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
                    child:TextField(
                      maxLines: 8,
                      //autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration:  InputDecoration(
                        labelText: 'Description',
                        hintText: 'Description',
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
                   /*   validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a value';
                        }
                        final int? intValue = int.tryParse(value);
                        if (intValue == null) {
                          return 'Please enter value';
                        }
                        return null;
                      },*/

                    ),
                  ),


                  MyElevatedButton(
                    onPressed:(){
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Request Sent'),
                              //  content: Text("Log In To Upload Your Work"),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('ok'),
                                  onPressed:() async {
                                      Navigator.of(context).pop();
                                      _interstitialAd?.show();
                                  },
                                ),

                              ],
                            );
                          }
                      );
                    print("Give Button Clicked");
                //    pay(_value.toString(),_textAmountController.text,_textPhoneController.text);
                  },
                    text: "Prayer Request ", color: ThemeColor,
                    textColor: Colors.white,
                    width: 160,
                    height: 40,
                  ),
                ],
              )
          ),
        )
    );
  }

  void pay(String trxnType,String amount,String phone)async{
    print("tapinda mu payment");
    print("trn Type"+trxnType.toString());
    print("amount"+trxnType.toString());
    print("phone number"+trxnType.toString());
    String  _phoneController = phone;


      Paynow paynow = Paynow(integrationKey: "960ad10a-fc0c-403b-af14-e9520a50fbf4", integrationId: "6054", returnUrl: "http://google.com", resultUrl: "http://google.co");
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

        var url = Uri.parse('http://'+ip_address+'/ChurchAPI/api/authurhuggins/post_give.php');

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
        print("${response1.statusCode}");
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


