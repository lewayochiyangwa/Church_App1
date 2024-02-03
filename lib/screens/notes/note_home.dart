import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../../global_constants.dart';
import '../../services/verse_storage.dart';
import 'colors.dart';
import 'edit.dart';
import 'note.dart';


class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  List<Note> filteredNotes2 = [];
  List<Notes> filteredNotes = [];
  bool sorted = false;

  final database = NotesDatabase();


  @override
  void initState() {
    super.initState();

   // test();

  }

 Future<void> test () async {
    final List<Notes> notes = await  database.retrieveNotes2();
    filteredNotes = notes;
    for (var note in notes) {
      print('Note ID: ${note.id}');
      print('Title: ${note.title}');
      print('Content: ${note.content}');
      print('Modified Time: ${note.modified_time}');
      print('---');
    }
  }

 /* List<Note> sortNotesByModifiedTime(List<Note> notes) {
    if (sorted) {
      notes.sort((a, b) => a.modifiedTime.compareTo(b.modifiedTime));
    } else {
      notes.sort((b, a) => a.modifiedTime.compareTo(b.modifiedTime));
    }

    sorted = !sorted;

    return notes;
  }*/

  getRandomColor() {
    Random random = Random();
    return backgroundColors[random.nextInt(backgroundColors.length)];
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

  void deleteNote(int index) {
    setState(() {
      Notes note = filteredNotes[index];
      sampleNotes.remove(note);
      filteredNotes.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final notes_controller =  Get.put<NotesDatabase>(NotesDatabase());

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
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 30),
                  itemCount: notes_controller.notesList.length,//filteredNotes.length,
                  itemBuilder: (context, index) {
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
                                    EditScreen(note: notes_controller.notesList[index]),
                                  //  EditScreen(note: filteredNotes[index]),
                              ),
                            );
                        if (result != null) {
                              setState(() {
                                int originalIndex =
                                filteredNotes.indexOf(filteredNotes[index]);

                                filteredNotes[originalIndex] = Notes(
                                    id: sampleNotes[originalIndex].id,
                                    title: result[0],
                                    content: result[1],
                                    modified_time: DateTime.now().toString());

                                filteredNotes[index] = Notes(
                                    id: filteredNotes[index].id,
                                    title: result[0],
                                    content: result[1],
                                    modified_time: DateTime.now().toString());
                              });
                            }
                          },
                          title: RichText(
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                                text: '${notes_controller.notesList[index].title} \n',
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    height: 1.5),
                                children: [
                                  TextSpan(
                                    text: notes_controller.notesList[index].content,
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
                              notes_controller.notesList[index].modified_time,
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
                                database.deleteNotes(index);
                               // print("this is the id========"+notes_controller.notesList[index].id.toString());
                               // print("this is the idw========"+index.toString());
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
                ))
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
              notes_controller.notesList.add(Notes(
                  id: notes_controller.notesList.length,
                  title: result[0],
                  content: result[1],
                  modified_time: DateTime.now().toString()));
              notes_controller.notesList = notes_controller.notesList;
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