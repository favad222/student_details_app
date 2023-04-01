import 'dart:io';
import 'package:dialogs/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/DB/model/model_dart.dart';
import 'package:flutter_application_1/provider/provider.dart';
import 'package:flutter_application_1/screen/main_screen.dart';
import 'package:provider/provider.dart';

class EditListView extends StatelessWidget {
  const EditListView({
    super.key,
    required this.name,
    required this.class_,
    required this.age,
    required this.rollno,
    required this.photo,
    required this.index,
  });

  final String name;
  final String class_;
  final String age;
  final String rollno;
  final String? photo;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Consumer<StudentProvider>(
      builder: (context, provider, _) {
        provider.enameController = TextEditingController(text: name);
        provider.eclassController = TextEditingController(text: class_);
        provider.eageController = TextEditingController(text: age);
        provider.erollNoController = TextEditingController(text: rollno);
        provider.eprofile = photo;

        return Form(
          key: provider.eformkey,
          child: SizedBox(
            width: 350,
            child: Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: provider.fileimage == null
                        ? Container(
                            height: 140,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: provider.eprofile == null
                                ? const CircleAvatar(
                                    backgroundImage: AssetImage('Assets/images/avatar (1).png'),
                                    radius: 80,
                                  )
                                : CircleAvatar(
                                    backgroundImage: FileImage(
                                      File(provider.eprofile!),
                                    ),
                                    radius: 80,
                                  ),
                          )
                        : CircleAvatar(
                            radius: 80,
                            backgroundImage: FileImage(
                              File(provider.fileimage!.path),
                            ),
                          ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      provider.imageFromGallery();
                    },
                    child: const Text('Edit profile'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: provider.enameController,
                      decoration: const InputDecoration(
                        hintText: 'Name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'required';
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
                      controller: provider.eclassController,
                      decoration: const InputDecoration(
                        hintText: 'class',
                        border: OutlineInputBorder(),
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
                      controller: provider.eageController,
                      decoration: const InputDecoration(
                        hintText: 'Age',
                        border: OutlineInputBorder(),
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
                      maxLength: 10,
                      controller: provider.erollNoController,
                      decoration: const InputDecoration(
                        hintText: 'Mobile Number',
                        border: OutlineInputBorder(),
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
                        style: const ButtonStyle(),
                        onPressed: () {
                          if (provider.eformkey.currentState!.validate()) {
                            final choice = showdialogedit(provider, index, context);
                            choice.show(context);
                          }

                          // editDialouge(context);
                        },
                        label: const Text('Confirm edit'),
                        icon: const Icon(
                          Icons.check,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  ChoiceDialog showdialogedit(StudentProvider value, int index, BuildContext context) {
    return ChoiceDialog(
      dialogBackgroundColor: Colors.white,
      buttonOkOnPressed: () {
        editSave(context, index);
        popoutfunction(context);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const MainScreen(),
            ),
            (route) => false);
      },
      title: 'Edit Student',
      titleColor: Colors.red,
      message: 'Do you Really want to Edit this Student?',
    );
  }
}

Future<void> editSave(BuildContext context, index) async {
  final provider = Provider.of<StudentProvider>(context, listen: false);
  final student = StudentModel(
    name: provider.enameController.text,
    age: provider.eageController.text,
    rollnumber: provider.erollNoController.text,
    class_: provider.eclassController.text,
    photo: provider.fileimage?.path ?? provider.eprofile,
  );

  provider.editList(index, student);
  provider.fileimage = null;
}
