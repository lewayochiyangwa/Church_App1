import 'package:flutter/material.dart';
import 'package:iserve_billing/global_constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:iserve_billing/models/response.dart';
import 'package:iserve_billing/navs.dart';
import 'package:shared_preferences/shared_preferences.dart';




class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  TextEditingController _email = TextEditingController();
  TextEditingController _pass = TextEditingController();
  bool _isLoading = false;
  late SharedPreferences logindata;
  late bool newUser;


  Widget orDivider() {
    return GestureDetector(
      onTap: () {
        // Handle the onTap event here
        print('Row clicked!');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BottomNavigationExample(),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 130, vertical: 8),
        child: Row(
          children: [
            Flexible(
              child: Container(
                height: 1,
                color: kPrimaryColor,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Skip',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue,
                ),
              ),
            ),
            Flexible(
              child: Container(
                height: 1,
                color: kPrimaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void  check_if_already_login() async {
    logindata = await SharedPreferences.getInstance();
    print("ccc vs zanu2"+logindata.getBool('login').toString());
    newUser = (logindata.getBool('login')??true);
    print(newUser);

    if(newUser==false){
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BottomNavigationExample(),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    check_if_already_login();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Container(
//             color: Colors.indigo,
                child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 20,),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            CircleAvatar(
                              backgroundImage: AssetImage("assets/images/play_store_512.jpg"),
                              radius: 80.0,
                            ),
                          //  SizedBox(height: 20,),
                         //   Text("Basa Maoko", style: TextStyle(color: Colors.grey[600], fontSize: 22),),
                          ],
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(5),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.all(8.0),
                                      child:  TextField(
                                        controller: _email,
                                        decoration: InputDecoration(
                                            hintText: "Email or Phone number",
                                            hintStyle: TextStyle(
                                                color: Colors.grey[600])),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(8.0),
                                      child: TextField(
                                        controller: _pass,
                                        decoration: InputDecoration(
                                            hintText: "Password",
                                            hintStyle: TextStyle(
                                                color: Colors.grey[600])
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 10,),

                              LayoutBuilder(
                                builder: (BuildContext context, BoxConstraints constraints) {
                                  if (constraints.maxWidth < 600) {
                                    // If the maximum width is less than 600, apply small screen layout
                                    return Container(
                                      width: 150,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(primary: ThemeColor),
                                        onPressed: () async {
                                          // Handle the onTap event here
                                          print('Container clicked!');
                                          print("login button pressed");
                                          var url = Uri.parse(ip_address + login_url);
                                          var headers = {'Content-Type': 'application/json'};
                                          var body = json.encode({
                                            'email': _email.text,
                                            'password': _pass.text,
                                          });
                                          try {
                                            var response = await http.post(url, headers: headers, body: body);
                                            ////////////////////////////
                                            print("test response");
                                            print(response.body);
                                            print(response.statusCode);
                                            final Map<String, dynamic> responseData = jsonDecode(response.body);
                                            final LoginResponse loginResponse = LoginResponse.fromJson(responseData);
                                            print("you must redirect now");
                                            print("get the login response status" + loginResponse.status);

                                            if (loginResponse.status == "Ok") {
                                              logindata = await SharedPreferences.getInstance();
                                              logindata.setString("function_log_control", "granted");
                                              logindata.setBool("login", false);
                                              logindata.setInt("id", loginResponse.data[0]);
                                              print("tapinda");
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => BottomNavigationExample(),
                                                ),
                                              );
                                            } else {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
                                                  content: Text(loginResponse.message),
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
                                          } catch (e) {}
                                        },
                                        child: Text("Login"),
                                      ),
                                    );
                                  } else {
                                    // If the maximum width is 600 or more, apply large screen layout
                                    return Container(
                                      width: 300, // Adjust the width for large screens
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(primary: ThemeColor),
                                        onPressed: () async {
                                          // Handle the onTap event here
                                          print('Container clicked!');
                                          print("login button pressed");
                                          var url = Uri.parse(ip_address + login_url);
                                          var headers = {'Content-Type': 'application/json'};
                                          var body = json.encode({
                                            'email': _email.text,
                                            'password': _pass.text,
                                          });
                                          try {
                                            var response = await http.post(url, headers: headers, body: body);
                                            ////////////////////////////
                                            print("test response");
                                            print(response.body);
                                            print(response.statusCode);
                                            final Map<String, dynamic> responseData = jsonDecode(response.body);
                                            final LoginResponse loginResponse = LoginResponse.fromJson(responseData);
                                            print("you must redirect now");
                                            print("get the login response status" + loginResponse.status);

                                            if (loginResponse.status == "Ok") {
                                              logindata = await SharedPreferences.getInstance();
                                              logindata.setString("function_log_control", "granted");
                                              logindata.setBool("login", false);
                                              logindata.setInt("id", loginResponse.data[0]);
                                              print("tapinda");
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => BottomNavigationExample(),
                                                ),
                                              );
                                            } else {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
                                                  content: Text(loginResponse.message),
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
                                          } catch (e) {}
                                        },
                                        child: Text("Login"),
                                      ),
                                    );
                                  }
                                },
                              ),
                              SizedBox(height: 15,),
                              orDivider(),
                              SizedBox(height: 5,),
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      'Does not have an account?',
                                      style: TextStyle(color: Colors.grey[600]),
                                    ),
                                    SizedBox(width: 15),
                                    GestureDetector(
                                      onTap: () {
                                        // Handle the onTap event here
                                        print('Login clicked!');
                                      },
                                      child: Text(
                                        "Sign Up",
                                        style: TextStyle(
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ),
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.center,
                                ),
                              )
                            ],
                          )
                      )
                    ]
                )
            ),
          ),
        )
    );
  }
}
