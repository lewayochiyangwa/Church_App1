import 'package:flutter/material.dart';
import 'package:iserve_billing/drawer.dart';
import 'package:iserve_billing/services/params_controller.dart';


import '../temp1/ui/widgets/eventscontainer.dart';
import 'package:get/get.dart';
class Events extends StatefulWidget {
  const Events({Key? key}) : super(key: key);

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
  final params_controller =  Get.put<ParamsController>(ParamsController());
  //final job = jobs[index];
  //params_controller.jobs.v
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            bottom:0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 7.0,
                  ),


                  SizedBox(
                    height: 11,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount:params_controller.events.length,// jobList.length,
                      itemBuilder: (ctx, i) {
                        return EventsContainer(
                          id:int.parse(params_controller.events[i].ID),//jobList[i].id,
                          description:params_controller.events[i].description,// jobList[i].description,
                          //iconUrl: jobList[i].iconUrl,
                          location:params_controller.events[i].location,// jobList[i].location,
                          fromTime: params_controller.events[i].fromTime,//jobList[i].salary,
                          toTime: params_controller.events[i].toTime,//jobList[i].salary,
                          title: params_controller.events[i].title,//jobList[i].title,
                          onTap: () {}
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          /*  Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: 60,
              child: MyBottomNavBar(),
            ),*/
          /* Provider.of<MyBottomSheetModel>(context).visible
                ? Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    // height: MediaQuery.of(context).size.height / 1.3,
                    child: MyBottomSheet(),
                  )
                : MyBottomSheet(),*///Container(),
          //MyBottomSheet(),
        ],
      ),
    );
  }
}
