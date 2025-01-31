import 'package:flutter/material.dart';
import 'package:flutter_stu_val_hive/db/models/student_model.dart';
import 'package:sqflite/sqflite.dart';

ValueNotifier<List<StudentModel>> students = ValueNotifier([]);
late Database _db;
Future<void> initializeDataBase() async {
  _db = await openDatabase(
    'student.db',
    version: 1,
    onCreate: (db, version) async {
      await db.execute(
          'CREATE TABLE student (id INTEGER PRIMARY KEY,name TEXT,age TEXT)');
    },
  );
}

Future<void> addStudent(StudentModel value) async {
  await _db.rawInsert(
      'INSERT INTO student(name,age)VALUES (?,?)', [value.name, value.age]);
  getAllStudent();
}

Future<void> getAllStudent() async {
  final _values = await _db.rawQuery('SELECT * FROM student');
  students.value.clear();

  _values.forEach((map) {
    final student = StudentModel.fromMap(map);
    students.value.add(student);
    students.notifyListeners();
  });
}

deleteStudent(int id) async {
  _db.rawDelete('DELETE FROM student WHERE id = ?', [id]);
  students.notifyListeners();
  getAllStudent();
}

updateStudent(String name, String age, int id) async {
  _db.rawUpdate(
      'UPDATE student SET name =?,age =? WHERE id =?', [name, age, id]);
  getAllStudent();
}
