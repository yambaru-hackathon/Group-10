import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'addtask.dart';
import 'list_ui.dart';
import 'newgroup.dart';

class task_list extends StatelessWidget {
  const task_list({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: task_list_338());
  }
}

class task_list_338 extends StatefulWidget {
  const task_list_338({super.key});

  @override
  State<task_list_338> createState() => _task_list_338State();
}

String dropdownVal1 = "short";
String dropdownVal2 = "all";
final _items = [];
final GlobalKey<AnimatedListState> _key = GlobalKey();

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
  List work_list = [];
  String group = "";
  bool sort = false;
  WebViewController? webViewController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadCounter();
    adding();
  }

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.reload();
    setState(() async {
      group = prefs.getString('name') ?? '';
      await prefs.reload();
    });
  }

  void adding() async {
    debugPrint(sort.toString());
    List Work_list = await Database().docread(group, sort);
    setState(() {
      work_list = Work_list;
    });
  }

  Future<Widget> _text(String task) async {
    Timestamp data = await Database().fldread(group, task, "deadline");
    DateTime datetime = data.toDate();

    return Text("${datetime.year}/${datetime.month}/${datetime.day}",
        style: TextStyle(color: Colors.black));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "課題一覧",
          textAlign: TextAlign.end,
        ),
        backgroundColor: const Color.fromARGB(255, 54, 171, 244),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => newgroup()),
              ).then((value) {
                setState(() {
                  _loadCounter();
                  webViewController!.reload();
                });
              });
            },
            backgroundColor: Color.fromARGB(255, 228, 228, 228),
            child: Icon(
              Icons.groups,
              color: Colors.black,
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(180)),
          ),
          FloatingActionButton(
            onPressed: () {},
            backgroundColor: Color.fromARGB(255, 228, 228, 228),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      child: const Text(
                        "＋",
                        style: TextStyle(color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 201, 223, 233),
                          shape: BeveledRectangleBorder(side: BorderSide.none)),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddTask(group: [group])),
                        );
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    color: Color.fromARGB(255, 169, 201, 228),
                    child: DropdownButton(
                      underline: Container(
                        height: 0,
                      ),
                      value: dropdownVal2,
                      icon: const Icon(Icons.expand_more, color: Colors.black),
                      style: const TextStyle(color: Colors.black),
                      dropdownColor: Color.fromARGB(255, 169, 201, 228),
                      onChanged: (String? newVal2) {
                        setState(() {
                          dropdownVal2 = newVal2!;
                        });
                      },
                      items: const [
                        DropdownMenuItem<String>(
                          value: "all",
                          child: Text("全部"),
                        ),
                        DropdownMenuItem<String>(
                          value: "grupe",
                          child: Text("グループ"),
                        ),
                        DropdownMenuItem<String>(
                          value: "medea",
                          child: Text("メディあ"),
                        ),
                        DropdownMenuItem<String>(
                          value: "engin",
                          child: Text("機械"),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    color: Color.fromARGB(255, 130, 185, 230),
                    child: DropdownButton(
                      underline: Container(
                        height: 0,
                      ),
                      value: dropdownVal1,
                      icon: const Icon(Icons.expand_more, color: Colors.black),
                      style: const TextStyle(color: Colors.black),
                      dropdownColor: Color.fromARGB(255, 130, 185, 230),
                      onChanged: (String? newVal1) {
                        setState(() {
                          dropdownVal1 = newVal1!;
                          if (newVal1 == 'short') {
                            sort = false;
                          } else if (newVal1 == 'long') {
                            sort = true;
                          }
                          adding();
                        });
                      },
                      items: const [
                        DropdownMenuItem<String>(
                          value: "short",
                          child: Text("期限表示(短)"),
                        ),
                        DropdownMenuItem<String>(
                          value: "long",
                          child: Text("期限表示(長)"),
                        ),
                        DropdownMenuItem<String>(
                          value: "hard",
                          child: Text("難易度準(難)"),
                        ),
                        DropdownMenuItem<String>(
                          value: "ez",
                          child: Text("難易度準(簡)"),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Column(
                children: work_list.map(
              (work) {
                return TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ListUiWidget(
                                  group: group,
                                  task: work,
                                )),
                      );
                    },
                    child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(30),
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      work,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ]),
                              Spacer(
                                flex: 1,
                              ),
                              FutureBuilder(
                                future: _text(work),
                                builder: (BuildContext context,
                                    AsyncSnapshot<Widget> snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    return Text(
                                      'Error: ${snapshot.error}',
                                      style: TextStyle(color: Colors.black),
                                    );
                                  } else {
                                    return snapshot.data!;
                                  }
                                },
                              ),
                            ],
                          ),
                        )));
              },
            ).toList())
          ],
        ),
      ),
    );
  }
}
