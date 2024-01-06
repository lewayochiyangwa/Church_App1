import 'package:flutter/material.dart';


import 'constants.dart';


class StorageInfoCard extends StatelessWidget {
  const StorageInfoCard({
    Key? key,
    required this.title,
    // required this.svgSrc,
    required this.amountOfFiles,
    // required this.numOfFiles,
    required this.color2,
  }) : super(key: key);

  final String title, amountOfFiles;
  // final int numOfFiles;
  final Color color2;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: defaultPadding),
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: primaryColor.withOpacity(0.15)),
        borderRadius: const BorderRadius.all(
          Radius.circular(defaultPadding),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          /** SizedBox(
              height: 10,
              width: 10,
              child: SvgPicture.asset(svgSrc),
              ),*/
         /** Container(
            // height: 50,
              width: 20,
              child: Image.asset("assets/images/econet_mobile_525090174.png")
          ),*/
          // SizedBox(width: 10,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 12,color:color2
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                /*Text(
                  "$numOfFiles Files",
                  style: TextStyle(
                      fontSize: 12
                  ),
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(color: Colors.white70),
                ),*/
              ],
            ),
          ),
          //  SizedBox(width: 30,),
          Flexible(child: Text(amountOfFiles,
            style: TextStyle(
                fontSize: 12
            ),)),
          // SizedBox(width: 30,),
          Flexible(child: Text('1 jan 2023',
            style: TextStyle(
                fontSize: 12
            ),)),
        ],
      ),
    );
  }
}
