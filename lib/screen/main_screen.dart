import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/provider.dart';
import 'package:flutter_application_1/screen/add_students.dart';
import 'package:flutter_application_1/screen/search.dart';
import 'package:flutter_application_1/widgets/main_listview.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<StudentProvider>(context, listen: false).getAllStudents();
    });

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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchStudentList(),
                ),
              );
            },
            icon: const Icon(Icons.search),
            tooltip: 'open search ',
          ),
        ],
      ),
      body: const SafeArea(
        child: MainListView(),
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
}

popoutfunction(BuildContext context) {
  return Navigator.of(context).pop();
}
