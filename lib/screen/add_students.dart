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


