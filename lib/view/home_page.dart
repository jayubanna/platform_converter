import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_converter/controller/main_provider.dart';
import 'package:platform_converter/view/person_page.dart';
import 'package:platform_converter/view/setting_page.dart';
import 'package:provider/provider.dart';

import 'call_page.dart';
import 'chat_page.dart';

class AndroidHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Platform Converter"),
          actions: [
            Consumer<MainProvider>(
              builder: (context, mainProvider, child) {
                return Switch(
                  value: mainProvider.isAndroid,
                  onChanged: (value) {
                    mainProvider.changePlatform(value);
                  },
                );
              },
            ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.person_add_alt_rounded)),
              Tab(text: "CHATS"),
              Tab(text: "CALLS"),
              Tab(text: "SETTINGS"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Personpage(),
            Chatpage(),
            Callpage(),
            Settingpage(),
          ],
        ),
      ),
    );
  }
}

class IosHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("Platform Converter"),
        trailing: Consumer<MainProvider>(
          builder: (context, mainProvider, child) {
            return CupertinoSwitch(
              value: mainProvider.isAndroid,
              onChanged: (value) {
                mainProvider.changePlatform(value);
              },
            );
          },
        ),
      ),
      child: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person_add_solid),
              label: 'Person',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.chat_bubble_2),
              label: 'Chats',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.call),
              label: 'Calls',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.settings),
              label: 'Settings',
            ),
          ],
        ),
        tabBuilder: (context, index) {
          List<Widget> tabList = [
            Personpage(),
            Chatpage(),
            Callpage(),
            Settingpage(),
          ];
          return CupertinoTabView(
            builder: (context) {
              return tabList[index];
            },
          );
        },
      ),
    );
  }
}
