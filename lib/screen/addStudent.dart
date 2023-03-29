import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/DB/functions/db_functions.dart';
import 'package:flutter_application_1/DB/model/model_dart.dart';

import 'package:image_picker/image_picker.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({super.key});

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  final nameController = TextEditingController();

  final ageController = TextEditingController();

  final classController = TextEditingController();

  final rollNoController = TextEditingController();

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Column(
            children: [
              const SizedBox(height: 70),
              Container(
                child: fileimage == null
                    ? Container(
                        height: 140,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage('Assets/images/avatar (1).png'),
                          ),
                        ),
                      )
                    : CircleAvatar(
                        radius: 40,
                        backgroundImage: FileImage(
                          File(fileimage!.path),
                        ),
                      ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80),
                child: ElevatedButton.icon(
                    onPressed: () {
                      _imageFromGallery();
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Add Profile')),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    hintText: 'Name',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 2),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required Name';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLength: 2,
                  controller: classController,
                  decoration: const InputDecoration(
                    hintText: 'class',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 2),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required Name';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  maxLength: 2,
                  controller: ageController,
                  decoration: const InputDecoration(
                    hintText: 'Age',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 2),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required Name';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLength: 4,
                  controller: rollNoController,
                  decoration: const InputDecoration(
                    hintText: 'roll no',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 2),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required Name';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: SizedBox(
                  height: 40,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // onAddStudents();

                      if (formkey.currentState!.validate()) {
                        onAddStudents();
                        Navigator.of(context).pop();
                      }
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Add This Details'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onAddStudents() async {
    final name = nameController.text.trim();

    final age = ageController.text.trim();

    final rollNo = rollNoController.text.trim();

    final class_ = classController.text.trim();

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

    final student = StudentModel(name: name, age: age, class_: class_, rollnumber: rollNo, photo: fileimage?.path);

    print('${student.photo}');

    addStudent(student);
    log('data added success');
  }

  File? fileimage;

  Future<void> _imageFromGallery() async {
    final photo = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (photo == null) {
      return;
    } else {
      final photoTemp = File(photo.path);

      setState(
        () {
          fileimage = photoTemp;
        },
      );
    }
  }
}
