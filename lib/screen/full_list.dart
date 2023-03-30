import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/full_details_listview.dart';

class FullDetails extends StatelessWidget {
  final String name;
  final String class_;

  final String age;

  final String rollno;

  final String? photo;

  const FullDetails({
    super.key,
    required this.name,
    required this.age,
    required this.class_,
    required this.rollno,
    required this.photo,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white54,
      appBar: AppBar(
        title: const Text('Full Details'),
      ),
      body: FullDetailsListView(
        photo: photo,
        name: name,
        class_: class_,
        age: age,
        rollno: rollno,
      ),
    );
  }
}
