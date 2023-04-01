import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/DB/model/model_dart.dart';
import 'package:flutter_application_1/provider/provider.dart';
import 'package:provider/provider.dart';

class AddStudentsList extends StatelessWidget {
  const AddStudentsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<StudentProvider>(
      builder: (context, provider, child) {
        return Form(
          key: provider.formkey,
          child: Column(
            children: [
              const SizedBox(height: 70),
              Container(
                child: provider.fileimage == null
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
                        radius: 80,
                        backgroundImage: FileImage(
                          File(provider.fileimage!.path),
                        ),
                      ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80),
                child: ElevatedButton.icon(
                    onPressed: () {
                      provider.imageFromGallery();
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Add Profile')),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: provider.nameController,
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
                      return 'Required';
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
                  keyboardType: TextInputType.number,
                  controller: provider.classController,
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
                      return 'Required';
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
                  controller: provider.ageController,
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
                      return 'Required';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLength: 10,
                  keyboardType: TextInputType.phone,
                  controller: provider.rollNoController,
                  decoration: const InputDecoration(
                    hintText: 'Mobile Number',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 2),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required';
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
                      if (provider.formkey.currentState!.validate()) {
                        onAddStudents(context);
                        Navigator.of(context).pop();
                        provider.nameController.clear();
                        provider.classController.clear();
                        provider.ageController.clear();
                        provider.rollNoController.clear();
                      }
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Add This Details'),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> onAddStudents(BuildContext context) async {
    final provider = Provider.of<StudentProvider>(context, listen: false);
    final name = provider.nameController.text.trim();

    final age = provider.ageController.text.trim();

    final rollNo = provider.rollNoController.text.trim();

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
}
