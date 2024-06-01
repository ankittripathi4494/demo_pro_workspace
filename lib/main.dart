import 'package:demoproapp/router_class_page.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  // Get a location using getDatabasesPath
  var databasesPath = await getDatabasesPath(); //
  String dbPath = p.join(databasesPath, 'student_database.db');

 try {
   openDatabase(
    dbPath,
    version: 1,
    onCreate: (db, version) async {
      // part calls when db create on source location of device
      await db.execute(
          'CREATE TABLE Student (id INTEGER PRIMARY KEY, name TEXT, phone TEXT, email TEXT, gender TEXT, subject TEXT, dob TEXT)');
    },
  ).then((value){
    print("Database created  with table student");

    print("Database Path := ${dbPath.toString()}");
  });
 } catch (e) {
   print(e.toString());
 }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: RouterClass.generateRouter,
    );
  }
}
