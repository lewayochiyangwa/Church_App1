import 'package:flutter/material.dart';

import 'HymnPage.dart';

class HymnHomePage extends StatelessWidget {
  final List<Map<String, dynamic>> hymnData = [
    {
      "number": "Eb",
      "name": "NDINOSHAMISWA KWAZVO",
      "verses": [
        {
          "content":"NDINOSHAMISWA kwazvo \n Namabasa makuru \n Akaitiwa newe \n Ose anorumbidza \n "
              "Ukuru hwenyu Mwari \n Hunoshamisa kwazvo"
        },
        {
          "content":"Kana ndarangarira \n Mabasa okudenga \n Kana ndarangarira \n Mabasa apanyika \n Inobuda misodzi \n Kana ndafunga iwe",
        }
        ,
        {
          "content":"Mwari vatatu mumwe \n Itai kuti tikude \n Nokuti wakatida \n Wakazotipa Jesu \n Watipa mweya wako \n Wokutipupurira",
        },
        {
          "content":"Rumbidza iwe denga! \n Rumbidza iwe nyika! \n Rumbidza iwe gungwa! \n Nesu ngatirumbidze! \n Uyu musiki wedu \n Ane rudo rukuru",
        }



      ]
    },

    {
      "number": 7,
      "name": "MWEYA WANGU UNA M'PONESI",
      "verses": [
        {
          "content":"Mweya wangu una M'ponesi \n Wauri kupiwa \n Ddafanira kusarudza zvino \n Ndichagamuchira su \n "
              "Ndoda ndoda ndoda \n Mwari muyamuri muri wangu \n Ndakatengwa neropa raIshe \n Ndava wenyu chose."
        },
        {
          "content":"Nengoni ndichagam’chira tsitsi \n Rudo rwenyu Kristu \n Rwaukunda mwoyo wangu kwazvo \n TNdichavimba nemi"
        },
        {
          "content":"Munoziva kusasimba kwangu \n Ndotya kurasika \n Asi imi muri simba rangu \n Munondipa simba"
        },
        {
          "content":"Hongu, Ishe, tipei isu tose \n Ngoni dzenyu nhasi \n Nezvinobva mumwoyo tichiti \n Ndichava waKristu"
        },
        {
          "content":"Vakauya vamwe vachibvunza \n Tingapone here? \n Hongu, ndinoda muponiswewo \n Nesu tinodaro"
        },
      ]
    },
    {
      "number":8,
      "name": "WAKASIKA ZVOSE",
      "verses": [
        {
          "content":"Makasika zvose zvinhu \n Imi Mwari moga \n Pasina wakuyamurai \n Kuzviita kwenyu \n "
        },
        {
          "content":"Aya makomo amire \n Akasikwa nemi \n Akamira akasimba \n Nokutsigwa nemi \n "
        },
        {
          "content":"Nayo mvura yatinonwa \n Takapiwa nemi \n Nako kudya kwatinodya \n Takapiwa nemi \n "
        },
        {
          "content":"Makasika vanhu imi \n Nokufana nemi \n Mukavapa zvinhu zvose \n zvikavakodzera \n "
        },
        {
          "content":"Nhasi vose vanotenda \n Nezvi zvipo zvenyu \n Tipei mwoyo inokudai \n Sokutida kwenyu  \n "
        },

      ]
    },

    {
      "number": 25,
      "name": "MWARI MURI ZUVA REDU-G",
      "verses": [
        {
          "content":"Mwari muri zuva redu\nMunopenya pauzuru\nMunovhenekera mweya\nMunotiratidza nzira"
        },
        {
          "content":"Mwari muri nhowo yedu \n Hatidzitye mhandu dzedu \n Dzose dzinokundwa nemi \n Tigofamba nokufara"
        },
        {
          "content":"Munotipa ngoni dzenyu \n Munotipawo utsvene \n Munopa vanonamata \n Izvo zvinokomborera"
        },
        {
          "content":"Rukomborero rukuru \n Rukomborero rwedenga \n Kuna vanovimba nemi \n Vanoziva rudo rwenyu"
        },
      ]
    },

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hymn App'),
      ),
      body: ListView.builder(
        itemCount: hymnData.length,
        itemBuilder: (context, index) {
          final hymn = hymnData[index];
          return Card(
            child: ListTile(
              title: Column(
                children: [
                  Text('${hymn['number']}'),
                  Text(hymn['name']),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HymnPage(hymn: hymn),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}