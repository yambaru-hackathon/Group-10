import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class task_list_338 extends StatefulWidget {
  const task_list_338({super.key});

  @override
  State<task_list_338> createState() => _task_list_338State();
}

bool menu1_open = false; //グループ分けのやつ
bool menu2_open = false; //並び替えのやつ

Widget _buildBackground() {
  return Container(
    width: double.infinity,
    height: double.infinity,
    color: Colors.black12,
  );
}

Widget _buildFloatingActionButton() {
  return GestureDetector(
    onTap: () {},
    child: Container(
      height: 54,
      width: 54,
      margin: const EdgeInsets.only(right: 17, bottom: 50),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(50),
      ),
      child: const Icon(Icons.add, size: 25, color: Colors.white),
    ),
  );
}

class _task_list_338State extends State<task_list_338> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "課題一覧",
            textAlign: TextAlign.end,
          ),
          backgroundColor: const Color.fromARGB(255, 54, 171, 244),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      child: const Text(
                        "＋",
                        style: TextStyle(color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 201, 223, 233),
                          shape: BeveledRectangleBorder(side: BorderSide.none)),
                      onPressed: () {},
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: ElevatedButton.icon(
                      icon: const Icon(
                        Icons.expand_more,
                        color: Colors.black,
                      ),
                      label: const Text("全部",
                          style: TextStyle(color: Colors.black)),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 160, 214, 237),
                          shape: BeveledRectangleBorder(side: BorderSide.none)),
                      onPressed: () {},
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.expand_more, color: Colors.black),
                      label: const Text("難易度準(難)",
                          style: TextStyle(color: Colors.black)),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 109, 202, 236),
                          shape: BeveledRectangleBorder(side: BorderSide.none)),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: Column(
          children: [
            FloatingActionButton(
              onPressed: () {},
              backgroundColor: Color.fromARGB(255, 241, 249, 0),
              child: Icon(
                Icons.groups,
                color: Colors.black,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(180)),
            ),
            FloatingActionButton(
              onPressed: () {},
              backgroundColor: Colors.red,
              child: Icon(
                Icons.calendar_month,
                color: Colors.black,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(180)),
            ),
          ],
        ),
        bottomNavigationBar: SingleChildScrollView(),
      ),
    );
  }
}
