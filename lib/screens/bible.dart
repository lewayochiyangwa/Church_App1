import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../global_constants.dart';
/*
class BiblePage extends StatefulWidget {
  @override
  _BiblePageState createState() => _BiblePageState();
}

class _BiblePageState extends State<BiblePage> {
  List<BiblePassage> passages = [];
  String selectedBook = 'Genesis';
  String searchText = '';
  @override
  void initState() {
    super.initState();
    loadBiblePassages();
  }

  Future<void> loadBiblePassages() async {

    String jsonStr2 = await DefaultAssetBundle.of(context).loadString("assets/images/kjv.json");

    List<dynamic> jsonList = json.decode(jsonStr2);

    List<BiblePassage> tempPassages = [];

    for (var jsonData in jsonList) {
      BiblePassage passage = BiblePassage.fromJson(jsonData);
      tempPassages.add(passage);
    }

    setState(() {
      passages = tempPassages;
    });
  }

  List<String> getBookList() {
    Set<String> bookSet = Set();
   // bookSet.add('All');
    for (var passage in passages) {
      bookSet.add(passage.book);
    }
    return bookSet.toList();
  }

  void onBookSelected(String? book) {
    setState(() {
      selectedBook = book ?? 'Genesis';
    });
  }

  List<BiblePassage> filterPassagesByBook() {
  /*  if (selectedBook == 'All') {
      return passages;
    } else {*/
      return passages.where((passage) => passage.book == selectedBook).toList();
   // }
  }

  void onSearchTextChanged(String value) {
    setState(() {
      searchText = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> bookList = getBookList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Bible Page'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: selectedBook,
              onChanged: onBookSelected,
              items: bookList.map((String book) {
                return DropdownMenuItem<String>(
                  value: book,
                  child: Text(book),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: TextField(
              onChanged: onSearchTextChanged,
              decoration: InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filterPassagesByBook().length,
              itemBuilder: (BuildContext context, int index) {
                BiblePassage passage = filterPassagesByBook()[index];
                return ListTile(
                  title: Text("["+passage.chapter+":"+passage.verse+"]"+
                    passage.text,
                    style: TextStyle(fontSize: 16),
                  ),
                 /* subtitle: Text(
                    '${passage.book} ${passage.chapter}:${passage.verse}',
                    style: TextStyle(fontSize: 12),
                  ),*/
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
*/
class BiblePage extends StatefulWidget {
  @override
  _BiblePageState createState() => _BiblePageState();
}

class _BiblePageState extends State<BiblePage> {
  List<BiblePassage> passages = [];
  String selectedBook = 'Genesis';
  String searchText = '';

  @override
  void initState() {
    super.initState();
    loadBiblePassages();
  }

  void loadBiblePassages() async {
    String jsonStr = await DefaultAssetBundle.of(context).loadString("assets/images/kjv.json");
   // String jsonStr = await rootBundle.loadString('assets/bible_passages.json');
    List<dynamic> jsonList = json.decode(jsonStr);
    List<BiblePassage> tempPassages = [];

    for (var jsonData in jsonList) {
      BiblePassage passage = BiblePassage.fromJson(jsonData);
      tempPassages.add(passage);
    }

    setState(() {
      passages = tempPassages;
    });
  }

  /*List<String> getBookList() {
    Set<String> bookSet = Set();
    bookSet.add('All');
    for (var passage in passages) {
      bookSet.add(passage.book);
    }
    return bookSet.toList();
  }*/
  List<String> getBookList() {
    List<String> bookList = ['Genesis'];
    for (var passage in passages) {
      if (!bookList.contains(passage.book)) {
        bookList.add(passage.book);
      }
    }
    return bookList;
  }

  void onBookSelected(String? book) {
    setState(() {
      selectedBook = book ?? 'All';
    });
  }

  void onSearchTextChanged(String value) {
    setState(() {
      searchText = value;
    });
  }

  List<BiblePassage> filterPassagesByBookAndSearch() {
    if (selectedBook == 'All' && searchText.isEmpty) {
      return passages;
    } else if (selectedBook == 'All') {
      return passages
          .where((passage) =>
          passage.text.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    } else if (searchText.isEmpty) {
      return passages.where((passage) => passage.book == selectedBook).toList();
    } else {
      return passages
          .where((passage) =>
      passage.book == selectedBook &&
          passage.text.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> bookList = getBookList();

    return Scaffold(
      /*appBar: AppBar(
        title: Text('Bible Page'),
      ),*/
      appBar: AppBar(
        backgroundColor: ThemeColor,
        iconTheme: IconThemeData(color:ThemeColor2),
        title: Text(
          NavTitle,style: TextStyle(fontSize:15,fontWeight: FontWeight.bold,color: ThemeColor2),


        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: onSearchTextChanged,
                    decoration: InputDecoration(
                      labelText: 'Search',
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                DropdownButton<String>(
                  value: selectedBook,
                  onChanged: onBookSelected,
                  items: bookList.map((String book) {
                    return DropdownMenuItem<String>(
                      value: book,
                      child: Text(book),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          Expanded(
            child: MediaQuery.removePadding(context: context,
              removeTop: true,
              child: ListView.builder(

                itemCount: filterPassagesByBookAndSearch().length,
                itemBuilder: (BuildContext context, int index) {
                  BiblePassage passage = filterPassagesByBookAndSearch()[index];
                  return ListTile(
                    dense:true,
                 //   dense:true,


                // contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 8
                    title: Text("["+passage.chapter+":"+passage.verse+"]"+
                      passage.text,
                      style: TextStyle(fontSize: 16),
                    ),
                    /*subtitle: Text(
                      '${passage.book} ${passage.chapter}:${passage.verse}',
                      style: TextStyle(fontSize: 12),
                    ),*/
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class BiblePassage {
  final String book;
  final String chapter;
  final String verse;
  final String text;

  BiblePassage({
    required this.book,
    required this.chapter,
    required this.verse,
    required this.text,
  });

  factory BiblePassage.fromJson(Map<String, dynamic> json) {
    return BiblePassage(
      book: json['book'],
      chapter: json['chapter'],
      verse: json['verse'],
      text: json['text'],
    );
  }
}