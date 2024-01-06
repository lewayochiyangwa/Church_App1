import 'package:flutter/material.dart';
import 'package:iserve_billing/dashboard/storageinfo.dart';
import 'chart.dart';
import 'constants.dart';


class StarageDetails extends StatelessWidget {
  const StarageDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.orange, // set the border color here
          width: 2.0, // set the border width here
        ),
        color: secondaryColor,
       // color: Colors.blue.shade300,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Walkings history",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          //SizedBox(height: defaultPadding),
          SizedBox(height: defaultPadding),
          Chart(),
          StorageInfoCard(
            // svgSrc: "assets/icons/Documents.svg",
            title: "Emaral Hill",
            amountOfFiles: "50",
            //numOfFiles: 1328,
            color2: Color(0xFF2697FF),
          ),
          StorageInfoCard(
            //   svgSrc: "assets/icons/media.svg",
            title: "Mount Pleasent",
            amountOfFiles: "30",
            //numOfFiles: 1328,
            color2:  Color(0xFF26E5FF),
          ),
          StorageInfoCard(
            // svgSrc: "assets/icons/folder.svg",
            title: "Green Croft",
            amountOfFiles: "37",
            //numOfFiles: 1328,
            color2:Color(0xFFFFCF26),
          ),
          StorageInfoCard(
            //   svgSrc: "assets/icons/unknown.svg",
            title: "Belveder",
            amountOfFiles: "47",
            //numOfFiles: 140,
            color2: Color(0xFFEE2727),
          ),
        ],
      ),
    );
  }
}
