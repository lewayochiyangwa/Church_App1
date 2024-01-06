import 'package:flutter/material.dart';
import 'package:iserve_billing/services/params_controller.dart';




import '../temp1/ui/widgets/eventscontainer.dart';
import 'package:get/get.dart';

import '../temp1/ui/widgets/sermonscontainer.dart';
class Sermons extends StatefulWidget {
  const Sermons({Key? key}) : super(key: key);

  @override
  State<Sermons> createState() => _SermonsState();
}

class _SermonsState extends State<Sermons> {
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
                      itemCount:params_controller.sermons.length,// jobList.length,
                      itemBuilder: (ctx, i) {
                        return SermonsContainer(
                          id:int.parse(params_controller.sermons[i].id),//jobList[i].id,
                            verse:params_controller.sermons[i].verse,// jobList[i].description,
                            description:params_controller.sermons[i].description,// jobList[i].location,
                          time_date: params_controller.sermons[i].time_date,//jobList[i].salary,
                          title: params_controller.sermons[i].title,//jobList[i].title,

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
