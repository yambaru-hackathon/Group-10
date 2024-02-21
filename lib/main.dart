import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'database.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    String group = '';
    String task = '';
    String deadline = '';
    String data = '';

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            TextField(
              decoration: InputDecoration(
                hintText: 'Group',
              ),
              onChanged: (text){
                group = text;
              },
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'task',
              ),
              onChanged: (text){
                task = text;
              },
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'deadline',
              ),
              onChanged: (text){
                deadline = text;
              },
            ),
            ElevatedButton(
              onPressed: (){
                final service = Database();
                service.create(group, task, deadline);
              }, 
              child: Text('追加')
            ),
            ElevatedButton(
              onPressed: (){
                final service = Database();
                data = service.read(group, task).toString();
              }, 
              child: Text('表示')
            ),
            Text('test'),
          ],
        ),
      ),
      );
  }
}
