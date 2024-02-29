import 'package:first/database.dart';
import 'package:flutter/material.dart';

class Addurl extends StatelessWidget {
  Addurl({super.key, required this.group, required this.task});
  final url = TextEditingController();
  String group;
  String task;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
          title: const Center(child: Text('リンクを追加')),
          backgroundColor: const Color.fromRGBO(189, 255, 255, 1)),
      body: ListView(
        padding: EdgeInsets.only(left: 60, right: 60),
        children: [
          SizedBox(height: 20),
          Text(
            'リンク',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 60,
            width: 300,
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
              controller: url,
            ),
          ),
          SizedBox(height: 40),
          ElevatedButton(
              onPressed: () async {
                await Database().addurl(group, task, url.text);
                Navigator.of(context).pop();
              },
              child: Text(
                '追加',
                style: TextStyle(fontSize: 30, color: Colors.black),
              ))
        ],
      ),
    ));
  }
}
