import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


late List<String> imgList = [
  'https://charleswayo.s3.amazonaws.com/bible_story_images/1.png',
  'https://charleswayo.s3.amazonaws.com/bible_story_images/2.png',
  'https://charleswayo.s3.amazonaws.com/bible_story_images/3.png',
  'https://charleswayo.s3.amazonaws.com/bible_story_images/4.png'
];
//void main() => runApp(CarouselDemo());

final themeMode = ValueNotifier(2);



final List<Widget> imageSliders = imgList
    .map((item) => Container(
  child: Container(
    margin: EdgeInsets.all(5.0),
    child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Stack(
          children: <Widget>[
            Image.network(item, fit: BoxFit.cover, width: 1000.0),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(200, 0, 0, 0),
                      Color.fromARGB(0, 0, 0, 0)
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                padding: EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
                child: Text(
                  'No. ${imgList.indexOf(item)} image',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        )),
  ),
))
    .toList();



class ManuallyControlledSlider extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ManuallyControlledSliderState();
  }
}

class _ManuallyControlledSliderState extends State<ManuallyControlledSlider> {
  final CarouselController _controller = CarouselController();

  @override
  void initState() {
    super.initState();
  }
  late SharedPreferences control_slider;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          CarouselSlider(
            items: imageSliders,
            options: CarouselOptions(
              enlargeCenterPage: true,
              height: 400, // Increase the height here
            ),
            carouselController: _controller,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
           /*   Flexible(
                child: ElevatedButton(
                  onPressed: () => _controller.previousPage(),
                  child: Text('←'),
                ),
              ),
              Flexible(
                child: ElevatedButton(
                  onPressed: () => _controller.nextPage(),
                  child: Text('→'),
                ),
              ),*/
              ...Iterable<int>.generate(imgList.length).map(
                    (int pageIndex) => Flexible(
                  child: ElevatedButton(
                    onPressed: () async {
                      control_slider = await SharedPreferences.getInstance();

                      _controller.animateToPage(pageIndex);
                      control_slider.setInt("pageVal",pageIndex);
                    },
                    child: Text((pageIndex + 1).toString()),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}





