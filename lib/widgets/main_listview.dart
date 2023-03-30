import 'dart:io';
import 'package:dialogs/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/provider.dart';
import 'package:flutter_application_1/screen/edit_students.dart';
import 'package:flutter_application_1/screen/full_list.dart';
import 'package:flutter_application_1/screen/main_screen.dart';
import 'package:provider/provider.dart';

class MainListView extends StatelessWidget {
  const MainListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<StudentProvider>(
      builder: (BuildContext context, value, Widget? child) {
        // rebuild automatically

        return ListView.separated(
            itemBuilder: (context, index) {
              final data = value.studentList[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FullDetails(
                          name: data.name,
                          age: data.age,
                          class_: data.class_,
                          rollno: data.rollnumber,
                          photo: data.photo,
                        ),
                      ),
                    );
                  },
                  title: Text(data.name.toUpperCase(), style: const TextStyle(fontSize: 15)),
                  leading: data.photo == null
                      ? const CircleAvatar(
                          backgroundImage: AssetImage('Assets/images/avatar (1).png'),
                          radius: 30,
                        )
                      : CircleAvatar(
                          backgroundImage: FileImage(
                            File(data.photo!),
                          ),
                          radius: 30,
                        ),
                  trailing: Wrap(
                    spacing: 14,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return EditStudent(
                                  name: data.name,
                                  class_: data.class_,
                                  age: data.age,
                                  rollno: data.rollnumber,
                                  index: index,
                                  photo: data.photo,
                                );
                              },
                            ),
                          );
                        },
                        icon: const Icon(Icons.edit),
                        color: Colors.blue,
                      ),
                      IconButton(
                        onPressed: () {
                          final choice = showdialog(value, index, context);
                          choice.show(context);
                          // ChoiceDialog().show(context, barrierColor: Colors.black, barrierDismissible: true);
                        },
                        icon: const Icon(Icons.delete),
                        color: Colors.red,
                      )
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => const Divider(),
            itemCount: value.studentList.length);
      },
    );
  }

  
}

ChoiceDialog showdialog(StudentProvider value, int index, BuildContext context) {
    return ChoiceDialog(
      dialogBackgroundColor: Colors.white,
      buttonOkOnPressed: () {
        value.deleteList(index);
        popoutfunction(context);
      },
      title: 'Delete Student',
      titleColor: Colors.red,
      message: 'Do you Really want to Delete this Student?',
    );
  }
