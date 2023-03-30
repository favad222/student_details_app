import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/DB/model/model_dart.dart';
import 'package:flutter_application_1/provider/provider.dart';
import 'package:flutter_application_1/widgets/add_students_list.dart';
import 'package:provider/provider.dart';

class AddStudent extends StatelessWidget {
  const AddStudent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: AddStudentsList(),
      ),
    );
  }
}

Future<void> onAddStudents(BuildContext context) async {
  final provider = Provider.of<StudentProvider>(context, listen: false);
  final name = provider.nameController.text.trim();

  final age = provider.ageController.text.trim();

  final rollNo = provider.ageController.text.trim();

  final class_ = provider.classController.text.trim();

  if (name.isEmpty || age.isEmpty || rollNo.isEmpty || class_.isEmpty) {
    return;
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        width: 150,
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        content: Text('New Data Added'),
      ),
    );
  }

  // create student model
  final provider1 = Provider.of<StudentProvider>(context, listen: false);

  final student = StudentModel(name: name, age: age, class_: class_, rollnumber: rollNo, photo: provider1.fileimage?.path);

  provider1.addStudent(student);
  provider1.fileimage = null;

  log('data added success');
}