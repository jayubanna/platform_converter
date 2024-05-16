import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:platform_converter/controller/person_provider.dart';
import 'package:provider/provider.dart';

import '../controller/main_provider.dart';
import '../model/person_model.dart';

class Chatpage extends StatefulWidget {
  const Chatpage({Key? key}) : super(key: key);

  @override
  State<Chatpage> createState() => _ChatpageState();
}

class _ChatpageState extends State<Chatpage> {
  DateTime? date;
  DateTime? datepicker;
  String? formatedDate;
  String? formateTime;
  TimeOfDay? time;
  TimeOfDay? iosTime;
  DateTime? iosDate;

  String formatTime(TimeOfDay timeOfDay) {
    final String hour = timeOfDay.hour.toString().padLeft(2, '0');
    final String minute = timeOfDay.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  @override
  Widget build(BuildContext context) {
    var isAndroid = Provider.of<MainProvider>(context, listen: false).isAndroid;
    final editprovider = Provider.of<PersonProvider>(context, listen: true);

    if (!isAndroid) {
      return Scaffold(
        body: Consumer<PersonProvider>(
          builder: (BuildContext context, PersonProvider value, Widget? child) {
            return (value.personList.isEmpty)
                ? Center(
                    child: Text("No any chats yet..."),
                  )
                : ListView.builder(
                    itemCount: value.personList.length,
                    itemBuilder: (context, index) {
                      PersonModel person = value.personList[index];
                      return ListTile(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Container(
                                height: 320,
                                width: double.infinity,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    CircleAvatar(
                                      radius: 60,
                                      child: person.image != null
                                          ? null
                                          : Text(
                                              person.name != null &&
                                                      person.name!.isNotEmpty
                                                  ? person.name![0]
                                                      .toUpperCase()
                                                  : "",
                                            ),
                                      backgroundImage: person.image != null
                                          ? FileImage(person.image!)
                                          : null,
                                    ),
                                    Text(editprovider.personList[index].name!),
                                    Text(editprovider.personList[index].chat!),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 130),
                                          child: IconButton(
                                            onPressed: () {
                                              editprovider.editName.text =
                                                  person.name!;
                                              editprovider.editNumber.text =
                                                  person.number!;
                                              editprovider.editChat.text =
                                                  person.chat!;
                                              editprovider.editImage =
                                                  person.image;
                                              editprovider.editDate =
                                                  DateFormat('dd/MM/yyyy')
                                                      .format(person.date);
                                              editprovider.editTime =
                                                  person.time.format(context);

                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return SingleChildScrollView(
                                                    child: AlertDialog(
                                                      content: Column(
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              editprovider
                                                                  .editCamera();
                                                            },
                                                            child: CircleAvatar(
                                                              radius: 60,
                                                              backgroundImage: (editprovider
                                                                          .editImage !=
                                                                      null)
                                                                  ? FileImage(
                                                                      editprovider
                                                                          .editImage!)
                                                                  : null,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          TextFormField(
                                                            controller:
                                                                editprovider
                                                                    .editName,
                                                            decoration:
                                                                InputDecoration(
                                                              prefixIcon: Icon(Icons
                                                                  .person_outline_rounded),
                                                              labelText:
                                                                  'Enter Full Name',
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  style:
                                                                      BorderStyle
                                                                          .solid,
                                                                  color: Colors
                                                                      .black,
                                                                  width: 4,
                                                                ),
                                                              ),
                                                              suffixIcon: editprovider
                                                                      .editName
                                                                      .text
                                                                      .isNotEmpty
                                                                  ? IconButton(
                                                                      onPressed:
                                                                          () {
                                                                        editprovider
                                                                            .editName
                                                                            .clear();
                                                                      },
                                                                      icon: Icon(
                                                                          Icons
                                                                              .clear),
                                                                    )
                                                                  : null,
                                                            ),
                                                            keyboardType:
                                                                TextInputType
                                                                    .text,
                                                          ),
                                                          SizedBox(
                                                            height: 15,
                                                          ),
                                                          TextFormField(
                                                            controller:
                                                                editprovider
                                                                    .editNumber,
                                                            decoration:
                                                                InputDecoration(
                                                              prefixIcon: Icon(
                                                                  Icons.call),
                                                              labelText:
                                                                  'Enter Phone Number',
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  style:
                                                                      BorderStyle
                                                                          .solid,
                                                                  color: Colors
                                                                      .black,
                                                                  width: 4,
                                                                ),
                                                              ),
                                                              suffixIcon: editprovider
                                                                      .editNumber
                                                                      .text
                                                                      .isNotEmpty
                                                                  ? IconButton(
                                                                      onPressed:
                                                                          () {
                                                                        editprovider
                                                                            .editNumber
                                                                            .clear();
                                                                      },
                                                                      icon: Icon(
                                                                          Icons
                                                                              .clear),
                                                                    )
                                                                  : null,
                                                            ),
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                          ),
                                                          SizedBox(
                                                            height: 15,
                                                          ),
                                                          TextFormField(
                                                            controller:
                                                                editprovider
                                                                    .editChat,
                                                            decoration:
                                                                InputDecoration(
                                                              prefixIcon: Icon(Icons
                                                                  .chat_outlined),
                                                              labelText:
                                                                  'Enter Chat Conversation',
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  style:
                                                                      BorderStyle
                                                                          .solid,
                                                                  color: Colors
                                                                      .black,
                                                                  width: 4,
                                                                ),
                                                              ),
                                                              suffixIcon: editprovider
                                                                      .editChat
                                                                      .text
                                                                      .isNotEmpty
                                                                  ? IconButton(
                                                                      onPressed:
                                                                          () {
                                                                        editprovider
                                                                            .editChat
                                                                            .clear();
                                                                      },
                                                                      icon: Icon(
                                                                          Icons
                                                                              .clear),
                                                                    )
                                                                  : null,
                                                            ),
                                                            keyboardType:
                                                                TextInputType
                                                                    .text,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    right: 158),
                                                            child: Text(
                                                                "Choose Date"),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    right: 158),
                                                            child: Text(
                                                                "Choose Time"),
                                                          ),
                                                          InkWell(
                                                            onTap: () async {
                                                              time =
                                                                  await showTimePicker(
                                                                context:
                                                                    context,
                                                                initialTime:
                                                                    TimeOfDay
                                                                        .now(),
                                                              );
                                                              print(
                                                                  time?.format(
                                                                      context));
                                                              if (time !=
                                                                  null) {
                                                                datepicker =
                                                                    DateTime(
                                                                  DateTime.now()
                                                                      .year,
                                                                  DateTime.now()
                                                                      .month,
                                                                  DateTime.now()
                                                                      .day,
                                                                  time!.hour,
                                                                  time!.minute,
                                                                );
                                                                setState(() {
                                                                  formateTime = DateFormat(
                                                                          'HH:mm')
                                                                      .format(
                                                                          datepicker!);
                                                                });
                                                                print(
                                                                    formateTime);
                                                              }
                                                            },
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Row(
                                                                children: [
                                                                  Icon(Icons
                                                                      .access_time),
                                                                  (formateTime ==
                                                                          null)
                                                                      ? Text(
                                                                          editprovider
                                                                              .editTime,
                                                                          style:
                                                                              TextStyle(fontSize: 14),
                                                                        )
                                                                      : Text(
                                                                          formateTime!,
                                                                          style:
                                                                              TextStyle(fontSize: 14),
                                                                        ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                            children: [
                                                              OutlinedButton(
                                                                onPressed: () {
                                                                  PersonModel
                                                                      edit =
                                                                      PersonModel(
                                                                    name: editprovider
                                                                        .editName
                                                                        .text,
                                                                    number: editprovider
                                                                        .editNumber
                                                                        .text,
                                                                    chat: editprovider
                                                                        .editChat
                                                                        .text,
                                                                    image: editprovider
                                                                        .editImage,
                                                                    date: (formatedDate ==
                                                                            null)
                                                                        ? person
                                                                            .date
                                                                        : DateFormat('dd/MM/yyyy')
                                                                            .parse(formatedDate!),
                                                                    time: (formateTime ==
                                                                            null)
                                                                        ? person
                                                                            .time
                                                                        : TimeOfDay.fromDateTime(
                                                                            DateFormat('HH:mm').parse(formateTime!)),
                                                                  );
                                                                  editprovider
                                                                      .editContactData(
                                                                          edit,
                                                                          index);

                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                  editprovider
                                                                          .editImage =
                                                                      null;
                                                                  editprovider
                                                                          .editTime =
                                                                      null;
                                                                  editprovider
                                                                          .editDate =
                                                                      null;
                                                                },
                                                                child: Text(
                                                                    'EDIT'),
                                                              ),
                                                              OutlinedButton(
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                                child: Text(
                                                                    'CANCEL'),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            icon: Icon(Icons.edit),
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            editprovider
                                                .deleteContactData(index);
                                            Navigator.of(context).pop();
                                          },
                                          icon: Icon(Icons.delete),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    OutlinedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                          'Cancel',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ))
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        leading: CircleAvatar(
                          child: person.image != null
                              ? null
                              : Text(
                                  person.name != null && person.name!.isNotEmpty
                                      ? person.name![0].toUpperCase()
                                      : "",
                                ),
                          backgroundImage: person.image != null
                              ? FileImage(person.image!)
                              : null,
                        ),
                        title: Text(person.name ?? ""),
                        subtitle: Text(person.number ?? ""),
                        trailing: Text(
                          "${DateFormat('dd/MM/yyyy').format(person.date)}, ${person.time.format(context)}",
                          style: TextStyle(fontSize: 13),
                        ),
                      );
                    },
                  );
          },
        ),
      );
    } else {
      return SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: editprovider.personList.isEmpty
                  ? Center(child: Text('No any chats yet...'))
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: editprovider.personList.length,
                      itemBuilder: (context, index) {
                        return CupertinoListTile(
                          onTap: () {
                            showCupertinoModalPopup(
                              context: context,
                              builder: (context) {
                                return Container(
                                  height: 340,
                                  width: double.infinity,
                                  color: Colors.white,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      CircleAvatar(
                                        radius: 60,
                                        child: editprovider
                                                    .personList[index].image !=
                                                null
                                            ? null
                                            : Text(
                                                editprovider.personList[index]
                                                                .name !=
                                                            null &&
                                                        editprovider
                                                            .personList[index]
                                                            .name!
                                                            .isNotEmpty
                                                    ? editprovider
                                                        .personList[index]
                                                        .name![0]
                                                        .toUpperCase()
                                                    : "",
                                              ),
                                        backgroundImage: editprovider
                                                    .personList[index].image !=
                                                null
                                            ? FileImage(editprovider
                                                .personList[index].image!)
                                            : null,
                                      ),
                                      Text(editprovider.personList[index].name!,style: TextStyle(color: Colors.black),),
                                      Text(editprovider.personList[index].chat!,style: TextStyle(color: Colors.black),),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CupertinoButton(
                                              child: Icon(
                                                Icons.edit,
                                                size: 30,
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                if(editprovider.editImage==null)
                                                editprovider.editName.text =
                                                    editprovider
                                                        .personList[index]
                                                        .name!;
                                                editprovider.editNumber.text =
                                                    editprovider
                                                        .personList[index]
                                                        .number!;
                                                editprovider.editChat.text =
                                                    editprovider
                                                        .personList[index]
                                                        .chat!;
                                                editprovider.editImage =
                                                    editprovider
                                                        .personList[index]
                                                        .image!;
                                                editprovider.editDate =
                                                    editprovider
                                                        .personList[index]
                                                        .date!;
                                                editprovider.editTime =
                                                    editprovider
                                                        .personList[index]
                                                        .time!;
                                                editprovider.editIndex = index;

                                                showCupertinoDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return CupertinoAlertDialog(
                                                      content: Container(
                                                        height: 420,
                                                        width: double.infinity,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Column(
                                                              children: [
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    editprovider
                                                                        .editCamera();
                                                                  },
                                                                  child:
                                                                      CircleAvatar(
                                                                    radius: 60,
                                                                    child: (editprovider.editImage !=
                                                                            null)
                                                                        ? null
                                                                        : (editprovider.editName != null &&
                                                                                editprovider.editName.text.isNotEmpty
                                                                            ? Text(editprovider.editName.text[0].toUpperCase())
                                                                            : Text("")),
                                                                    backgroundImage: (editprovider.editImage !=
                                                                            null)
                                                                        ? FileImage(
                                                                            editprovider.editImage!)
                                                                        : null,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                CupertinoTextFormFieldRow(
                                                                  controller:
                                                                      editprovider
                                                                          .editName,
                                                                  prefix: Icon(
                                                                    Icons
                                                                        .person_outline_outlined,
                                                                    size: 30,
                                                                  ),
                                                                  placeholder:
                                                                      'Enter Full Name',
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .text,
                                                                ),
                                                                CupertinoTextFormFieldRow(
                                                                  controller:
                                                                      editprovider
                                                                          .editNumber,
                                                                  prefix: Icon(
                                                                    CupertinoIcons
                                                                        .phone,
                                                                    size: 30,
                                                                  ),
                                                                  placeholder:
                                                                      'Enter Phone Number',
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .number,
                                                                ),
                                                                CupertinoTextFormFieldRow(
                                                                  controller:
                                                                      editprovider
                                                                          .editChat,
                                                                  prefix: Icon(
                                                                    CupertinoIcons
                                                                        .chat_bubble_text,
                                                                    size: 30,
                                                                  ),
                                                                  placeholder:
                                                                      'Enter Chat Conversation',
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .text,
                                                                ),
                                                                SizedBox(
                                                                  height: 6,
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    GestureDetector(
                                                                      onTap: () async {
                                                                        date = await showDatePicker(
                                                                          context: context,
                                                                          firstDate: DateTime(1990),
                                                                          lastDate: DateTime(3000),
                                                                          initialDate: DateTime.now(),
                                                                        );
                                                                        if (date != null) {
                                                                          setState(() {
                                                                            formatedDate = DateFormat('dd/MM/yyyy')
                                                                                .format(date!);
                                                                          });
                                                                        }
                                                                      },
                                                                      child: Padding(
                                                                        padding: const EdgeInsets.all(8.0),
                                                                        child: Row(
                                                                          children: [
                                                                            Icon(Icons.date_range_outlined),
                                                                            (formatedDate == null)
                                                                                ? Text(
                                                                              editprovider.editDate,
                                                                              style: TextStyle(fontSize: 14),
                                                                            )
                                                                                : Text(
                                                                              formatedDate!,
                                                                              style: TextStyle(fontSize: 14),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    if (formatedDate != null)
                                                                      IconButton(
                                                                        onPressed: () {
                                                                          setState(() {
                                                                            formatedDate = null;
                                                                          });
                                                                        },
                                                                        icon: Icon(Icons.clear),
                                                                      ),
                                                                  ],
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets.only(right: 158),
                                                                  child: Text("Choose Time"),
                                                                ),
                                                                SizedBox(
                                                                  height: 10,

                                                                ),
                                                                SizedBox(
                                                                  height: 7,
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceEvenly,
                                                                  children: [
                                                                    OutlinedButton(
                                                                        onPressed:
                                                                            () {
                                                                          PersonModel
                                                                              edit =
                                                                              PersonModel(
                                                                            name:
                                                                                editprovider.editName.text,
                                                                            number:
                                                                            editprovider.editNumber.text,
                                                                            chat:
                                                                            editprovider.editChat.text,
                                                                            image:
                                                                            editprovider.editImage,
                                                                            date: (iosDate == null)
                                                                                ? editprovider.editDate
                                                                                : iosDate,
                                                                            time: (iosTime == null)
                                                                                ? editprovider.editTime
                                                                                : iosTime,
                                                                          );
                                                                          editprovider.editContactData(
                                                                              edit,
                                                                              index);

                                                                          Navigator.of(context)
                                                                              .pop();
                                                                          editprovider.editImage =
                                                                              null;
                                                                          editprovider.editTime =
                                                                              null;
                                                                          editprovider.editDate =
                                                                              null;
                                                                        },
                                                                        child: Text(
                                                                            'EDIT')),
                                                                    OutlinedButton(
                                                                        child: Text(
                                                                            'CANCEL'),
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                        })
                                                                  ],
                                                                ),
                                                              ]),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              }),
                                          CupertinoButton(
                                              child: Icon(
                                                Icons.delete,
                                                size: 30,
                                              ),
                                              onPressed: () {
                                                editprovider
                                                    .deleteContactData(index);
                                                Navigator.of(context).pop();
                                              }),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      OutlinedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            'Cancel',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ))
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          leadingSize: 60,
                          leadingToTitle: 20,
                          padding: EdgeInsets.all(5),
                          title: Text(
                            editprovider.personList[index].name!,
                            style: TextStyle(fontSize: 18),
                          ),
                          subtitle: Text(
                            editprovider.personList[index].chat!,
                            style: TextStyle(fontSize: 16),
                          ),
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundImage:
                                editprovider.personList[index].image != null
                                    ? FileImage(
                                        editprovider.personList[index].image!)
                                    : null,
                          ),
                          trailing: Row(
                            children: [
                              Text(
                                  "${DateFormat('dd/MM/yyyy').format(editprovider.personList[index].date)}"),
                              Text(', '),
                              Text(
                                formatTime(editprovider.personList[index].time),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            )
          ],
        ),
      );
    }
  }
}
