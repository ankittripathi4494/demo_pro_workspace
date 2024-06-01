// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:demoproapp/global_widget/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class ReadScreenCrudDBOne extends StatefulWidget {
  late Map<String, dynamic> args;
  ReadScreenCrudDBOne({super.key, required this.args});

  @override
  State<ReadScreenCrudDBOne> createState() => _ReadScreenCrudDBOneState();
}

class _ReadScreenCrudDBOneState extends State<ReadScreenCrudDBOne> {
  List<Map<String, Object?>> studentList = [];
  @override
  void initState() {
    getStudentRecord();
    super.initState();
  }

  getStudentRecord() async {
    var databasesPath = await getDatabasesPath(); //
    String dbPath = p.join(databasesPath, 'student_database.db');

    Database db = await openDatabase(dbPath);

    db.query('Student').then((v) {
      setState(() {
        studentList = v;
      });
    });
  }

  deleteStudentRecord(int id) async {
    var databasesPath = await getDatabasesPath(); //
    String dbPath = p.join(databasesPath, 'student_database.db');

    Database db = await openDatabase(dbPath);

    db.delete('Student', where: 'id=?', whereArgs: [id]).then((v) {
      if (v > 0) {
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, '/crud1/read',
            arguments: {"title": "Student List"});
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            duration: Durations.long1,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(10),
            backgroundColor: Colors.green,
            content: Text(
              "Record deleted successfully!",
              style: TextStyle(color: Colors.white),
            )));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            duration: Durations.long1,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(10),
            backgroundColor: Colors.red,
            content: Text(
              "Cannot delete records",
              style: TextStyle(color: Colors.white),
            )));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Do You want to close the app?"),
                actions: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white),
                      onPressed: () {
                        exit(0);
                      },
                      child: const Text("Yes")),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("No")),
                ],
              );
            },
          );
        }
      },
      child: Scaffold(
          appBar: AppBar(
            title: (widget.args.containsKey('title'))
                ? Text(widget.args['title'])
                : Container(),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/crud1/read',
                        arguments: {"title": "Student List"});
                  },
                  icon: const Icon(Icons.refresh)),
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/crud1/create',
                        arguments: {"title": "Add Student"});
                  },
                  icon: const Icon(Icons.add))
            ],
          ),
          drawer: MyDrawer.getDrawer(context),
          body: ListView.builder(
            shrinkWrap: true,
            itemCount: studentList.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> student = studentList[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 5),
                child: ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, '/crud1/update', arguments: {
                      "title": "Update Student",
                      "id": student['id'].toString()
                    });
                  },
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:
                          const BorderSide(color: Colors.black, width: 2)),
                  title: Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          student["name"],
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "E-Mail :- ${student["email"]}",
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "Mobile :- ${student["phone"]}",
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          const Text(
                            "DOB",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            student["dob"]!,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Text(
                            "Subject",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            student["subject"],
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Text(
                            "Gender",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            student["gender"],
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      )
                    ],
                  ),
                  trailing: IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text(
                                  "Do You want to delete the record?"),
                              actions: [
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green,
                                        foregroundColor: Colors.white),
                                    onPressed: () {
                                      deleteStudentRecord(
                                          int.parse(student['id'].toString()));
                                    },
                                    child: const Text("Yes")),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                        foregroundColor: Colors.white),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("No")),
                              ],
                            );
                          },
                        );
                      },
                      icon: const Icon(Icons.delete)),
                ),
              );
            },
          )),
    );
  }
}
