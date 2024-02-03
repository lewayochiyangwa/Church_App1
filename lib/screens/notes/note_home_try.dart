import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../global_constants.dart';
import '../../services/verse_storage.dart';
import 'colors.dart';
import 'edit.dart';
import 'note.dart';


class NoteScreenTry extends StatefulWidget {
  const NoteScreenTry({super.key});

  @override
  State<NoteScreenTry> createState() => _NoteScreenTryState();
}

class _NoteScreenTryState extends State<NoteScreenTry> {
  List<Note> filteredNotes2 = [];
 List<Notes> filteredNotes = [];
  bool sorted = false;
  static const String tableName = 'Notes';
  static const String columnId = 'id';
  static const String columnTitle = 'title';
  static const String columnContent = 'content';
  static const String columnModifiedTime = 'modified_time';

  final database = NotesDatabase();



  @override
  void initState() {
    super.initState();

    retrieveNotes2();
   // test();

  }

  Future<Database> initializeDatabase() async {
    final String path = join(await getDatabasesPath(), 'Notes.db');
    print("this is the path"+path);
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          '''
            CREATE TABLE $tableName (
              $columnId INTEGER PRIMARY KEY,
              $columnTitle TEXT,
              $columnContent TEXT,
              $columnModifiedTime TEXT
            )
            ''',
        );
      },
    );
  }

  Future<int> insertNotes(Notes notes) async {
    final db = await initializeDatabase();

    return db.insert(
      tableName,
      notes.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  retrieveNotes2() async {
    final db = await initializeDatabase();
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    setState(() {
      filteredNotes = List.generate(maps.length, (i) {
        return Notes(
          id: maps[i][columnId],
          title: maps[i][columnTitle],
          content: maps[i][columnContent],
          modified_time: maps[i][columnModifiedTime],

        );
      });
    });
    return List.generate(maps.length, (i) {
      return Notes(
        id: maps[i][columnId],
        title: maps[i][columnTitle],
        content: maps[i][columnContent],
        modified_time: maps[i][columnModifiedTime],

      );
    });
  }

 customUpdate(int id, String title,String content) async {
    // int r = 1+id;
    print("id ichangotibata: "+id.toString());
    // print("id yachinja: "+r.toString());
    final db = await initializeDatabase();
    String sql_query = "UPDATE Notes SET title ="+"'"+title+"'"+",content ="+"'"+content+"'"+"  WHERE id ="+id.toString();
    print("kupedza nharo dze query : "+sql_query);
    int count = await db.rawUpdate(sql_query);
    print('lets check the affected : '+count.toString());
  }

  void deleteNotes(int id) async {
    final db = await initializeDatabase();
    await db.rawDelete('DELETE FROM Notes WHERE id = ?',[id],);

  }
  void onSearchTextChanged(String searchText) {
    setState(() {
      filteredNotes = filteredNotes
          .where((note) =>
      note.content.toLowerCase().contains(searchText.toLowerCase()) ||
          note.title.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    });
  }

  List<Note> sortNotesByModifiedTime(List<Note> notes) {
    if (sorted) {
      notes.sort((a, b) => a.modifiedTime.compareTo(b.modifiedTime));
    } else {
      notes.sort((b, a) => a.modifiedTime.compareTo(b.modifiedTime));
    }

    sorted = !sorted;

    return notes;
  }

 getRandomColor() {
    Random random = Random();
    return backgroundColors[random.nextInt(backgroundColors.length)];
  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColor,
        title: Text(
          NavTitle,style: TextStyle(fontSize:15,fontWeight: FontWeight.bold,color: Colors.white),


        ),
      ),
      //backgroundColor: Colors.grey.shade900,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Notes',
                  style: TextStyle(fontSize: 30, color:ThemeColor),
                ),
IconButton(
                    onPressed: () {
                      retrieveNotes2();
                    },
                    padding: const EdgeInsets.all(0),
                    icon: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color:ThemeColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Icon(
                        Icons.refresh,
                        color: Colors.white,
                      ),
                    ))


              ],
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: onSearchTextChanged,
              style: const TextStyle(fontSize: 16, color: Colors.white),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                hintText: "Search notes...",
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                fillColor: Colors.grey.shade800,
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Expanded(
           //     notes_controller.loading.value == true ? Center(child: CircularProgressIndicator(),) :
              child: ListView.builder(
                itemCount:filteredNotes.length,// jobList.length,
                itemBuilder: (ctx, index) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: 20),
                     color: getRandomColor(),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListTile(
                        onTap: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  EditScreen(note: filteredNotes[index]),
                              //  EditScreen(note: filteredNotes[index]),
                            ),
                          );

                        },
                        title: RichText(
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                              text: '${filteredNotes[index].title} \n',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  height: 1.5),
                              children: [
                                TextSpan(
                                  text: filteredNotes[index].content,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14,
                                      height: 1.5),
                                )
                              ]),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            filteredNotes[index].modified_time,
                            style: TextStyle(
                                fontSize: 10,
                                fontStyle: FontStyle.italic,
                                color: Colors.grey.shade800),
                          ),
                        ),
                        trailing: IconButton(
                          onPressed: () async {
                            final result = await confirmDialog(context);
                            if (result != null && result) {
                              //   deleteNote(index);
                             deleteNotes(filteredNotes[index].id);
                             retrieveNotes2();

                            }
                          },
                          icon: const Icon(
                            Icons.delete,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const EditScreen(),
            ),
          );

          if (result != null) {
            setState(() {
              filteredNotes.add(Notes(
                  id: filteredNotes.length,
                  title: result[0],
                  content: result[1],
                  modified_time: DateTime.now().toString()));
              filteredNotes = filteredNotes;
            });
          }
        },
        elevation: 10,
        backgroundColor:ThemeColor,
        child: const Icon(
          Icons.add,
          size: 38,
          color:Colors.grey //Colors.grey.shade800 ,
        ),
      ),

    );
  }

  Future<dynamic> confirmDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.grey.shade900,
            icon: const Icon(
              Icons.info,
              color: Colors.grey,
            ),
            title: const Text(
              'Are you sure you want to delete?',
              style: TextStyle(color: Colors.white),
            ),
            content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green),
                      child: const SizedBox(
                        width: 60,
                        child: Text(
                          'Yes',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                      style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: const SizedBox(
                        width: 60,
                        child: Text(
                          'No',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                ]),
          );
        });
  }
}