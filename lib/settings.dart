import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';




class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  late SharedPreferences logindata;

  late String username;
  late String username1="";
  late String email="";

 // final excell_controller =  Get.put<ExcellUploadController>(ExcellUploadController());

  @override
  void initState() {
    super.initState();

    initial_state();
  }

  initial_state() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      username=logindata.getString('username')!;
      username1=logindata.getString('username1')!;
      email=logindata.getString('email')!;
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      /*appBar: AppBar(
        leading: IconButton(onPressed: (){},icon: Icon(Icons.arrow_back),),
        title: Text("Settings"),
      ),*/
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.all(30),
          child: Column(
            children: [
              SizedBox(
                width: 120,height: 120,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset("assets/images/basamaoko_logo.jpg")),
              ),
              const SizedBox(height:10,),
              Text(username1,style:TextStyle(fontSize: 15)),
              Text(email,style:TextStyle(fontSize: 15)),
              const SizedBox(height:20,),
              SizedBox(
                width: 200,
                  child: ElevatedButton(
                      onPressed:()=>{},
                      child: const Text("Edit Profile"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      side: BorderSide.none,
                      shape: const StadiumBorder()
                    ),

                  ),


              ),
              const SizedBox(height: 30,),
              const Divider(color: Colors.orange,),
              const SizedBox(height: 10,),
              SettingsMenuWidget(icon:Icons.directions_walk, onPress:(){}, title:"Walks Exceptions"),
              SettingsMenuWidget(icon:Icons.upload_file, onPress:()async{

             //   excell_controller.upload_excell();

              }, title:"Upload Completes"),
              SettingsMenuWidget(icon:Icons.bug_report, onPress:(){}, title:"Report Bug"),

              const Divider(color: Colors.orange,),
              SettingsMenuWidget(icon:Icons.lock, onPress:(){}, title:"Change Password"),
              SettingsMenuWidget(icon:Icons.logout, onPress:(){}, title:"Logout")
            ],
          ),
        ),
      ),

    );
  }
}

class SettingsMenuWidget extends StatelessWidget {
  const SettingsMenuWidget({
    super.key,
    required this.icon,
    this.endIcon=true,
    required this.onPress,
    this.textColor,
    required this.title,
  });

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;



  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 30,height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.orange
        ),
        child:  Icon(icon),
      ),
      title: Text(title,style: TextStyle(fontSize: 15,color:textColor),),
      trailing: endIcon? Container(
      width: 30,height: 30,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.blue.shade50
      ),
      child: const Icon(Icons.arrow_forward_ios_outlined),
    ):null,
    );
  }
}
