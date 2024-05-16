import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../controller/main_provider.dart';
import '../controller/person_provider.dart';

class Personpage extends StatefulWidget {
  final int? index;

  Personpage({Key? key, this.index}) : super(key: key);

  @override
  State<Personpage> createState() => _PersonpageState();
}

class _PersonpageState extends State<Personpage> {
  TextEditingController name = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController chat = TextEditingController();
  GlobalKey<FormState> fKey = GlobalKey<FormState>();
  File? image;
  DateTime? date;
  String? formatedDate;
  TimeOfDay? time;
  DateTime? datepicker;
  String? formateTime;

  String formatTimeOfDay(TimeOfDay timeOfDay) {
    final hour = timeOfDay.hour.toString().padLeft(2, '0');
    final minute = timeOfDay.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.index != null) {
      var person = Provider.of<PersonProvider>(context, listen: false)
          .personList[widget.index!];
      name.text = person.name ?? "";
      number.text = person.number ?? "";
      chat.text = person.chat ?? "";
      image = person.image;
    }
  }

  @override
  Widget build(BuildContext context) {
    var isAndroid = Provider.of<MainProvider>(context, listen: false).isAndroid;
    final editprovider = Provider.of<PersonProvider>(context, listen: true);

    if (!isAndroid) {
      return Scaffold(
        body: Form(
          key: fKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 30),
                InkWell(
                  onTap: _pickImageFromCamera,
                  child: CircleAvatar(
                    minRadius: 70,
                    child: image != null ? null : Icon(Icons.camera_alt),
                    backgroundImage: image != null ? FileImage(image!) : null,
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextFormField(
                    controller: name,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person_outline),
                      hintText: "Full Name",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your full name';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextFormField(
                    controller: number,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone),
                      hintText: "Phone Number",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextFormField(
                    controller: chat,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.chat),
                      hintText: "Chat Conversation",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a chat conversation';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 15),
                InkWell(
                  onTap: () async {
                    date = await showDatePicker(
                        context: context,
                        firstDate: DateTime(1990),
                        lastDate: DateTime(3000),
                        initialDate: DateTime.now());
                    if (date != null) {
                      setState(() {
                        formatedDate = DateFormat('dd/MM/yyyy').format(date!);
                      });
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 11.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.date_range_outlined,
                          size: 26,
                        ),
                        SizedBox(
                          width: 14,
                        ),
                        (formatedDate == null)
                            ? Text(
                                'Pick Date',
                                style: TextStyle(fontSize: 16),
                              )
                            : Text(
                                formatedDate!,
                                style: TextStyle(fontSize: 16),
                              ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    time = await showTimePicker(
                        context: context, initialTime: TimeOfDay.now());
                    if (time != null) {
                      datepicker = DateTime(
                          DateTime.now().year,
                          DateTime.now().month,
                          DateTime.now().day,
                          time!.hour,
                          time!.minute);
                      setState(() {
                        formateTime = DateFormat('HH:mm').format(datepicker!);
                      });
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 11.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 26,
                        ),
                        SizedBox(
                          width: 14,
                        ),
                        (formateTime == null)
                            ? Text('Pick Time', style: TextStyle(fontSize: 16))
                            : Text(formateTime!,
                                style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.purpleAccent),
                  ),
                  child: Center(
                    child: InkWell(
                      onTap: () {
                        if (fKey.currentState!.validate()) {
                          Provider.of<PersonProvider>(context, listen: false)
                              .personContact(
                            name.text,
                            number.text,
                            chat.text,
                            image,
                            date!,
                            time!,
                          );

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Profile saved successfully'),
                            ),
                          );
                          name.clear();
                          number.clear();
                          chat.clear();
                          setState(() {
                            image = null;
                            formatedDate = null;
                            formateTime = null;
                          });
                        }
                      },
                      child: Text("Save"),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    } else {
      return Form(
        key: fKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 100, left: 20, right: 20),
            child: Column(
              children: [
                GestureDetector(
                  onTap: _pickImageFromCamera,
                  child: CircleAvatar(
                    minRadius: 70,
                    child: image != null ? null : Icon(Icons.camera_alt),
                    backgroundImage: image != null ? FileImage(image!) : null,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                CupertinoTextFormFieldRow(
                  controller: name,
                  padding: EdgeInsets.zero,
                  prefix: Icon(
                    Icons.person_outline_outlined,
                    size: 30,
                  ),
                  placeholder: 'Enter Full Name',
                  keyboardType: TextInputType.text,
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 1,
                          color: (editprovider.isTheme == true)
                              ? Colors.black38
                              : Colors.white38),
                      borderRadius: BorderRadiusDirectional.circular(6)),
                ),
                SizedBox(
                  height: 15,
                ),
                CupertinoTextFormFieldRow(
                  controller: number,
                  padding: EdgeInsets.zero,
                  prefix: Icon(
                    CupertinoIcons.phone,
                    size: 30,
                  ),
                  placeholder: 'Enter Phone Number',
                  keyboardType: TextInputType.number,
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 1,
                          color: (editprovider.isTheme == true)
                              ? Colors.black38
                              : Colors.white38),
                      borderRadius: BorderRadiusDirectional.circular(6)),
                ),
                SizedBox(
                  height: 15,
                ),
                CupertinoTextFormFieldRow(
                  controller: chat,
                  padding: EdgeInsets.zero,
                  prefix: Icon(
                    CupertinoIcons.chat_bubble_text,
                    size: 30,
                  ),
                  placeholder: 'Enter Chat Conversation',
                  keyboardType: TextInputType.text,
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 1,
                          color: (editprovider.isTheme == true)
                              ? Colors.black38
                              : Colors.white38),
                      borderRadius: BorderRadiusDirectional.circular(6)),
                ),
                SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (context) {
                        return Container(
                          height: 300,
                          color: Colors.white,
                          child: CupertinoDatePicker(
                            onDateTimeChanged: (DateTime value) {
                              setState(() {
                                date = value;
                              });
                            },
                            mode: CupertinoDatePickerMode.date,
                            use24hFormat: false,
                            initialDateTime: DateTime.now(),
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    child: Row(
                      children: [
                        Icon(
                          CupertinoIcons.calendar,
                          size: 30,
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        date != null
                            ? Text(DateFormat('dd/MM/yyyy').format(date!))
                            : Text('Pick Date')
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (context) {
                        return Container(
                          height: 300,
                          color: Colors.white,
                          child: CupertinoTimerPicker(
                            onTimerDurationChanged: (Duration value) {
                              setState(() {
                                time = TimeOfDay(
                                    hour: value.inHours,
                                    minute: value.inMinutes % 60);
                              });
                            },
                            mode: CupertinoTimerPickerMode.hm,
                          ),
                        );
                      },
                    );
                  },
                  child: Row(
                    children: [
                      Icon(
                        CupertinoIcons.time,
                        size: 30,
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      time != null
                          ? Text(formatTimeOfDay(time!))
                          : Text('Pick Time')
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                CupertinoButton(
                  onPressed: () {
                    if(image!=null)
                    if (fKey.currentState!.validate()) {
                      Provider.of<PersonProvider>(context, listen: false)
                          .personContact(
                        name.text,
                        number.text,
                        chat.text,
                        image,
                        date!,
                        time!,
                      );

                      showCupertinoDialog(
                        context: context,
                        builder: (context) {
                          return CupertinoAlertDialog(
                            title: Text('Success'),
                            content: Text('Profile saved successfully'),
                            actions: [
                              CupertinoDialogAction(
                                child: Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                      name.clear();
                      number.clear();
                      chat.clear();
                      setState(() {
                        image = null;
                        date = null;
                        time = null;
                      });
                    }
                  },
                  color: Colors.blue,
                  child: Text('SAVE'),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  Future<void> _pickImageFromCamera() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
      });
    }
  }
}
