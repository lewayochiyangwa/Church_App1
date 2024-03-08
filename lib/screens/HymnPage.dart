import 'package:flutter/material.dart';

class HymnPage extends StatelessWidget {
  final Map<String, dynamic> hymn;

  HymnPage({required this.hymn});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(hymn['name']),
      ),
      body: ListView.builder(
        itemCount: hymn['verses'].length,
        itemBuilder: (context, index) {
          final verse = hymn['verses'][index]['content'];
          return Container(

            child: Column(
              children: [
                Container(
                  //child: Text('Verse ${index + 1}'),
                ),
                ListTile(
                  title: Row(
                    children: [
                      Text('${index + 1}'),
                      SizedBox(width: 10),
                      Text(verse),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
