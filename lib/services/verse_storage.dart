import 'dart:async';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
class NotesDatabase extends GetxController{

  static const String tableName = 'Notes';
  static const String columnId = 'id';
  static const String columnTitle = 'title';
  static const String columnContent = 'content';
  static const String columnModifiedTime = 'modified_time';
  var notesList = <Notes>[].obs;
  var loading = true.obs;

  @override
  void onInit() {
    super.onInit();
    retrieveNotes2() ;


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
     notesList.value = List.generate(maps.length, (i) {
      return Notes(
        id: maps[i][columnId],
        title: maps[i][columnTitle],
        content: maps[i][columnContent],
        modified_time: maps[i][columnModifiedTime],

      );
    });


    for (var note in notesList) {
      print('Note ID: ${note.id}');
      print('Title: ${note.title}');
      print('Content: ${note.content}');
      print('Modified Time: ${note.modified_time}');
      print('---');
    }
    loading.value=false;
    update();



  }

  void customInsertNotes(String title, String note,String modifydate) async {
    final db = await initializeDatabase();

   // db.rawInsert('INSERT INTO  Notes(title, content,modified_time)  VALUES($title, $note,$modifydate)');
    db.rawInsert('INSERT INTO Notes(title, content,modified_time) VALUES(?, ?,?)', [title, note,modifydate]);
  //  That would open us up to SQL injection attacks. Instead we can use data binding like this:

  //  db.rawInsert('INSERT INTO my_table(name, age) VALUES(?, ?)', [name, age]);

  }

  void customInsertTest(String title, String note,String modifydate) async {
    final db = await initializeDatabase();

    db.rawInsert('INSERT INTO Notes(title, content,modified_time) VALUES("myTitle", "myContent","myDate")');

    //  That would open us up to SQL injection attacks. Instead we can use data binding like this:

    //  db.rawInsert('INSERT INTO my_table(name, age) VALUES(?, ?)', [name, age]);

  }
  void deleteNotes(int id) async {
    final db = await initializeDatabase();
    await db.rawDelete('DELETE FROM Notes WHERE id = ?',[id],);
  /*  return db.delete(
      tableName,
      where: '$columnId = ?',
      whereArgs: [id],
    );*/
  }


  Future<void> customUpdate(int id, String title,String content) async {
    // int r = 1+id;
    print("id ichangotibata: "+id.toString());
    // print("id yachinja: "+r.toString());
    final db = await initializeDatabase();
    String sql_query = "UPDATE Notes SET title ="+"'"+title+"'"+",content ="+"'"+content+"'"+"  WHERE id ="+id.toString();
    print("kupedza nharo dze query : "+sql_query);
    int count = await db.rawUpdate(sql_query);
    print('lets check the affected : '+count.toString());
  }

}

class Notes {

  static const String columnId = 'id';
  static const String columnTitle = 'title';
  static const String columnContent = 'content';
  static const String columnModifiedTime = 'modified_time';


  final int id;
  final String title;
  final String content;
  final String  modified_time;


  Notes({
    required this.id,
    required this.title,
    required this.content,
    required this.modified_time,
  });

  Map<String, dynamic> toMap() {
    return {
      columnId: id,
      columnTitle: title,
      columnContent: content,
      columnModifiedTime:modified_time,

    };
  }
}