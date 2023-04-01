import 'package:flutter/material.dart';
import 'package:flutter_application_1/DB/model/model_dart.dart';
import 'package:flutter_application_1/provider/provider.dart';
import 'package:flutter_application_1/widgets/edit_list_view.dart';
import 'package:provider/provider.dart';

class EditStudent extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Edit Student'),
      ),
      body: SafeArea(
        child: EditListView(
          name: name,
          class_: class_,
          age: age,
          rollno: rollno,
          photo: photo,
          index: index,
        ),
      ),
    );
  }
}


