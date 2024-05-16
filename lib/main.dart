  import 'package:flutter/cupertino.dart';
  import 'package:flutter/material.dart';
import 'package:platform_converter/controller/person_provider.dart';
  import 'package:provider/provider.dart';

  import 'view/home_page.dart';
  import 'controller/main_provider.dart';

  void main() {
    runApp(MyApp());
  }

  class MyApp extends StatefulWidget {
    const MyApp({Key? key}) : super(key: key);

    @override
    State<MyApp> createState() => _MyAppState();
  }

  class _MyAppState extends State<MyApp> {
    @override
    Widget build(BuildContext context) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => MainProvider()),
          ChangeNotifierProvider(create: (context) => PersonProvider(),)
        ],
        builder: (context, child) {
          return Consumer<MainProvider>(
            builder: (BuildContext context, MainProvider value, Widget? child) {
              if (value.isAndroid) {
                return CupertinoApp(
                  debugShowCheckedModeBanner: false,
                  initialRoute: "/",
                  theme: value.Android_Theme_Mode
                      ? CupertinoThemeData(brightness: Brightness.dark)
                      : CupertinoThemeData(brightness: Brightness.light),
                  routes: {
                    "/": (context) => IosHomePage(),
                  },
                );

              } else {
                return  Consumer<MainProvider>(
                  builder: (BuildContext context, MainProvider value, Widget? child) {
                    return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    initialRoute: "/",
                    theme: value.Android_Theme_Mode
                        ? ThemeData(brightness: Brightness.dark)
                        : ThemeData(brightness: Brightness.light),
                    routes: {
                      "/": (context) => AndroidHomePage(),
                    },
                  );
                  },
                );
              }
            },
          );
        },
      );
    }
  }


