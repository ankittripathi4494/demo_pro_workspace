// ignore_for_file: avoid_print, must_be_immutable, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class UpdateScreenCrudDBOne extends StatefulWidget {
  late Map<String, dynamic> args;
  UpdateScreenCrudDBOne({super.key, required this.args});
  @override
  State<UpdateScreenCrudDBOne> createState() => _UpdateScreenCrudDBOneState();
}

class _UpdateScreenCrudDBOneState extends State<UpdateScreenCrudDBOne> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  String gender = "";
  String booleanResult = "";
  Map? selectedMap;
  DateTime? dob;
  List<Map> subjectList = [
    {"id": 1.toString(), "name": 'Science'},
    {"id": 2.toString(), "name": 'Math'},
    {"id": 3.toString(), "name": 'Biology'},
    {"id": 4.toString(), "name": 'Economics'}
  ];

  @override
  void initState() {
    getRecordForUser();
    super.initState();
  }

  getRecordForUser() async {
    var databasesPath = await getDatabasesPath(); //
    String dbPath = p.join(databasesPath, 'student_database.db');

    Database db = await openDatabase(dbPath);
    db.query('Student', where: "id=?", whereArgs: [widget.args['id']]).then(
        (v) {
      // setState(() {
      //   studentList = v;
      // });
      print(v.toString());
      setState(() {
        nameController.text = v.first['name'].toString();
        phoneController.text = v.first['phone'].toString();
        emailController.text = v.first['email'].toString();
        gender = v.first['gender'].toString();
        dobController.text = v.first['dob'].toString();
        
      });
      for (var vx in subjectList) {
          if (vx['name'].toString().trim().toLowerCase().compareTo(
                  v.first['subject'].toString().trim().toLowerCase()) ==
              0) {
            print("Selected :- ${vx.toString()}");
            setState(() {
              selectedMap = vx;
            });
          }
        }
    });
  }

  updateRecordInDatabase(String name, String phone, String email, String dob,
      String gender, Map<dynamic, dynamic>? subject) async {
    print("record updated");
    var databasesPath = await getDatabasesPath(); //
    String dbPath = p.join(databasesPath, 'student_database.db');

    Database db = await openDatabase(dbPath);
     db.update("Student",{
      "name": name,
      "phone": phone,
      "email": email,
      "dob": dobController.text,
      "gender": gender,
      "subject": subject!.containsKey('name') ? subject['name'] : ''
    }).then((v) {
      Navigator.pop(context);
      Navigator.pushReplacementNamed(context, '/crud1/read',
          arguments: {"title": "Student List"});
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Durations.long1,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(10),
          backgroundColor: Colors.green,
          content: Text(
            "Record insertd successfully!",
            style: TextStyle(color: Colors.white),
          )));
    }).onError((e, s) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Durations.long1,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(10),
          backgroundColor: Colors.red,
          content: Text(
            "error ${e.toString()} and $s",
            style: const TextStyle(color: Colors.white),
          )));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (widget.args.containsKey('title'))
            ? Text(widget.args['title'])
            : Container(),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Form(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                height: 60,
                child: TextFormField(
                  controller: nameController,
                  cursorColor: Colors.transparent,
                  style: const TextStyle(color: Colors.black),
                  keyboardType: TextInputType.name,
                  onChanged: (value) {},
                  decoration: const InputDecoration(
                      counterText: '',
                      prefixIcon: Icon(Icons.verified_user),
                      prefixIconColor: Colors.black,
                      labelText: "Name",
                      labelStyle: TextStyle(color: Colors.black),
                      helperText: null,
                      helperStyle: TextStyle(color: Colors.black),
                      errorText: null,
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(color: Colors.red, width: 2)),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(color: Colors.grey, width: 2)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide:
                              BorderSide(color: Colors.black, width: 2)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide:
                              BorderSide(color: Colors.black, width: 2)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide:
                              BorderSide(color: Colors.black, width: 2))),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                height: 60,
                child: TextFormField(
                  controller: emailController,
                  cursorColor: Colors.transparent,
                  style: const TextStyle(color: Colors.black),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {},
                  decoration: const InputDecoration(
                      counterText: '',
                      prefixIcon: Icon(Icons.verified_user),
                      prefixIconColor: Colors.black,
                      labelText: "Email",
                      labelStyle: TextStyle(color: Colors.black),
                      helperText: null,
                      helperStyle: TextStyle(color: Colors.black),
                      errorText: null,
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(color: Colors.red, width: 2)),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(color: Colors.grey, width: 2)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide:
                              BorderSide(color: Colors.black, width: 2)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide:
                              BorderSide(color: Colors.black, width: 2)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide:
                              BorderSide(color: Colors.black, width: 2))),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                height: 60,
                child: TextFormField(
                  controller: phoneController,
                  cursorColor: Colors.transparent,
                  style: const TextStyle(color: Colors.black),
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    // FilteringTextInputFormatter.allow('\\s')
                  ],
                  onChanged: (value) {},
                  decoration: const InputDecoration(
                      counterText: '',
                      prefixIcon: Icon(Icons.verified_user),
                      prefixIconColor: Colors.black,
                      labelText: "Phone",
                      labelStyle: TextStyle(color: Colors.black),
                      helperText: null,
                      helperStyle: TextStyle(color: Colors.black),
                      errorText: null,
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(color: Colors.red, width: 2)),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(color: Colors.grey, width: 2)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide:
                              BorderSide(color: Colors.black, width: 2)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide:
                              BorderSide(color: Colors.black, width: 2)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide:
                              BorderSide(color: Colors.black, width: 2))),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    RadioMenuButton(
                      value: "Male",
                      groupValue: gender,
                      onChanged: (value) {
                        print("Current Gender :- $value");
                        setState(() {
                          gender = value!;
                        });
                      },
                      child: const Text("Male"),
                    ),
                    RadioMenuButton(
                      value: "Female",
                      groupValue: gender,
                      onChanged: (value) {
                        print("Current Gender :- $value");
                        setState(() {
                          gender = value!;
                        });
                      },
                      child: const Text("Female"),
                    ),
                    RadioMenuButton(
                      value: "Other",
                      groupValue: gender,
                      onChanged: (value) {
                        print("Current Gender :- $value");
                        setState(() {
                          gender = value!;
                        });
                      },
                      child: const Text("Other"),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: DropdownButtonFormField<Map>(
                  value: selectedMap,
                  items: subjectList.map((v) {
                    return DropdownMenuItem(value: v, child: Text(v["name"]));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedMap = null;
                      selectedMap = value!;
                    });
                  },
                ),
              ),
              InkWell(
                onTap: () {
                  showDatePicker(
                          context: context,
                          firstDate: DateTime(DateTime.now().year,
                              DateTime.now().month, DateTime.now().day + 3),
                          lastDate: DateTime(2100))
                      .then((value) {
                    setState(() {
                      dobController.text = DateFormat('d/M/y')
                          .format(DateTime.parse(value!.toString()));
                    });
                  });
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  height: 60,
                  child: TextFormField(
                    controller: dobController,
                    cursorColor: Colors.transparent,
                    style: const TextStyle(color: Colors.black),
                    maxLength: 10,
                    enabled: false,
                    keyboardType: TextInputType.name,
                    onChanged: (value) {},
                    decoration: const InputDecoration(
                        counterText: '',
                        prefixIcon: Icon(Icons.date_range),
                        prefixIconColor: Colors.black,
                        labelText: "Date of Birth",
                        labelStyle: TextStyle(color: Colors.black),
                        helperText: null,
                        helperStyle: TextStyle(color: Colors.black),
                        errorText: null,
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide:
                                BorderSide(color: Colors.red, width: 2)),
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 2)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide:
                                BorderSide(color: Colors.black, width: 2)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide:
                                BorderSide(color: Colors.black, width: 2)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide:
                                BorderSide(color: Colors.black, width: 2))),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  if (nameController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        duration: Durations.long1,
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.all(10),
                        backgroundColor: Colors.red,
                        content: Text(
                          "Please enter student name",
                          style: TextStyle(color: Colors.white),
                        )));
                  } else if (phoneController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        duration: Durations.long1,
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.all(10),
                        backgroundColor: Colors.red,
                        content: Text(
                          "Please enter student phone number",
                          style: TextStyle(color: Colors.white),
                        )));
                  } else if (emailController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        duration: Durations.long1,
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.all(10),
                        backgroundColor: Colors.red,
                        content: Text(
                          "Please enter student email",
                          style: TextStyle(color: Colors.white),
                        )));
                  } else if ((gender.isEmpty) || (gender == "")) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        duration: Durations.long1,
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.all(10),
                        backgroundColor: Colors.red,
                        content: Text(
                          "Please select student gender",
                          style: TextStyle(color: Colors.white),
                        )));
                  } else if (selectedMap == null) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        duration: Durations.long1,
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.all(10),
                        backgroundColor: Colors.red,
                        content: Text(
                          "Please select student subject name",
                          style: TextStyle(color: Colors.white),
                        )));
                  } else if (dobController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        duration: Durations.long1,
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.all(10),
                        backgroundColor: Colors.red,
                        content: Text(
                          "Please select student date of birth",
                          style: TextStyle(color: Colors.white),
                        )));
                  } else {
                    updateRecordInDatabase(
                        nameController.text,
                        phoneController.text,
                        emailController.text,
                        dob.toString(),
                        gender,
                        selectedMap);
                  }
                },
                child: Material(
                  color: Colors.transparent,
                  elevation: 20,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: 40,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: const LinearGradient(
                              colors: [Colors.green, Colors.grey])),
                      child: const Center(
                        child: Text(
                          "Submit Data",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              )
              // ignore: unnecessary_null_comparison
            ],
          ),
        )),
      ),
    );
  }
}
