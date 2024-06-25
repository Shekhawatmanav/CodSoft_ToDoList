import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_flutter/pages/home_page.dart';

void main() async {

  //init hive
  await Hive.initFlutter();

  var box  = await Hive.openBox('mybox');


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     
          debugShowCheckedModeBanner: false,
          home : HomePage(),
          theme: ThemeData(useMaterial3: false,primarySwatch: Colors.deepPurple),
    );
    
  }
}
