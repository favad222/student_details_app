import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/DB/model/model_dart.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';

class StudentProvider extends ChangeNotifier {
  List<StudentModel> studentList = [];
  List<StudentModel> foundeddata = [];

  File? fileimage;
  File? efileimage;

  // add students controllers

  TextEditingController nameController = TextEditingController();

  TextEditingController ageController = TextEditingController();

  TextEditingController classController = TextEditingController();

  TextEditingController rollNoController = TextEditingController();

  final formkey = GlobalKey<FormState>();
  String? profile;

  // edit students controllers

  TextEditingController enameController = TextEditingController();

  TextEditingController eageController = TextEditingController();

  TextEditingController eclassController = TextEditingController();

  TextEditingController erollNoController = TextEditingController();

  final eformkey = GlobalKey<FormState>();
  String? eprofile;

  Future<void> imageFromGallery() async {
    final photo = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (photo == null) {
      return;
    } else {
      final photoTemp = File(photo.path);

      fileimage = photoTemp;
    }

    notifyListeners();
  }

  Future<void> edtiImageFromGallery() async {
    final photo = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (photo == null) {
      return;
    } else {
      final photoTemp = File(photo.path);

      efileimage = photoTemp;
    }

    notifyListeners();
  }

  Future<void> addStudent(StudentModel value) async {
    // open box
    final studentsDB = await Hive.openBox<StudentModel>('students_db');

    final id = await studentsDB.add(value);

    value.id = id;

    studentList.add(value);

    notifyListeners();
    getAllStudents();
  }

  Future<void> getAllStudents() async {
    final studentsDB = await Hive.openBox<StudentModel>('students_db');

    studentList.clear();

    studentList.addAll(studentsDB.values);

    notifyListeners();
  }

  Future<void> deleteList(int index) async {
    final studentsDB = await Hive.openBox<StudentModel>('students_db');

    await studentsDB.deleteAt(index);

    getAllStudents();
    notifyListeners();
  }

  Future<void> editList(int index, StudentModel student) async {
    final studentDb = await Hive.openBox<StudentModel>('students_db');
    studentDb.putAt(index, student);
    getAllStudents();
    notifyListeners();
  }

  List<StudentModel> alldata = [];

  Future<void> searchResults() async {
    alldata = studentList;

    foundeddata = alldata;
    notifyListeners();
  }

  void updateList(String enteredText) {
    List<StudentModel> results = [];
    if (enteredText.isEmpty) {
      results = alldata;
    } else {
      results = studentList
          .where(
            (element) => element.name.toLowerCase().trim().contains(enteredText..toLowerCase()),
          )
          .toList();
    }

    foundeddata = results;
    log(foundeddata.toString());
    notifyListeners();
  }
}
