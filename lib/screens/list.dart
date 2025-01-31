import 'package:flutter/material.dart';
import 'package:flutter_stu_val_hive/db/models/student_model.dart';
import 'package:flutter_stu_val_hive/functions/student_functions.dart';

class StudentList extends StatelessWidget {
  StudentList({super.key});
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: students,
      builder: (context, value, child) {
        return ListView.builder(
          itemCount: value.length,
          itemBuilder: (context, index) {
            final student = value[index];
            return ListTile(
                title: Text(student.name),
                subtitle: Text(student.age),
                trailing: Container(
                  width: 100,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                            
                        _editDetails(student, student.id!, context);
                        },
                        icon: const Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () {
                          deleteStudent(student.id!);
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      )
                    ],
                  ),
                ));
          },
        );
      },
    );
  }
  void _editDetails(StudentModel student, int id,BuildContext context) async {
    nameController.text =student.name;
    ageController.text=student.age;
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit details'),
          content: Container(
            height: 200,
            child: Column(
              children: [
                TextField(
                controller: nameController,
                  decoration: InputDecoration(hintText: 'name'),
                ),
                TextField(
                 controller: ageController,
                  decoration: InputDecoration(hintText: 'age'),
                ),
              
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              
              },
              child: const Text('cancel'),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () async {
              student.name=nameController.text;
              student.age=ageController.text;
              await updateStudent(student.name,student.age, id);
              getAllStudent();
              Navigator.pop(context);
                              },
                child: const Text('save')),
          ],
        );
      },
    );
  }


}
