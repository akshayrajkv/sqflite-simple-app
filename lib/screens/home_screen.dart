import 'package:flutter/material.dart';
import 'package:flutter_stu_val_hive/db/models/student_model.dart';
import 'package:flutter_stu_val_hive/functions/student_functions.dart';
import 'package:flutter_stu_val_hive/screens/list.dart';

class HomeScreen extends StatelessWidget {
  
  HomeScreen({super.key });
  TextEditingController nameController =TextEditingController();
    TextEditingController ageController =TextEditingController();

  @override
  Widget build(BuildContext context) {
    getAllStudent();
    return  Scaffold(
      appBar:AppBar(
        title:const Text('Students'),
      ) ,
      body: Padding(
        padding: const EdgeInsets.all(11.0),
        child: Column(
        
          children: [
            TextField(
              decoration:const InputDecoration(border: OutlineInputBorder(),
              hintText: 'Name'),
              controller: nameController,
            ),
        const   SizedBox(height: 10,),
            TextField(
              decoration:const InputDecoration(border: OutlineInputBorder(),hintText: 'Age'),
              controller: ageController,
            ),
            SizedBox(height: 10,),
            ElevatedButton(onPressed: (){
        onButtonClicked();
            
            }, child:const Text('Add')),
        Expanded(child: StudentList()),
          ],
        ),
      ),
    );
  }
  Future<void>onButtonClicked()async{
    final _name=nameController.text.trim();
    final _age = ageController.text.trim();
    if(_name.isEmpty||_age.isEmpty){
      return ;
    }{
      final  stud = StudentModel(name: _name, age:_age);
            addStudent(stud);
    }
    nameController.clear();
    ageController.clear();

  }
  
}
