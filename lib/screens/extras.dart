import 'package:flutter/material.dart';
import 'package:iserve_billing/screens/pricing.dart';

class Extras extends StatefulWidget {
  @override
  State<Extras> createState() => _ExtrasState();
}

class _ExtrasState extends State<Extras> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Container(color: Colors.white54,
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),

                const SizedBox(
                  height: 15,
                ),
               const SizedBox(
                  height: 15,
                ),
                Container(
                  child: Expanded(
                      child: ListView(
                        children: [
                          InkWell(
                            child: Card(
                              margin:
                              const EdgeInsets.only(left: 35, right: 35, bottom: 10),
                              color: Colors.white70,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              child: const ListTile(
                                leading: Icon(
                                  Icons.privacy_tip_sharp,
                                  color: Colors.lightBlueAccent,
                                ),
                                title: Text(
                                  'Upgrade To Premium',
                                  style: TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: Colors.lightBlueAccent,
                                ),
                              ),
                            ),
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PricingPlatform(),
                                ),
                              );

                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Card(
                            color: Colors.white70,
                            margin:
                            const EdgeInsets.only(left: 35, right: 35, bottom: 10),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            child: const ListTile(
                              leading: Icon(
                                Icons.history,
                                color: Colors.lightBlueAccent,
                              ),
                              title: Text(
                                'View My Job Posts',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              trailing: Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: Colors.lightBlueAccent,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Card(
                            color: Colors.white70,
                            margin:
                            const EdgeInsets.only(left: 35, right: 35, bottom: 10),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            child: const ListTile(
                              leading:
                              Icon(Icons.help_outline, color: Colors.lightBlueAccent),
                              title: Text(
                                'Loans',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              trailing: Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: Colors.lightBlueAccent,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Card(
                            color: Colors.white70,
                            margin:
                            const EdgeInsets.only(left: 35, right: 35, bottom: 10),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            child: const ListTile(
                              leading: Icon(
                                Icons.privacy_tip_sharp,
                                color: Colors.lightBlueAccent,
                              ),
                              title: Text(
                                'Join WhatsApp Group',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              trailing: Icon(Icons.arrow_forward_ios_outlined,color: Colors.lightBlueAccent,),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Card(
                            color: Colors.white70,
                            margin:
                            const EdgeInsets.only(left: 35, right: 35, bottom: 10),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            child: const ListTile(
                              leading: Icon(
                                Icons.add_reaction_sharp,
                                color:Colors.lightBlueAccent,
                              ),
                              title: Text(
                                'Help & Support',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              trailing: Icon(
                                Icons.arrow_forward_ios_outlined,
                                color:Colors.lightBlueAccent,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Card(
                            color: Colors.white70,
                            margin:
                            const EdgeInsets.only(left: 35, right: 35, bottom: 10),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            child: const ListTile(
                              leading: Icon(
                                Icons.logout,
                                color: Colors.red,
                              ),
                              title: Text(
                                'Logout',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              trailing: Icon(Icons.arrow_forward_ios_outlined,color: Colors.red,),
                            ),
                          )
                        ],
                      )),
                )
              ],
            ),
          ),
        ));
  }
}