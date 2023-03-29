import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/DB/functions/db_functions.dart';
import 'package:flutter_application_1/DB/model/model_dart.dart';
import 'package:image_picker/image_picker.dart';

class EditStudent extends StatefulWidget {
  final String name;

  final String class_;

  final String age;

  final String rollno;

  final int index;

  final String? photo;

  const EditStudent({
    super.key,
    required this.name,
    required this.class_,
    required this.age,
    required this.rollno,
    required this.index,
    required this.photo,
  });

  @override
  State<EditStudent> createState() => _EditStudentState();
}

class _EditStudentState extends State<EditStudent> {
  TextEditingController nameOfStudent = TextEditingController();

  TextEditingController classOfStudent = TextEditingController();

  TextEditingController ageOfStudent = TextEditingController();

  TextEditingController rollNoOfStudent = TextEditingController();

  String? profile;

  @override
  void initState() {
    super.initState();

    nameOfStudent = TextEditingController(text: widget.name);

    classOfStudent = TextEditingController(text: widget.class_);

    ageOfStudent = TextEditingController(text: widget.age);

    rollNoOfStudent = TextEditingController(text: widget.rollno);

    profile = widget.photo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Edit Student'),
      ),
      body: SafeArea(
        child: SizedBox(
          width: 350,
          child: Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // profile == null
                //     ? const CircleAvatar(
                //         backgroundImage: AssetImage('Assets/images/avatar (1).png'),
                //         radius: 80,
                //       )
                //     : CircleAvatar(
                //         backgroundImage: FileImage(
                //           File(profile!),
                //         ),
                //         radius: 80,
                //       ),

                Container(
                  child: fileimage == null
                      ? Container(
                          height: 140,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: profile == null
                              ? const CircleAvatar(
                                  backgroundImage: AssetImage('Assets/images/avatar (1).png'),
                                  radius: 80,
                                )
                              : CircleAvatar(
                                  backgroundImage: FileImage(
                                    File(profile!),
                                  ),
                                  radius: 80,
                                ),
                        )
                      : CircleAvatar(
                          radius: 40,
                          backgroundImage: FileImage(
                            File(fileimage!.path),
                          ),
                        ),
                ),

                ElevatedButton(
                  onPressed: () {
                    _imageFromGallery();
                  },
                  child: const Text('Edit profile'),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: nameOfStudent,
                    decoration: const InputDecoration(
                      hintText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: classOfStudent,
                    decoration: const InputDecoration(
                      hintText: 'class',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    maxLength: 3,
                    controller: ageOfStudent,
                    decoration: const InputDecoration(
                      hintText: 'Age',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    maxLength: 3,
                    controller: rollNoOfStudent,
                    decoration: const InputDecoration(
                      hintText: 'roll no',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: SizedBox(
                    height: 40,
                    child: ElevatedButton.icon(
                      style: const ButtonStyle(),
                      onPressed: () {
                        EditSave();
                        editDialouge();

                        Navigator.of(context).pop();
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
      ),
    );
  }

  Future<void> EditSave() async {
    final student = StudentModel(
      name: nameOfStudent.text,
      age: ageOfStudent.text,
      rollnumber: rollNoOfStudent.text,
      class_: classOfStudent.text,
      photo: fileimage?.path ?? profile,
    );

    editList(widget.index, student);
    print('edited');
  }

  editDialouge() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.lightGreen,
        content: Text('data updated'),
      ),
    );
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
