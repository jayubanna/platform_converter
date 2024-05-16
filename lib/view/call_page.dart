import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controller/main_provider.dart';
import '../controller/person_provider.dart';
import '../model/person_model.dart';

class Callpage extends StatefulWidget {
  const Callpage({super.key});

  @override
  State<Callpage> createState() => _CallpageState();
}

class _CallpageState extends State<Callpage> {
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
                    child: Text("No any call yet..."),
                  )
                : ListView.builder(
                    itemCount: value.personList.length,
                    itemBuilder: (context, index) {
                      PersonModel person = value.personList[index];
                      return ListTile(
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
                        subtitle: Text(person.chat ?? ""),
                        trailing: InkWell(
                            onTap: () {
                              launchUrl(Uri.parse("tel:${person.number}"));
                            },
                            child: Icon(
                              Icons.call,
                              color: Colors.green,
                            )),
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
              child: (editprovider.personList.isEmpty)
                  ? Center(child: Text('No any calls yet...'))
                  : ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: editprovider.personList.length,
                itemBuilder: (context, index) {
                  return CupertinoListTile(
                    leadingSize: 60,
                    leadingToTitle: 20,
                    padding: EdgeInsets.all(5),
                    title: Text(editprovider.personList[index].name!,
                        style: TextStyle(fontSize: 18)),
                    subtitle: Text(editprovider.personList[index].chat!,
                        style: TextStyle(fontSize: 16)),
                    leading: CircleAvatar(
                      radius: 60,
                      child: editprovider.personList[index].image != null
                          ? null
                          : Text(
                        editprovider.personList[index].name != null && editprovider.personList[index].name!.isNotEmpty
                            ? editprovider.personList[index].name![0].toUpperCase()
                            : "",
                      ),
                      backgroundImage: editprovider.personList[index].image != null
                          ? FileImage(editprovider.personList[index].image!)
                          : null,
                    ),
                    trailing: CupertinoButton(
                        onPressed: () async {
                          final Uri url = Uri(
                            scheme: 'tel',
                            path: editprovider.personList[index].number,
                          );
                          if (await canLaunch(url.toString())) {
                            await launch(url.toString());
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                        child: Icon(
                          CupertinoIcons.phone,
                          size: 28,
                        )),
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
