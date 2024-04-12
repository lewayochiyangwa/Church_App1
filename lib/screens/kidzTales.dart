import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class FullscreenSliderDemo extends StatelessWidget {
  late List<String> imgList2 = [
    'https://charleswayo.s3.amazonaws.com/bible_story_images/1.png',
    'https://charleswayo.s3.amazonaws.com/bible_story_images/2.png',
    'https://charleswayo.s3.amazonaws.com/bible_story_images/3.png',
    'https://charleswayo.s3.amazonaws.com/bible_story_images/4.png'
  ];

  late List<String> imgList = [
    'assets/images/1.jpg',
    'assets/images/2.jpg',
    'assets/images/3.jpg',
    'assets/images/4.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Fullscreen sliding carousel demo')),
      body: Builder(
        builder: (context) {
          final double screenHeight = MediaQuery.of(context).size.height;
          final double height = screenHeight * 0.75;
          return CarouselSlider(
            options: CarouselOptions(
              height: height,
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              // autoPlay: false,
            ),
            items: imgList
                .map((item) => Container(
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Center(

                        child:Image.asset(
                          item,
                          fit: BoxFit.cover,
                          height: height,
                        ) /*Image.network(
                          item,
                          fit: BoxFit.cover,
                          height: height,
                        )*/
                    ),
                  ),
                  Container(
                  //  height:10 ,
                    child: Text(
                      'Page. ${(imgList.indexOf(item) + 1)}',
                      style: TextStyle(fontSize:16.0),
                    )
                  )
                ],
              ),
            ))
                .toList(),
          );
        },
      ),
    );
  }
}