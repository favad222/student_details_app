import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/DB/functions/db_functions.dart';
import 'package:flutter_application_1/DB/model/model_dart.dart';
import 'package:flutter_application_1/screen/addStudent.dart';
import 'package:flutter_application_1/screen/editStudents.dart';
import 'package:flutter_application_1/screen/fullList.dart';

class mainScreen extends StatelessWidget {
  const mainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    getAllStudents();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Students List',
          textAlign: TextAlign.center,
        ),
        actions: [
          IconButton(
            onPressed: () {
              // showSearch(
              //   context: context,
              //   delegate: SearchWidget(),
              // );
            },
            icon: const Icon(Icons.search),
            tooltip: 'open search ',
          ),
        ],
      ),
      body: SafeArea(
        // create listenable builder
        child: ValueListenableBuilder(
          valueListenable: studentList,
          builder: (BuildContext context, List<StudentModel> value, Widget? child) {
            // rebuild automatically

            return ListView.separated(
                itemBuilder: (context, index) {
                  final data = value[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => fullDetails(
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

                      // const CircleAvatar(
                      //   // backgroundImage: data.photo == null ? AssetImage('Assets/images/avatar (1).png'): File(data.photo!),

                      //   radius: 30,
                      // ),

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
                              // deleteList(index);
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: const Text(
                                          'alert!!',
                                          style: TextStyle(
                                            color: Colors.red,
                                          ),
                                        ),
                                        content: const Text('do you really want to delete this student '),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              deleteList(index);
                                              popoutfunction(context);
                                            },
                                            child: const Text(
                                              'yes',
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              popoutfunction(context);
                                            },
                                            child: const Text('No'),
                                          ),
                                        ],
                                      ));
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
                itemCount: value.length);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddStudent(),
            ),
          );
        },
        label: const Text('Add New Student'),
      ),
    );
  }

  popoutfunction(BuildContext context) {
    return Navigator.of(context).pop();
  }
}
