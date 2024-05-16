import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../model/person_model.dart';

class PersonProvider extends ChangeNotifier {
  TimeOfDay? time;
  DateTime? date;

  bool? isProfile;

  bool isTheme = false;

  void showProfile(isProfile) {
    this.isProfile = isProfile;
    notifyListeners();
  }


  List<PersonModel> personList = [];

  void personContact(String name, String number, String chat,File? image,DateTime date,TimeOfDay time) {
    personList.add(PersonModel(name: name, number: number, chat: chat,image: image,date: date,time: time));
    notifyListeners();
  }

  void setTime(TimeOfDay time) {
    this.time = time;
    notifyListeners();
  }


  void setDate(DateTime date) {
    this.date = date;
    notifyListeners();
  }
  set setTheme(value) {
    isTheme = value;
    notifyListeners();
  }

  String? imagePath;

  void setImage(String path) {
    imagePath = path;
    notifyListeners();
  }
  void setProfile(String name, String chat) {
    name = name;
    chat = chat;
  }
  void clearImage() {
    imagePath = null;
    notifyListeners();
  }

  TextEditingController NameController = TextEditingController();
  TextEditingController BioController = TextEditingController();

  TextEditingController editName = TextEditingController();
  TextEditingController editNumber = TextEditingController();
  TextEditingController editChat = TextEditingController();
  File? editImage;
  var editDate;
  var editTime;
  int? editIndex;

  editCamera() async {
    var pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      editImage = File(pickedFile.path);
    }
    notifyListeners();
  }
  addContactData(PersonModel Data) {
    personList.add(Data);
    notifyListeners();
  }

  editContactData(PersonModel Data, index) {
    personList[index] = (Data);
    notifyListeners();
  }

  deleteContactData(index) {
    personList.removeAt(index);
    notifyListeners();
  }
}
