import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; // Import Material package
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../controller/main_provider.dart';
import '../controller/person_provider.dart';

class Settingpage extends StatefulWidget {
  final int? index;

  Settingpage({Key? key, this.index}) : super(key: key);

  @override
  State<Settingpage> createState() => _SettingpageState();
}

class _SettingpageState extends State<Settingpage> {
  File? image;

  @override

  Future<void> _pickImage() async {
    XFile? file = await ImagePicker().pickImage(source: ImageSource.camera);

    if (file != null) {
      setState(() {
        image = File(file.path);
        Provider.of<PersonProvider>(context, listen: false).setImage(file.path);
      });
    } else {
      print('User cancelled capturing image Camera');
    }
  }

  @override
  Widget build(BuildContext context) {
    var isAndroid = Provider.of<MainProvider>(context, listen: false).isAndroid;
    final editprovider = Provider.of<PersonProvider>(context, listen: true);

    if (!isAndroid) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: Icon(Icons.person),
                title: Text(
                  "Profile",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                subtitle:
                    Text("Update Profile Data", style: TextStyle(fontSize: 15)),
                trailing: Switch(
                  value: editprovider.isProfile ?? false,
                  onChanged: (newValue) {
                    editprovider.showProfile(newValue);
                  },
                ),
              ),
              Visibility(
                visible: editprovider.isProfile ?? false,
                child: Container(
                  height: 350,
                  child: Column(
                    children: [
                      InkWell(
                        onTap: _pickImage,
                        child: CircleAvatar(
                          radius: 50,
                          child: image != null ? null : Icon(Icons.camera_alt),
                          backgroundImage: image != null
                              ? FileImage(image!)
                              : editprovider.imagePath != null
                                  ? FileImage(File(editprovider.imagePath!))
                                  : null,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20,right: 20),
                        child: TextFormField(
                          controller: editprovider.NameController,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: "Name",
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20,right: 20),
                        child: TextFormField(
                          controller: editprovider.BioController,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: "Bio",
                          ),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              editprovider.NameController.clear();
                              editprovider.BioController.clear();
                              setState(() {
                                image = null;
                                editprovider.clearImage();
                              });
                            },
                            child: Text(
                              "Reset",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              var snackbar =
                                  SnackBar(content: Text('SAVE PROFILE DATA'));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackbar);
                            },
                            child: Text(
                              "Save",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Divider(),
              ),
              Consumer<MainProvider>(
                builder: (context, mainProvider, child) {
                  return ListTile(
                    leading: Icon(Icons.brightness_6),
                    title: Text("Theme"),
                    subtitle: Text("Change Theme"),
                    trailing: Switch(
                      value: mainProvider.Android_Theme_Mode ?? false,
                      onChanged: (newValue) {
                        mainProvider.change_Android_Theme();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      );
    }else {
      return CupertinoPageScaffold(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Consumer<PersonProvider>(
                builder: (BuildContext context, value, Widget? child) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 80),
                    child: CupertinoListSection(
                      header: Text("Set Platform".toUpperCase()),
                      children: [
                        CupertinoListTile(
                          padding: EdgeInsets.all(15),
                          leading: Icon(CupertinoIcons.person),
                          title: Text("Profile"),
                          subtitle: Text("Update Profile Data"),
                          trailing: CupertinoSwitch(
                            value: value.isProfile ?? false,
                            onChanged: (newValue) {
                              Provider.of<PersonProvider>(context, listen: false)
                                  .showProfile(newValue);
                            },
                          ),
                        ),
                        SizedBox(height: 20,),
                        Visibility(
                          visible: value.isProfile ?? false,
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: _pickImage,
                                child: CircleAvatar(
                                  radius: 50,
                                  child: image != null ? null : Icon(Icons.camera_alt),
                                  backgroundImage: image != null
                                      ? FileImage(image!)
                                      : editprovider.imagePath != null
                                      ? FileImage(File(editprovider.imagePath!))
                                      : null,
                                ),
                              ),
                              SizedBox(height: 30,),
                              Padding(
                                padding: const EdgeInsets.only(left: 20,right: 20),
                                child: CupertinoTextField(
                                  controller: editprovider.NameController,
                                  decoration: BoxDecoration(
                                    color: CupertinoColors.lightBackgroundGray
                                        .withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  placeholder: "Name",
                                ),
                              ),
                              SizedBox(height: 15), // Add some spacing
                              Padding(
                                padding: const EdgeInsets.only(left: 20,right: 20),
                                child: CupertinoTextField(
                                  controller: editprovider.BioController,
                                  decoration: BoxDecoration(
                                    color: CupertinoColors.lightBackgroundGray
                                        .withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  placeholder: "Bio",
                                ),
                              ),
                              SizedBox(height: 20), // Add some spacing
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CupertinoButton(
                                    onPressed: () {
                                      editprovider.NameController.clear();
                                      editprovider.BioController.clear();
                                      editprovider.clearImage();
                                    },
                                    child: Text(
                                      "Reset",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  SizedBox(width: 20), // Add some spacing
                                  CupertinoButton(
                                    onPressed: () {
                                      if (editprovider.NameController
                                          .text.isNotEmpty &&
                                          editprovider.BioController
                                              .text.isNotEmpty) {
                                        Provider.of<PersonProvider>(context,
                                            listen: false)
                                            .setProfile(
                                            editprovider.NameController.text,
                                            editprovider.BioController.text);

                                        showCupertinoModalPopup(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return CupertinoActionSheet(
                                                title: Text("Saved!!!"),
                                                cancelButton:
                                                CupertinoActionSheetAction(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text("Ok"),
                                                ),
                                              );
                                            });
                                        print(
                                            "Name= ${editprovider.NameController.text} AND Bio= ${editprovider.BioController.text}");
                                      } else {
                                        print("Field is Blank");
                                      }
                                    },
                                    child: Text(
                                      "Save",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Consumer<MainProvider>(
                          builder: (context, mainProvider, child) {
                            return CupertinoListTile(
                              leading: Icon(CupertinoIcons.brightness),
                              title: Text("Theme"),
                              subtitle: Text("Change Theme"),
                              trailing: CupertinoSwitch(
                                value: mainProvider.Android_Theme_Mode ?? false,
                                onChanged: (newValue) {
                                  mainProvider.change_Android_Theme();
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    }

  }
}
