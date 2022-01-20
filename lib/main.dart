import 'package:demo/API/UserSheetsAPI.dart';
import 'package:demo/UI/HomePage.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserSheetsAPI.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Google Sheets',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const CreateSheetPage());
  }
}

