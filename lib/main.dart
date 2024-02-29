import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'database.dart';
import 'list_ui.dart';
import 'newgroup.dart';
import 'task_list.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const newgroup());
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
    String url = '';
    String field = '';
    String newdata = '';
    var data = [];
    List doclist = [];

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Group',
              ),
              onChanged: (text) {
                group = text;
              },
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'task',
              ),
              onChanged: (text) {
                task = text;
              },
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'deadline',
              ),
              onChanged: (text) {
                deadline = text;
              },
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'url',
              ),
              onChanged: (text) {
                url = text;
              },
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'field',
              ),
              onChanged: (text) {
                field = text;
              },
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'newdata',
              ),
              onChanged: (text) {
                newdata = text;
              },
            ),
            ElevatedButton(
                onPressed: () {
                  final service = Database();
                  Database().create(group, task, deadline, url, 0);
                },
                child: Text('追加')),
            ElevatedButton(
                onPressed: () {
                  Database().addurl(group, task, url);
                },
                child: Text('url追加')),
            ElevatedButton(
                onPressed: () {
                  Database().delurl(group, task, url);
                },
                child: Text('url削除')),
            ElevatedButton(
                onPressed: () {
                  setState(() async {
                    data = await Database().fldread(group, task, field);
                    debugPrint(data.toString());
                  });
                },
                child: Text('読み込み')),
            ElevatedButton(
                onPressed: () async {
                  //doclist = await Database().docread(group);
                  debugPrint(doclist.toString());
                },
                child: Text('task一覧')),
            ElevatedButton(
                onPressed: () {
                  Database().update(group, task, field, newdata);
                },
                child: Text('更新')),
            ElevatedButton(
                onPressed: () {
                  final service = Database();
                  service.delete(group, task);
                },
                child: Text('削除')),
          ],
        ),
      ),
    );
  }
}
