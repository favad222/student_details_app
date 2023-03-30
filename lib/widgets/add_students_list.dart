import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/provider.dart';
import 'package:flutter_application_1/screen/add_students.dart';
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
                            radius: 40,
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
                      maxLength: 10,
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
}